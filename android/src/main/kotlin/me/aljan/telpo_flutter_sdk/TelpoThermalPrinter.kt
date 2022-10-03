package me.aljan.telpo_flutter_sdk

import android.annotation.SuppressLint
import android.content.Context
import android.os.Handler
import android.os.Looper
import android.os.Message
import android.util.Log
import com.telpo.tps550.api.printer.UsbThermalPrinter

class TelpoThermalPrinter(activity: TelpoFlutterSdkPlugin) {
    private val TAG = "TelpoThermalPrinter"
    private var mUsbThermalPrinter: UsbThermalPrinter? = null
    private var utils: Utils
    private val context: Context = activity.context
    private var errorResult: String? = null
    private var result: MethodChannelResultWrapper? = null

    private var noPaper = false
    private var printDataArray: ArrayList<Map<String, Any>> = ArrayList()

    // HandlerCodes
    private val NOPAPER = 3
    private val LOWBATTERY = 4
    private val PRINT = 9
    private val CANCELPROMPT = 10
    private val PRINTERR = 11
    private val OVERHEAT = 12
    private val DEVICETRANSMITDATA = 13

    // StatusCodes
    private val STATUS_OK = 0
    private val STATUS_NO_PAPER = 16
    private val STATUS_OVER_HEAT = 2 // Printer engine is overheating
    private val STATUS_OVER_FLOW = 3 // Printer's cache is full
    private val STATUS_UNKNOWN = 4

    // Exceptions
    private val NOPAPEREXCEPTION = "com.telpo.tps550.api.printer.NoPaperException"
    private val OVERHEATEXCEPTION = "com.telpo.tps550.api.printer.OverHeatException"
    private val DEVICETRANSMITDATAEXCEPTION =
        "com.telpo.tps550.api.printer.DeviceTransmitDataException"

    init {
        mUsbThermalPrinter = UsbThermalPrinter(context)
        utils = Utils()
    }

    @SuppressLint("HandlerLeak")
    inner class PrintHandler : Handler(Looper.getMainLooper()) {
        override fun handleMessage(msg: Message) {
            when (msg.what) {
                NOPAPER -> {
                    result?.error("3", "No paper, please put paper in and retry", null)
                    return
                }
                LOWBATTERY -> {
                    result?.error("4", "Low battery", null)
                    return
                }
                PRINT -> {
                    Print().start()
                }
                CANCELPROMPT -> {
                    Log.d(TAG, "Cancel", null)
                }
                OVERHEAT -> {
                    result?.error("12", "Overheat error", null)
                    return
                }
                DEVICETRANSMITDATA -> {
                    result?.error("13", "Device Transmit Data Exception", null)
                }
            }
        }
    }

    fun checkStatus(result: MethodChannelResultWrapper, lowBattery: Boolean) {
        try {
            this.result = result

            when (mUsbThermalPrinter?.checkStatus()) {
                STATUS_OK -> {
                    if (lowBattery) {
                        PrintHandler().sendMessage(
                            PrintHandler().obtainMessage(
                                LOWBATTERY,
                                1,
                                0,
                                null
                            )
                        )
                    } else {
                        result.success("STATUS_OK")
                    }
                }
                STATUS_NO_PAPER -> {
                    result.success("STATUS_NO_PAPER")
                    return
                }
                STATUS_UNKNOWN -> {
                    result.success("STATUS_UNKNOWN")
                    return
                }
                STATUS_OVER_FLOW -> {
                    result.success("STATUS_OVER_FLOW")
                    return
                }
                STATUS_OVER_HEAT -> {
                    result.success("STATUS_OVER_HEAT")
                    return
                }
            }
        } catch (e: Exception) {
            e.printStackTrace()
            Log.e(TAG, "$e")
            result.error("CheckStatusException", "$e", null)
            return
        }
    }

    fun connect(): Boolean {
        return try {
            mUsbThermalPrinter?.start(0)
            mUsbThermalPrinter?.reset()
            true
        } catch (e: Exception) {
            e.printStackTrace()
            result?.error("Printer Start Error", e.message, e.stackTrace)
            false
        }
    }

    fun disconnect(): Boolean {
        return try {
            mUsbThermalPrinter?.reset()
            mUsbThermalPrinter?.stop()
            true
        } catch (e: Exception) {
            e.printStackTrace()
            result?.error("Printer Disconnect Error", e.message, e.stackTrace)
            false
        }
    }

    fun print(
        result: MethodChannelResultWrapper,
        printDataArray: ArrayList<Map<String, Any>>,
        lowBattery: Boolean
    ) {
        this.printDataArray = printDataArray
        this.result = result

        if (lowBattery) {
            PrintHandler().sendMessage(PrintHandler().obtainMessage(LOWBATTERY, 1, 0, null))
        }
        //
        else {
            if (noPaper) {
                PrintHandler().sendMessage(PrintHandler().obtainMessage(NOPAPER, 1, 0, null))
            } else {
                PrintHandler().sendMessage(PrintHandler().obtainMessage(PRINT, 1, 0, null))
            }
        }
    }

    private inner class Print : Thread() {
        override fun run() {
            super.run()
            try {
                mUsbThermalPrinter?.reset()
                mUsbThermalPrinter?.setAlgin(UsbThermalPrinter.ALGIN_LEFT)
                mUsbThermalPrinter?.setLeftIndent(0)
                mUsbThermalPrinter?.setLineSpace(0)
                mUsbThermalPrinter?.setGray(5)

                for (data in printDataArray) {
                    val type = utils.getPrintType(data["type"].toString())

                    when (type) {
                        PrintType.Text -> {
                            printText(data)
                        }
                        PrintType.Byte -> {
                            printByte(data)
                        }
                        PrintType.QR -> {}
                        PrintType.PDF -> {}
                        PrintType.WalkPaper -> {
                            val step = data["data"].toString().toIntOrNull() ?: 2

                            mUsbThermalPrinter?.walkPaper(step)
                        }
                    }
                }
            } catch (e: Exception) {
                e.printStackTrace()
                errorResult = e.toString()

                if (errorResult.equals(NOPAPEREXCEPTION)) {
                    noPaper = true
                }
                //
                else if (errorResult.equals(DEVICETRANSMITDATAEXCEPTION)) {
                    PrintHandler().sendMessage(
                        PrintHandler().obtainMessage(
                            DEVICETRANSMITDATA,
                            1,
                            0,
                            null
                        )
                    )
                }
                //
                else if (errorResult.equals(OVERHEATEXCEPTION)) {
                    PrintHandler().sendMessage(PrintHandler().obtainMessage(OVERHEAT, 1, 0, null))
                }
                //
                else {
                    PrintHandler().sendMessage(PrintHandler().obtainMessage(PRINTERR, 1, 0, null))
                }
            } finally {
                PrintHandler().sendMessage(PrintHandler().obtainMessage(CANCELPROMPT, 1, 0, null))

                if (noPaper) {
                    PrintHandler().sendMessage(PrintHandler().obtainMessage(NOPAPER, 1, 0, null))
                    noPaper = false
                }
                //
                else {
                    mUsbThermalPrinter?.stop()
                }
            }
        }
    }

    private fun printText(data: Map<String, Any>) {
        val text = data["data"].toString()
        val alignment = utils.getAlignment(data["alignment"].toString())
        val fontSize = utils.getFontSize(data["fontSize"].toString())

        mUsbThermalPrinter?.setTextSize(fontSize)
        mUsbThermalPrinter?.setAlgin(alignment)
        mUsbThermalPrinter?.addString(text)
        mUsbThermalPrinter?.printString()

        result?.success(true)
        return
    }

    private fun printByte(data: Map<String, Any>) {
        val value = data["data"] as ArrayList<*>

        for (bitmap in value) {
            val bmp = utils.createByteImage(bitmap as ByteArray)

            mUsbThermalPrinter?.printLogo(bmp, false)
        }

        mUsbThermalPrinter?.printString()
        result?.success(true)
        return
    }
}
package me.aljan.telpo_flutter_sdk

import android.os.Handler
import android.os.Looper
import android.util.Log
import io.flutter.plugin.common.MethodChannel

private typealias UnitFn = () -> Unit

class MethodChannelResultWrapper(result: MethodChannel.Result) : MethodChannel.Result {
    private val TAG = "MethodChannelWrapper"
    private val methodResult: MethodChannel.Result
    private val handler: Handler

    init {
        methodResult = result
        handler = Handler(Looper.getMainLooper())
    }

    override fun success(result: Any?) {
        wrapMainResult { methodResult.success(result) }
    }

    override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
        wrapMainResult { methodResult.error(errorCode, errorMessage, errorDetails) }
    }

    override fun notImplemented() {
        wrapMainResult { methodResult.notImplemented() }
    }

    private fun wrapMainResult(fn: UnitFn) {
        handler.post {
            ignoreIllegalState(fn)
        }
    }

    private fun ignoreIllegalState(fn: UnitFn) {
        try {
            fn()
        } catch (e: IllegalStateException) {
            Log.e(TAG, "Ignoring exception: <$e>.")
        }
    }
}
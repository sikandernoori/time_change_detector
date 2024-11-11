package com.randomforest.time_change_detector

import android.content.IntentFilter
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import io.flutter.embedding.engine.plugins.FlutterPlugin
import android.content.BroadcastReceiver
import io.flutter.plugin.common.EventChannel

class TimeChangeDetectorPlugin: BroadcastReceiver(), EventChannel.StreamHandler, FlutterPlugin {

  private var _context: Context? = null
  private var _sink: EventChannel.EventSink? = null
  private lateinit var eventChannel: EventChannel
  private var isReceiverRegistered = false

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    _context = flutterPluginBinding.applicationContext
    eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "time_change_detector")
    eventChannel.setStreamHandler(this)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    _context = null
    eventChannel.setStreamHandler(null)
  }

  override fun onReceive(context: Context, intent: Intent) {
    // TODO(Sikander): check with Team if we need to distinguish between Intents types in future
    // println(intent.getAction().toString())
    _sink?.success(true)
  }

  override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
    _sink = events

    // Unregister the receiver if already registered
    if (isReceiverRegistered) {
      _context?.let { ContextWrapper(it).unregisterReceiver(this) }
      isReceiverRegistered = false
    }

    // Parse arguments to determine which actions to register
    val intentFilter = IntentFilter()
    if (arguments is Map<*, *>) {
      if (arguments["timeSet"] == true) {
          intentFilter.addAction("android.intent.action.TIME_SET")
      }
      if (arguments["timeZoneChanged"] == true) {
          intentFilter.addAction("android.intent.action.TIMEZONE_CHANGED")
      }
      if (arguments["dateChanged"] == true) {
          intentFilter.addAction("android.intent.action.DATE_CHANGED")
      }
    }

    // If no arguments are provided, register for all actions by default
    if (intentFilter.countActions() == 0) {
      intentFilter.addAction("android.intent.action.TIME_SET")
      intentFilter.addAction("android.intent.action.TIMEZONE_CHANGED")
      intentFilter.addAction("android.intent.action.DATE_CHANGED")
    }

    // Register the receiver with the filtered actions
    _context?.let { ContextWrapper(it).registerReceiver(this, intentFilter) }
    isReceiverRegistered = true
  }

  override fun onCancel(arguments: Any?) {
    _sink = null
    // Unregister the receiver when the stream is cancelled
    if (isReceiverRegistered) {
      _context?.let { ContextWrapper(it).unregisterReceiver(this) }
      isReceiverRegistered = false
    }
  }
}

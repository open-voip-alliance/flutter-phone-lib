package org.openvoipalliance.flutterphonelib.events

import org.openvoipalliance.androidphoneintegration.events.Event
import org.openvoipalliance.flutterphonelib.call.toMap

fun Event.toMap() = if (this is Event.CallEvent)
        mapOf("type" to javaClass.simpleName, "call" to call?.toMap())
    else
        mapOf()
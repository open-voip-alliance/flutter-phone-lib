package org.openvoipalliance.flutterintegration.events

import org.openvoipalliance.androidplatformintegration.events.Event
import org.openvoipalliance.flutterintegration.call.toMap

fun Event.toMap() = if (this is Event.CallEvent)
        mapOf("type" to javaClass.simpleName, "call" to call?.toMap())
    else
        mapOf()
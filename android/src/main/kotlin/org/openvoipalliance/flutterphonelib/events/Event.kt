package org.openvoipalliance.flutterphonelib.events

import org.openvoipalliance.androidphoneintegration.events.Event
import org.openvoipalliance.flutterphonelib.call.toMap
import org.openvoipalliance.flutterphonelib.toMap

fun Event.toMap() = if (this is Event.CallSessionEvent)
        mapOf(
                "type" to javaClass.simpleName,
                "state" to state.toMap(),
        )
    else
        mapOf()
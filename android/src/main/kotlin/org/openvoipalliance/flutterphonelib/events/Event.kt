package org.openvoipalliance.flutterphonelib.events

import org.openvoipalliance.androidphoneintegration.events.Event
import org.openvoipalliance.flutterphonelib.call.toMap
import org.openvoipalliance.flutterphonelib.toMap

fun Event.toMap(): Map<String, Any?> = mutableMapOf<String, Any?>()
    .also {
        it["type"] = javaClass.simpleName

        when (this) {
            is Event.CallSessionEvent -> it["state"] = state.toMap()
            is Event.CallSetupFailedEvent -> it["reason"] = reason.name
        }
    }
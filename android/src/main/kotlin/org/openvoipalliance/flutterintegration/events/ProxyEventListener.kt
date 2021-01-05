package org.openvoipalliance.flutterintegration.events

import org.openvoipalliance.androidplatformintegration.events.Event
import org.openvoipalliance.androidplatformintegration.events.PILEventListener
import org.openvoipalliance.flutterintegration.FIL

internal class ProxyEventListener(private val fil: FIL) : PILEventListener {
    override fun onEvent(event: Event) = fil.channel.invokeMethod("onEvent", event.toMap())
}
package org.openvoipalliance.flutterphonelib.events

import org.openvoipalliance.androidphoneintegration.events.Event
import org.openvoipalliance.androidphoneintegration.events.PILEventListener
import org.openvoipalliance.flutterphonelib.PhoneLib

internal class ProxyEventListener() : PILEventListener {
    override fun onEvent(event: Event) = PhoneLib.channel.invokeMethod("onEvent", event.toMap())
}
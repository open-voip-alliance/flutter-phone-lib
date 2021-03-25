package org.openvoipalliance.flutterphonelib.events

import org.openvoipalliance.androidphoneintegration.events.Event
import org.openvoipalliance.androidphoneintegration.events.PILEventListener
import org.openvoipalliance.flutterphonelib.PhoneLib

internal class ProxyEventListener(private val phoneLib: PhoneLib) : PILEventListener {
    override fun onEvent(event: Event) = phoneLib.channel.invokeMethod("onEvent", event.toMap())
}
package org.openvoipalliance.flutterphonelib

import org.openvoipalliance.androidphoneintegration.CallSessionState
import org.openvoipalliance.androidphoneintegration.audio.AudioState
import org.openvoipalliance.androidphoneintegration.call.Call
import org.openvoipalliance.flutterphonelib.audio.toMap
import org.openvoipalliance.flutterphonelib.call.toMap
import org.openvoipalliance.flutterphonelib.contacts.toMap

fun CallSessionState.toMap() = mapOf(
    "activeCall" to activeCall?.toMap(),
    "inactiveCall" to inactiveCall?.toMap(),
    "audioState" to audioState.toMap(),
)
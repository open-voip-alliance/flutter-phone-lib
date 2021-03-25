package org.openvoipalliance.flutterphonelib.configuration

import org.openvoipalliance.androidphoneintegration.configuration.Preferences
import org.openvoipalliance.voiplib.model.Codec

fun preferencesOf(map: Map<String, Any?>) = object {
    val codecs: List<*> by map
    val useApplicationProvidedRingtone: Boolean by map

    val preferences = Preferences(
            codecs.map { Codec.valueOf(it as String) }.toTypedArray(),
            useApplicationProvidedRingtone,
    )
}.preferences
package org.openvoipalliance.flutterintegration.configuration

import org.openvoipalliance.androidplatformintegration.configuration.Preferences
import org.openvoipalliance.phonelib.model.Codec

fun preferencesOf(map: Map<String, Any?>) = object {
    val codecs: List<*> by map
    val useApplicationProvidedRingtone: Boolean by map

    val preferences = Preferences(
            codecs.map { Codec.valueOf(it as String) }.toTypedArray(),
            useApplicationProvidedRingtone,
    )
}.preferences
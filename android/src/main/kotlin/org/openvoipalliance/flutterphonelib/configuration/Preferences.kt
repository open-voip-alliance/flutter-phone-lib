package org.openvoipalliance.flutterphonelib.configuration

import org.openvoipalliance.androidphoneintegration.configuration.Preferences

fun preferencesOf(map: Map<String, Any?>) = object {
    val useApplicationProvidedRingtone: Boolean by map
    val enableAdvancedLogging: Boolean by map

    val preferences = Preferences(
        useApplicationProvidedRingtone,
        enableAdvancedLogging,
    )
}.preferences

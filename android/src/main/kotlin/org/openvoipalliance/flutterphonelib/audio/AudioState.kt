package org.openvoipalliance.flutterphonelib.audio

import org.openvoipalliance.androidphoneintegration.audio.AudioState

fun AudioState.toMap() = mapOf(
        "currentRoute" to currentRoute.name,
        "availableRoutes" to availableRoutes.map { it.name },
        "bluetoothDeviceName" to bluetoothDeviceName,
)
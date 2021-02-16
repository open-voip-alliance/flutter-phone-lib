package org.openvoipalliance.flutterintegration.audio

import org.openvoipalliance.androidplatformintegration.audio.AudioState

fun AudioState.toMap() = mapOf(
        "currentRoute" to currentRoute.name,
        "availableRoutes" to availableRoutes.map { it.name },
        "bluetoothDeviceName" to bluetoothDeviceName,
)
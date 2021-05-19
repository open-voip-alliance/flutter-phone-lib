package org.openvoipalliance.flutterphonelib.audio

import org.openvoipalliance.androidphoneintegration.audio.AudioState
import org.openvoipalliance.androidphoneintegration.audio.BluetoothAudioRoute

fun AudioState.toMap() = mapOf(
        "currentRoute" to currentRoute.name,
        "availableRoutes" to availableRoutes.map { it.name },
        "bluetoothDeviceName" to bluetoothDeviceName,
        "isMicrophoneMuted" to isMicrophoneMuted,
        "bluetoothRoutes" to bluetoothRoutes.map { it.toMap() },
)

fun BluetoothAudioRoute.toMap() = mapOf(
        "identifier" to identifier,
        "displayName" to displayName
)
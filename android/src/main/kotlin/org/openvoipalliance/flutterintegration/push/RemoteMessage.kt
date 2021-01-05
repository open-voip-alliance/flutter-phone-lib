package org.openvoipalliance.flutterintegration.push

import com.google.firebase.messaging.RemoteMessage

fun RemoteMessage.toMap() = mapOf("data" to data)
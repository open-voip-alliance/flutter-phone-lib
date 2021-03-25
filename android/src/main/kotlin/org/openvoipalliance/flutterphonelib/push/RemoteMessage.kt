package org.openvoipalliance.flutterphonelib.push

import com.google.firebase.messaging.RemoteMessage

fun RemoteMessage.toMap() = mapOf("data" to data)
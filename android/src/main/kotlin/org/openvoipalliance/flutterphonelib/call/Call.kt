package org.openvoipalliance.flutterphonelib.call

import org.openvoipalliance.androidphoneintegration.call.Call
import org.openvoipalliance.flutterphonelib.contacts.toMap

fun Call.toMap() = mapOf(
        "remoteNumber" to remoteNumber,
        "displayName" to displayName,
        "state" to state.toString(),
        "direction" to direction.toString(),
        "duration" to duration,
        "isOnHold" to isOnHold,
        "uuid" to uuid,
        "mos" to mos,
        "currentMos" to currentMos,
        "contact" to contact?.toMap(),
        "remotePartyHeading" to remotePartyHeading,
        "remotePartySubheading" to remotePartySubheading,
        "prettyDuration" to prettyDuration,
        "callId" to callId,
        "reason" to reason,
)
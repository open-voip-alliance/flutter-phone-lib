package org.openvoipalliance.flutterintegration.call

import org.openvoipalliance.androidplatformintegration.call.PILCall
import org.openvoipalliance.flutterintegration.contacts.toMap

fun PILCall.toMap() = mapOf(
        "remoteNumber" to remoteNumber,
        "displayName" to displayName,
        "state" to state.toString(),
        "direction" to direction.toString(),
        "duration" to duration,
        "isOnHold" to isOnHold,
        "uuid" to uuid,
        "mos" to mos,
        "contact" to contact?.toMap(),
        "remotePartyHeading" to remotePartyHeading,
        "remotePartySubheading" to remotePartySubheading,
        "prettyDuration" to prettyDuration,
)
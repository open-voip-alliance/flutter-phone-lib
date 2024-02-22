package org.openvoipalliance.flutterphonelib.contacts

import org.openvoipalliance.androidphoneintegration.contacts.SupplementaryContact

fun SupplementaryContact.toMap() = mapOf(
    "number" to number,
    "name" to name,
    "imageUri" to imageUri.toString(),
)
package org.openvoipalliance.flutterintegration.contacts

import org.openvoipalliance.androidplatformintegration.contacts.Contact

fun Contact.toMap() = mapOf(
        "name" to name,
        "imageUri" to imageUri.toString(),
)
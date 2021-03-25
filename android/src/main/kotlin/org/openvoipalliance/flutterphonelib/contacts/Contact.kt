package org.openvoipalliance.flutterphonelib.contacts

import org.openvoipalliance.androidphoneintegration.contacts.Contact

fun Contact.toMap() = mapOf(
        "name" to name,
        "imageUri" to imageUri.toString(),
)
package org.openvoipalliance.flutterphonelib.configuration

import org.openvoipalliance.androidphoneintegration.configuration.Preferences
import org.openvoipalliance.androidphoneintegration.contacts.SupplementaryContact

fun preferencesOf(map: Map<String, Any?>) = object {
    val useApplicationProvidedRingtone: Boolean by map
    val supplementaryContacts: List<Map<String, Any?>> by map

    val preferences = Preferences(
            useApplicationProvidedRingtone,
            supplementaryContacts.map { item -> SupplementaryContact(
                item["number"] as String? ?: "",
                item["name"] as String? ?: ""
            ) }.toSet(),
    )
}.preferences
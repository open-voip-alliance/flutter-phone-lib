package org.openvoipalliance.flutterphonelib.configuration

import org.openvoipalliance.androidphoneintegration.configuration.Auth


fun authOf(map: Map<String, Any?>) = object {
    val username: String by map
    val password: String by map
    val domain: String by map
    val port: Int by map
    val secure: Boolean by map

    val auth = Auth(username, password, domain, port, secure)
}.auth
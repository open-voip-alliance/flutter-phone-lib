package org.openvoipalliance.flutterintegration

import com.google.gson.Gson
import com.google.gson.reflect.TypeToken

val gson = Gson()

fun <T> T.toMap(): Map<String, Any> {
    return convert()
}

inline fun <reified T> Map<String, Any>.toObject(): T {
    return convert()
}

inline fun <I, reified O> I.convert(): O {
    val json = gson.toJson(this)
    return gson.fromJson(json, object : TypeToken<O>() {}.type)
}
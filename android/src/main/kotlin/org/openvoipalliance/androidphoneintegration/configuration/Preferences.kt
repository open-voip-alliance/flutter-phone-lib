package org.openvoipalliance.androidphoneintegration.configuration

data class Preferences(
    val useApplicationProvidedRingtone: Boolean,
    val enableAdvancedLogging: Boolean = false,
) {
    companion object {
        val DEFAULT = Preferences(useApplicationProvidedRingtone = false)
    }

    override fun equals(other: Any?): Boolean {
        if (other !is Preferences) return false

        return useApplicationProvidedRingtone == other.useApplicationProvidedRingtone
                && enableAdvancedLogging == other.enableAdvancedLogging
    }

    override fun hashCode(): Int {
        var result = useApplicationProvidedRingtone.hashCode()
        result = 31 * result + enableAdvancedLogging.hashCode()
        return result
    }
}

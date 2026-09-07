package nl.vialer.voip.vialer_voip_flutter_example

import android.app.Application
import android.util.Log
import org.openvoipalliance.flutterphonelib.startPhoneLib

class ExampleApplication : Application() {

    override fun onCreate() {
        super.onCreate()

        startPhoneLib(
            activityClass = MainActivity::class.java,
            nativeMiddleware = ExampleMiddleware(this),
            onLogReceived = { message, level -> Log.d("FPL-Example", "$level: $message") },
        )
    }
}

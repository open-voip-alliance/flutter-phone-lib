package org.openvoipalliance.flutterphonelib

import android.app.Activity
import android.app.Application
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.Intent.FLAG_ACTIVITY_NEW_TASK
import android.os.Bundle
import android.widget.Toast
// import io.flutter.app.FlutterApplication
import org.openvoipalliance.flutterphonelib.PhoneLib

import android.content.*
import android.net.Uri
import android.os.Build
import android.view.Window
import android.view.WindowManager
import androidx.activity.ComponentActivity
import java.util.*
import kotlin.concurrent.schedule


class MissedCallNotificationReceiver : BroadcastReceiver() {

    override fun onReceive(context: Context?, intent: Intent?) {
        Toast.makeText(context, "Missed call notification pressed", Toast.LENGTH_LONG).show()
//
//        val activityTracker = ActivityForegroundTracker()
//
//        if (!activityTracker.isAnyActivityVisible) {
//            PhoneLib.wasMissedCallNotificationPressed = true
//
////            val activityClass = intent?.getSerializableExtra("activity_class", Class<out Activity>)
//            val activityClass = intent?.getSerializableExtra("activity_class", Activity)
//
//            startActivity(
////                Intent(this@startPhoneLib, activityClass).apply {
////                    flags = FLAG_ACTIVITY_NEW_TASK
////                }
////                Intent(context, MainActivity::class.java).apply {
////                    flags = FLAG_ACTIVITY_NEW_TASK
////                }
//                Intent(context, activityClass).apply {
//                    flags = FLAG_ACTIVITY_NEW_TASK
//                }
//            )
//        } else {
//            PhoneLib.channel?.invokeMethod("onMissedCallNotificationPressed", null)
//        }
    }

    enum class Action {
        MISSED_CALL_NOTIFICATION_PRESSED
    }
}

//private class ActivityForegroundTracker : Application.ActivityLifecycleCallbacks {
//    private var activitiesVisible = 0;
//
//    val isAnyActivityVisible
//        get() = activitiesVisible > 0
//
//    override fun onActivityResumed(activity: Activity) {
//        activitiesVisible++
//    }
//
//    override fun onActivityPaused(activity: Activity) {
//        activitiesVisible--
//    }
//
//    override fun onActivityCreated(activity: Activity, savedInstanceState: Bundle?) {}
//
//    override fun onActivityStarted(activity: Activity) {}
//
//    override fun onActivityStopped(activity: Activity) {}
//
//    override fun onActivitySaveInstanceState(activity: Activity, outState: Bundle) {}
//
//    override fun onActivityDestroyed(activity: Activity) {}
//}
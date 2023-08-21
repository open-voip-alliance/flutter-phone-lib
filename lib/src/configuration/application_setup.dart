import 'package:json_annotation/json_annotation.dart';

import '../util/equatable.dart';

/// Note that the `application` and `activityClass` should be set
/// in Kotlin/Java, in your `MainActivity` like so:
/// ```kotlin
/// override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
///     GeneratedPluginRegistrant.registerWith(flutterEngine)
///
///     PhoneLib.instance.application = application
///     PhoneLib.instance.activityClass = javaClass
/// }
/// ```
class ApplicationSetup extends Equatable {
  /// Invoked when a missed call notification is pressed.
  ///
  /// When the app is in the foreground, this is called the instant the user
  /// presses the notification. When the app is in the background, the app is
  /// brought back to the foreground and `onMissedCallNotificationPressed`
  /// is called as soon as the app is in the foreground.
  ///
  /// Unlike the other callbacks, does not run in a separate isolate.
  final void Function()? onMissedCallNotificationPressed;

  /// The user-agent that will be used when making SIP calls.
  final String userAgent;

  const ApplicationSetup({
    this.onMissedCallNotificationPressed,
    this.userAgent = 'Flutter Phone Lib',
  }) : assert(userAgent.length > 0);

  @override
  @JsonKey(ignore: true)
  List<Object?> get props => [
        onMissedCallNotificationPressed,
        userAgent,
      ];
}

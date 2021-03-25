import 'package:json_annotation/json_annotation.dart';

import '../logging/logging.dart';
import '../push/middleware.dart';
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
  /// Provide a middleware if it is required to receive incoming calls
  /// in your infrastructure.
  final Middleware middleware;

  /// Receive logs from the PhoneLib.
  @JsonKey(ignore: true)
  final Logger logger;

  /// The user-agent that will be used when making SIP calls.
  final String userAgent;

  const ApplicationSetup({
    this.middleware,
    this.logger,
    this.userAgent = 'Flutter Phone Lib',
  });

  @override
  @JsonKey(ignore: true)
  List<Object> get props => [middleware, logger, userAgent];
}

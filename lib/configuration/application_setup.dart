import 'package:json_annotation/json_annotation.dart';

import '../logging/logging.dart';
import '../push/middleware.dart';
import '../util/equatable.dart';

/// Note that the `application` and `activities` as seen in the PIL equivalent
/// should be set in Kotlin/Java, in your `MainActivity` like so:
/// ```kotlin
/// override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
///     GeneratedPluginRegistrant.registerWith(flutterEngine)
///
///     FIL.instance.application = application
///     FIL.instance.activityClass = javaClass
/// }
/// ```
class ApplicationSetup extends Equatable {
  /// Provide a middleware if it is required to receive incoming calls
  /// in your infrastructure.
  final Middleware middleware;

  /// Receive logs from the FIL.
  @JsonKey(ignore: true)
  final Logger logger;

  /// The user-agent that will be used when making SIP calls.
  final String userAgent;

  const ApplicationSetup({
    this.middleware,
    this.logger,
    this.userAgent = 'FIL',
  });

  @override
  @JsonKey(ignore: true)
  List<Object> get props => [middleware, logger, userAgent];
}

import 'package:json_annotation/json_annotation.dart';

import '../logging/log_level.dart';
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
  /// Guaranteed to be called before any background callbacks
  /// (middleware and logging) are called. Used to initialize dependencies of
  /// other resources necessary to run these callbacks.
  ///
  /// Must be a static or top level function.
  final Future<void> Function()? initialize;

  /// Provide a middleware if it is required to receive incoming calls
  /// in your infrastructure.
  final Middleware? middleware;

  /// Receive logs from the PhoneLib.
  ///
  /// Must be a static or top level function.
  final void Function(LogLevel, String)? logger;

  /// The user-agent that will be used when making SIP calls.
  final String userAgent;

  const ApplicationSetup({
    this.initialize,
    this.middleware,
    this.logger,
    this.userAgent = 'Flutter Phone Lib',
  }) : assert(
          userAgent.length > 0 &&
              ((middleware == null && logger == null) || initialize != null),
        );

  @override
  @JsonKey(ignore: true)
  List<Object?> get props => [
        middleware,
        initialize,
        logger,
        userAgent,
      ];
}

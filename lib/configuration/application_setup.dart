
import 'package:json_annotation/json_annotation.dart';

import '../logging/logging.dart';
import '../util/equatable.dart';

part 'application_setup.g.dart';

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
@JsonSerializable()
class ApplicationSetup extends Equatable {
  /// Provide a middleware if it is required to receive incoming calls
  /// in your infrastructure.
  // TODO
  //final Middleware middleware;

  /// Receive logs from the FIL.
  @JsonKey(ignore: true)
  final Logger logger;

  /// The user-agent that will be used when making SIP calls.
  final String userAgent;

  const ApplicationSetup({
    this.logger,
    this.userAgent = 'FIL',
  });

  @override
  @JsonKey(ignore: true)
  List<Object> get props => [logger, userAgent];

  Map<String, dynamic> toJson() => _$ApplicationSetupToJson(this);
}

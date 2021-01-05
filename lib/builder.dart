import 'configuration/application_setup.dart';

import 'configuration/auth.dart';
import 'configuration/preferences.dart';
import 'fil.dart';

class Builder {
  Preferences preferences;
  Auth auth;
}

Future<Fil> startFil(
  ApplicationSetup Function(Builder builder) build,
) async {
  final builder = Builder();
  final applicationSetup = build(builder);

  await Fil.channel.invokeMethod(
    'startFIL',
    [
      builder.preferences.toJson(),
      builder.auth.toJson(),
      applicationSetup.middleware != null, // hasMiddleware
      applicationSetup.userAgent,
    ],
  );

  return Fil(applicationSetup);
}

import 'configuration/application_setup.dart';

import 'configuration/auth.dart';
import 'configuration/preferences.dart';
import 'phone_lib.dart';

class Builder {
  Preferences preferences;
  Auth auth;
}

Future<PhoneLib> startPhoneLib(
  ApplicationSetup Function(Builder builder) build,
) async {
  final builder = Builder();
  final applicationSetup = build(builder);

  await PhoneLib.channel.invokeMethod(
    'startPhoneLib',
    [
      builder.preferences.toJson(),
      builder.auth.toJson(),
      applicationSetup.middleware != null, // hasMiddleware
      applicationSetup.userAgent,
    ],
  );

  return PhoneLib(applicationSetup);
}

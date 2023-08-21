import 'configuration/application_setup.dart';
import 'configuration/auth.dart';
import 'configuration/preferences.dart';
import 'phone_lib.dart';

class Builder {
  Preferences? preferences;
  Auth? auth;
}

Future<PhoneLib> initializePhoneLib(
  ApplicationSetup Function(Builder builder) build,
) async {
  final builder = Builder();
  final applicationSetup = build(builder);

  assert(builder.preferences != null);
  assert(builder.auth != null);

  await PhoneLib.channel.invokeMethod(
    'initializePhoneLib',
    [
      builder.preferences!.toJson(),
      builder.auth!.toJson(),
      applicationSetup.userAgent,
    ],
  );

  return PhoneLib(applicationSetup.onMissedCallNotificationPressed);
}

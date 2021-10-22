import 'callback_dispatcher.dart';
import 'configuration/application_setup.dart';
import 'configuration/auth.dart';
import 'configuration/preferences.dart';
import 'phone_lib.dart';
import 'util/callback.dart';

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
      callbackDispatcher.toCallbackHandle(),
      applicationSetup.initialize?.toCallbackHandle(),
      applicationSetup.middleware?.respond.toCallbackHandle(),
      applicationSetup.middleware?.tokenReceived.toCallbackHandle(),
      applicationSetup.middleware?.inspect.toCallbackHandle(),
      applicationSetup.userAgent,
    ],
  );

  return PhoneLib(applicationSetup.onMissedCallNotificationPressed);
}

# flutter_phone_lib example

Example app for the `flutter_phone_lib` plugin, mirroring the example apps
that shipped with the (now vendored) Android Phone Integration Lib and
iOS Phone Lib.

## Features

- **Dialer**: keypad with local tone playback, backspace (long-press to
  clear), and outgoing calls.
- **Call screen**: caller info, duration and call state, hold, mute, audio
  routing (earpiece/speaker/bluetooth, with a picker when multiple bluetooth
  devices are connected), in-call DTMF keypad, and attended transfer
  (transfer + merge).
- **Incoming call screen**: answer/decline, driven by the event stream.
- **Settings**: SIP credentials (persisted), VoIPGRID login and middleware
  registration, preferences (application ringtone, native recents), echo
  cancellation calibration, and stopping the library.

## Getting started

1. `flutter pub get`
2. `cp .env.example .env` (the build requires this file, see below)
3. `flutter run`
4. Open the **Settings** tab, enter your SIP credentials (username, password,
   domain, port) and press **Save & Apply**.
5. Dial a number on the **Dialer** tab.

### Pre-filling credentials (debug builds)

Like the native example apps, debug builds can be pre-filled with your SIP
credentials so you don't have to type them after every reinstall. Fill in the
values in `.env` (the file explains where to find them) and run the app as
usual. `.env` is git-ignored. The values are only applied when no credentials
have been saved yet, so anything entered in **Settings** takes precedence.

## Incoming calls (push notifications)

Incoming calls are delivered by the VoIPGRID middleware ("callwaker") as a
push notification, which the plugin turns into a SIP registration and an
incoming call. Like the native example apps, this requires a VoIPGRID login:

1. Enter your VoIPGRID email and password in **Settings** and press
   **Log in**. This fetches an API token.
2. Press **Register**. This is also done automatically whenever the phone lib
   starts while you are logged in.

The Dart side (`lib/src/voipgrid.dart`, `lib/src/middleware.dart`) does the
login and (un)registration over HTTP. The native side (`ExampleMiddleware` on
both platforms) receives the push token, stores it where Dart can read it, and
answers each incoming call push.

The example reuses Vialer's application ID / bundle ID (`com.voipgrid.vialer`)
so Vialer's Firebase project and APNs credentials work with the middleware. As
a consequence it cannot be installed alongside Vialer, and the iOS build must
be signed with Vialer's team.

## Native setup

The plugin requires a small amount of native wiring, which this example also
demonstrates:

- Android: `ExampleApplication` calls `startPhoneLib(...)` with
  `ExampleMiddleware`. Firebase needs `android/app/google-services.json`, which
  is not committed; the Gradle build tells you where to get it.
- iOS: `AppDelegate` calls `startPhoneLib(...)` with `ExampleMiddleware`;
  `Info.plist` enables the `voip` background mode and `Runner.entitlements`
  the push notification entitlement.

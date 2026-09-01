# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Flutter Phone Lib** is a VoIP (Voice over IP) plugin for Flutter that provides real-time calling capabilities. It's part of the Open VoIP Alliance project family and bridges Flutter/Dart with native Android (Kotlin) and iOS (Swift) implementations.

**Architecture:** Flutter Plugin with three layers:
1. Dart/Flutter API (lib/)
2. Platform Channel (MethodChannel: `org.openvoipalliance.flutterphonelib/foreground`)
3. Native VoIP implementations, vendored into this repository:
   - Android: `android/src/main/kotlin/org/openvoipalliance/{androidphoneintegration,voiplib}/` (formerly Android-Phone-Integration-Lib, vendored at v0.1.147)
   - iOS: `ios/flutter_phone_lib/{iOSPhoneLib,LinphoneWrapper}/` (formerly iOS-Phone-Lib, vendored at v0.1.18)

## Layering: Bridge vs VoIP Implementation

The former APL (Android Phone Integration Lib) and IPL (iOS Phone Lib) libraries are now vendored into this repository, but the layering they enforced still applies:

**The bridge layer** (`lib/`, `android/.../flutterphonelib/`, `ios/flutter_phone_lib/Sources/`) is a **thin translation layer**:
- Bridge Dart ↔ Native via MethodChannel
- Serialize/deserialize data between Dart and native formats
- Maintain type-safe Dart API surface
- No VoIP logic or call-handling decisions

**The VoIP layer** (`android/.../androidphoneintegration/`, `android/.../voiplib/`, `ios/flutter_phone_lib/iOSPhoneLib/`, `ios/flutter_phone_lib/LinphoneWrapper/`) contains the real business logic:
- Call lifecycle, audio routing, push handling, Telecom/CallKit integration
- Wraps the linphone SDK (the actual SIP stack)

VoIP logic changes go in the VoIP layer; serialization/channel changes go in the bridge layer. Don't blur the boundary.

### Required Context: Vialer (Consumer App)

- Path: `../vialer/`
- Purpose: Real-world consumer of this library. Shows actual usage patterns and integration examples.
- Use this to understand: How FPL is used in practice, what API patterns work well, common integration patterns
- Use vialer as the source of truth for API design decisions, and check whether bugs manifest there.

### Historical Repositories

The vendored native code originates from these (now unmaintained) repositories; their git history can be useful context:
- https://github.com/open-voip-alliance/Android-Phone-Integration-Lib (vendored at 0.1.147, commit bc735c4)
- https://github.com/open-voip-alliance/iOS-Phone-Lib (vendored at 0.1.18, commit c5b897a)

## Essential Development Commands

### Code Generation (Critical)
This codebase uses `json_serializable` and `freezed` for code generation. Generated files (`.g.dart`, `.freezed.dart`) are tracked in git and will show as modified after regeneration.

```bash
# Generate code (required after modifying annotated models)
flutter pub run build_runner build

# Force regeneration (use when conflicts occur)
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (auto-regenerate on file changes)
flutter pub run build_runner watch
```

**When to regenerate:**
- After modifying any file with `@JsonSerializable()` or `@freezed` annotations
- Files in: `lib/src/configuration/`, `lib/src/call/`, `lib/src/contacts/`
- Before committing, testing, or building

### Testing and Quality

```bash
# Run tests (test/ directory currently empty)
flutter test

# Run code analysis
flutter analyze

# Format code
dart format lib/ android/ ios/
```

### Running the Example App

```bash
cd example
flutter pub get
flutter run                    # Run on connected device
flutter run -d <device-id>     # Run on specific device
```

## Architecture & Key Concepts

### Core Components

**PhoneLib Singleton** (`lib/src/phone_lib.dart`):
- Main entry point accessed via `PhoneLib.instance`
- Initialize with builder pattern via `initializePhoneLib()`
- Manages call lifecycle, audio, and events

**Event Stream** (`lib/src/events/event.dart`):
- Broadcast stream for real-time events (13+ event types)
- Lazy subscription (only listens when Dart has listeners)
- Key events: `OutgoingCallStarted`, `CallConnected`, `AudioStateUpdated`, `CallStateUpdated`

**Call Management** (`lib/src/call/`):
- `Call` - Data model with state, duration, quality metrics (MOS)
- `CallState` - State machine: `INITIALIZING → RINGING → CONNECTED → ENDED`
- `CallActions` - Operations: hold, DTMF, transfer, answer, decline, end

**Audio Management** (`lib/src/audio/`):
- `AudioManager` - Controls microphone, routing, codecs
- `AudioRoute` - Routes: SPEAKER, EARPIECE, BLUETOOTH, WIRED_HEADSET

**Configuration** (`lib/src/configuration/`):
- `Auth` - SIP credentials (username, password, domain, port, secure)
- `Preferences` - Settings (ringtone, recents, contacts, logging)
- `ApplicationSetup` - User agent and callback configuration

### Call State Flow

```
INITIALIZING → RINGING → CONNECTED → {HELD_BY_LOCAL | HELD_BY_REMOTE} → ENDED
                                   ↘ ERROR
```

### Platform Channel Communication

**Method Channel:** `org.openvoipalliance.flutterphonelib/foreground`
- Dart → Native: Method invocations (Future-based)
- Native → Dart: Event callbacks (Stream-based)

## File Organization

```
lib/
├── flutter_phone_lib.dart              # Public API exports
└── src/
    ├── phone_lib.dart                  # Main singleton (100 lines)
    ├── builder.dart                    # Initialization builder
    ├── call_session_state.dart         # Active call + audio state
    ├── call/                           # Call models and actions
    ├── audio/                          # Audio management
    ├── configuration/                  # Auth and preferences
    ├── contacts/                       # Contact models
    ├── events/                         # Event hierarchy
    ├── push/                           # Push notification handling
    └── util/                           # Utilities

android/                                # Kotlin implementation
├── build.gradle                        # Android build config
└── src/main/kotlin/org/openvoipalliance/
    ├── flutterphonelib/                # Bridge layer (method channel)
    ├── androidphoneintegration/        # Vendored APL (VoIP logic)
    └── voiplib/                        # Vendored APL linphone wrapper

ios/flutter_phone_lib/                  # Swift implementation (SPM package)
├── Sources/flutter_phone_lib/          # Bridge layer (method channel)
├── iOSPhoneLib/                        # Vendored IPL (VoIP logic)
└── LinphoneWrapper/                    # Vendored IPL linphone wrapper

example/                                # Demo app
```

## Common Development Patterns

### Adding a New Call Action

1. Add method to `lib/src/call/call_actions.dart`
2. Implement in Android (`android/src/main/kotlin/.../PhoneLib.kt`)
3. Implement in iOS (`ios/flutter_phone_lib/PhoneLibPlugin.swift`)
4. Test via method channel

### Adding a New Event Type

1. Define event class in `lib/src/events/event.dart`
2. Handle deserialization in `Event.fromJson()`
3. Implement event emission in native layers
4. Update event stream listeners

### Modifying Configuration Models

1. Edit model in `lib/src/configuration/` (e.g., `preferences.dart`)
2. Run `flutter pub run build_runner build --delete-conflicting-outputs`
3. Update Android/iOS preference handling
4. Update initialization in `builder.dart` if needed

## Platform-Specific Considerations

### Android
- Minimum API level: 26 (Android 8.0+)
- Target API level: 33
- Kotlin 1.8.20, Java 1.8 compatibility
- Foreground service required for background calls
- Handles GSM/other-app call conflicts
- Android Telecom Framework integration

### iOS
- Swift Package Manager (migrated from CocoaPods in v0.0.37)
- CallKit integration for native call UI
- VoIP push certificates required for background execution
- Optimized contact searching

## Dependencies

**Key Dart packages:**
- `equatable ^2.0.5` - Value equality
- `json_annotation ^4.8.1` / `json_serializable ^6.7.1` - JSON serialization
- `freezed_annotation ^3.1.0` / `freezed ^3.2.3` - Immutable data classes

**Native dependencies (of the vendored VoIP code):**
- Android: `org.linphone.minimal:linphone-sdk-android` 5.4.94, `io.insert-koin:koin-android` 2.2.2
- iOS: `linphone-sdk-swift-ios` 5.4.24 (from gitlab.linphone.org), `Swinject` 2.9.2 (JohannesNevels fork)

## Important Notes

1. **Generated files are tracked**: `.g.dart` and `.freezed.dart` files are committed and will appear modified after regeneration. This is expected.

2. **Code generation is mandatory**: Always regenerate code before committing changes to annotated models.

3. **Platform channel communication**: All Dart ↔ Native communication goes through MethodChannel with JSON serialization.

4. **Event stream is lazy**: Native side only emits events when Dart has active listeners.

5. **Singleton pattern**: Only one PhoneLib instance per app lifecycle. Use `PhoneLib.instance` after initialization.

## Quick Reference

**Initialize PhoneLib:**
```dart
final phoneLib = await initializePhoneLib((builder) {
  builder.preferences = Preferences.standard;
  builder.auth = Auth(
    username: 'sip_user',
    password: 'password',
    domain: 'sip.example.com',
    port: 5061,
    secure: true,
  );
  return ApplicationSetup(userAgent: 'My VoIP App 1.0');
});
```

**Subscribe to events:**
```dart
phoneLib.events.listen((event) {
  if (event is CallConnected) {
    print('Call connected!');
  }
});
```

**Make a call:**
```dart
await phoneLib.call('+1234567890');
```

**Call actions:**
```dart
phoneLib.actions.hold()
phoneLib.actions.unhold()
phoneLib.actions.answer()
phoneLib.actions.decline()
phoneLib.actions.end()
phoneLib.actions.sendDtmf('1234')
```
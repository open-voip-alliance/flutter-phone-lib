# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Flutter Phone Lib** is a VoIP (Voice over IP) plugin for Flutter that provides real-time calling capabilities. It's part of the Open VoIP Alliance project family and bridges Flutter/Dart with native Android (Kotlin) and iOS (Swift) implementations.

**Architecture:** Flutter Plugin with three layers:
1. Dart/Flutter API (lib/)
2. Platform Channel (MethodChannel: `org.openvoipalliance.flutterphonelib/foreground`)
3. Native implementations (Android-Phone-Integration-Lib v0.1.142, iOS-Phone-Integration-Lib v0.1.15)

## CRITICAL: FPL is a Thin Bridge Layer

**Core Principle:** Flutter Phone Lib (FPL) is designed to be a **thin translation layer** between Dart and the native phone libraries. It should contain **minimal logic** and be as **invisible as possible**.

**What FPL Should Do:**
- Bridge Dart ↔ Native via MethodChannel
- Serialize/deserialize data between Dart and native formats
- Expose APL/IPL functionality to Flutter developers
- Maintain type-safe Dart API surface

**What FPL Should NOT Do:**
- Implement VoIP logic (belongs in APL/IPL)
- Make business decisions about call handling (belongs in APL/IPL)
- Duplicate functionality that exists in native libraries
- Add features not supported by APL/IPL

### Required Context: Related Codebases

**IMPORTANT:** Before working on this codebase, verify you have access to these three related projects (one directory level up from this repository):

1. **Android Phone Integration Lib (APL)**
   - Path: `../android-phone-integration-lib/`
   - Repository: https://github.com/open-voip-alliance/Android-Phone-Integration-Lib
   - Purpose: The actual Android VoIP implementation. Contains the real business logic.
   - Current version used by FPL: v0.1.142

2. **iOS Phone Lib (IPL)**
   - Path: `../ios-phone-lib/`
   - Repository: https://github.com/open-voip-alliance/iOS-Phone-Lib
   - Purpose: The actual iOS VoIP implementation. Contains the real business logic.
   - Current version used by FPL: v0.1.15

3. **Vialer (Consumer App)**
   - Path: `../vialer/`
   - Purpose: Real-world consumer of this library. Shows actual usage patterns and integration examples.
   - Use this to understand: How FPL is used in practice, what API patterns work well, common integration patterns

**If any of these projects are missing:** Stop and prompt the user to clone them. These codebases are essential context for any work on FPL.

### Development Workflow with Related Codebases

**When adding a new feature:**
1. Check if APL/IPL already support this functionality
2. If yes: Simply expose it through FPL's Dart API
3. If no: Feature needs to be added to APL/IPL first, not FPL
4. Check `../vialer/` to see if similar patterns exist

**When fixing a bug:**
1. Determine if the bug is in FPL's bridging code or in APL/IPL
2. If it's VoIP logic: The bug is likely in APL/IPL
3. If it's serialization/channel communication: The bug is in FPL
4. Check `../vialer/` to see if the issue manifests there

**When understanding usage:**
1. Look at `../vialer/` project to see real-world usage patterns
2. Check how vialer initializes FPL, handles events, manages calls
3. Use vialer as the source of truth for API design decisions

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
└── src/main/kotlin/org/openvoipalliance/flutterphonelib/

ios/                                    # Swift implementation
└── flutter_phone_lib/PhoneLibPlugin.swift

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

**Native libraries:**
- Android: `Android-Phone-Integration-Lib` (APL) v0.1.142
- iOS: `iOS-Phone-Integration-Lib` (IPL) v0.1.15

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
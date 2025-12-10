# Changelog
## [0.0.42] - 2025-12-10

- Upgraded iOS Phone Lib to 0.1.18 to fix audio route reset issue when a call starts

## [0.0.41] - 2025-12-04

- Fixed an issue on iOS that transfer events weren't properly passed along

## [0.0.40] - 2025-11-17

- Added `playToneLocally()` method to play DTMF tones on-demand
- Added `playToneLocally` parameter to `sendDtmf()` for automatic local playback when sending DTMF

## [0.0.39] - 2025-10-27

- Fixed JVM target compatibility issue between Java and Kotlin compilation tasks on Android.

## [0.0.38] - 2025-10-27

- Solved dependency conflict with freezed 3.x in the project.

## [0.0.37] - 2025-07-29

- Migrated for iOS to Swift Package Manager 
- Upgraded APL to 0.1.142
- Upgraded IPL to 0.1.15

## [0.0.36] - 2025-03-18

- Android: Calls will now be rejected if you are in GSM or other-app call

## [0.0.35] - 2025-02-25

- Android: Calls will now be rejected if you are in GSM or other-app call

## [0.0.32] - 2024-10-25

- Android: It is now possible to enable advanced logging for voip

## [0.0.31] - 2024-10-25

- Updated iOSPhoneLib to 0.1.14 to optimise contact searching

## [0.0.30] - 2024-10-07

- Forcing ipv4

## [0.0.29] - 2024-10-04

- Upgraded APL to 0.1.138 to fix a bug where calls were ending early

## [0.0.28] - 2024-10-01

- Upgraded APL to 0.1.136 for improved incoming call handling

## [0.0.27] - 2024-09-27

- Upgraded APL to 0.1.135 for improved incoming call handling

## [0.0.26] - 2024-09-13

- Upgraded APL to 0.1.134 for improved incoming call handling
## [0.0.25] - 2024-09-06

- Fixed background push notifications not working on iOS

## [0.0.24] - 2024-09-05

- Microphone fix

## [0.0.23] - 2024-09-04

- Reverted change to re-add microphone as foreground service to fix audio disappearing when phone goes to background during a call

## [0.0.22] - 2024-08-27

- Improved experience when answering calls on iOS

## [0.0.21] - 2024-08-22

- Upgraded APL for foreground service requirements

## [0.0.19] - 2024-06-21

- Upgraded IPL to 0.1.11 for app icon badge support

## [0.0.18] - 2024-06-20

- Upgraded IPL to 0.1.10

## [0.0.15] - 2024-05-30

- Upgraded APL to 0.1.129

## [0.0.14] - 2024-02-27

- iOS: Supplementary contacts will be used for incoming calls

## [0.0.13] - 2024-02-26

- Android: Fixed a bug where media playback would not resume after an incoming call

## [0.0.12] - 2024-02-22

- Added generated files back to git

## [0.0.11] - 2024-02-22

- Lowered meta dependency requirement

## [0.0.10] - 2024-02-22

- Supports supplementary contacts
- Updated gradle project
- Removed generated files from git tracking

## [0.0.9] - 2024-02-08

- Fixed issue with preferences object

## [0.0.8] - 2024-02-08

- Upgraded to APL 0.1.123, allowing for adding supplementary contacts.

## [0.0.7] - 2024-01-25

- Upgraded to APL 0.1.122, emergency calls will now open in the native dialer
- 
## [0.0.6] - 2024-01-25

- Upgraded to APL 0.1.122, emergency calls will now open in the native dialer

## [0.0.5] - 2024-01-24

- Upgraded to APL 0.1.121, allowing emergency calls to be made
- 
## [0.0.4] - 2024-01-24

- Upgraded to APL 0.1.121, allowing emergency calls to be made

## [0.0.3] - 2024-01-18

- Upgraded to iOSPhoneLib 0.1.5, fixing an issue where the iOS dynamic island would not update call duration.

## [0.0.2] - 2024-01-17

- Pinning to a specific version of the IPL

## [0.0.1] - 2024-01-17

- Initial release
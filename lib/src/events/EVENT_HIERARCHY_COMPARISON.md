# Event Hierarchy Comparison: Original vs Freezed

## Class Hierarchy Overview

### Original Implementation

```
Event (base class)
├── CallSessionEvent (extends Event)
│   ├── OutgoingCallStarted
│   ├── IncomingCallReceived
│   ├── CallEnded
│   ├── CallDurationUpdated
│   ├── CallConnected
│   ├── AudioStateUpdated
│   ├── CallStateUpdated
│   └── AttendedTransferEvent (abstract, extends CallSessionEvent)
│       ├── AttendedTransferStarted
│       ├── AttendedTransferConnected
│       ├── AttendedTransferAborted
│       └── AttendedTransferEnded
└── CallSetupFailedEvent (abstract, extends Event)
    ├── OutgoingCallSetupFailed
    └── IncomingCallSetupFailed
```

### Freezed Implementation

```
Event (sealed union)
├── OutgoingCallStarted (implements CallSessionEvent)
├── IncomingCallReceived (implements CallSessionEvent)
├── CallEnded (implements CallSessionEvent)
├── CallDurationUpdated (implements CallSessionEvent)
├── CallConnected (implements CallSessionEvent)
├── AudioStateUpdated (implements CallSessionEvent)
├── CallStateUpdated (implements CallSessionEvent)
├── AttendedTransferStarted (implements AttendedTransferEvent → CallSessionEvent)
├── AttendedTransferConnected (implements AttendedTransferEvent → CallSessionEvent)
├── AttendedTransferAborted (implements AttendedTransferEvent → CallSessionEvent)
├── AttendedTransferEnded (implements AttendedTransferEvent → CallSessionEvent)
├── OutgoingCallSetupFailed (implements CallSetupFailedEvent)
└── IncomingCallSetupFailed (implements CallSetupFailedEvent)
```

## Detailed Event Comparison

| Event Name | Original | Freezed |
|------------|----------|---------|
| **OutgoingCallStarted** | `extends CallSessionEvent` | `implements CallSessionEvent` |
| **IncomingCallReceived** | `extends CallSessionEvent` | `implements CallSessionEvent` |
| **CallEnded** | `extends CallSessionEvent` | `implements CallSessionEvent` |
| **CallDurationUpdated** | `extends CallSessionEvent` | `implements CallSessionEvent` |
| **CallConnected** | `extends CallSessionEvent` | `implements CallSessionEvent` |
| **AudioStateUpdated** | `extends CallSessionEvent` | `implements CallSessionEvent` |
| **CallStateUpdated** | `extends CallSessionEvent` | `implements CallSessionEvent` |
| **AttendedTransferStarted** | `extends AttendedTransferEvent`<br>(which extends CallSessionEvent) | `implements AttendedTransferEvent`<br>(which implements CallSessionEvent) |
| **AttendedTransferConnected** | `extends AttendedTransferEvent`<br>(which extends CallSessionEvent) | `implements AttendedTransferEvent`<br>(which implements CallSessionEvent) |
| **AttendedTransferAborted** | `extends AttendedTransferEvent`<br>(which extends CallSessionEvent) | `implements AttendedTransferEvent`<br>(which implements CallSessionEvent) |
| **AttendedTransferEnded** | `extends AttendedTransferEvent`<br>(which extends CallSessionEvent) | `implements AttendedTransferEvent`<br>(which implements CallSessionEvent) |
| **OutgoingCallSetupFailed** | `extends CallSetupFailedEvent` | `implements CallSetupFailedEvent` |
| **IncomingCallSetupFailed** | `extends CallSetupFailedEvent` | `implements CallSetupFailedEvent` |

## Interface/Base Class Definitions

| Class/Interface | Original | Freezed |
|-----------------|----------|---------|
| **Event** | `class Event extends Equatable`<br>Base class for all events | `sealed class Event with _$Event`<br>Sealed union of all event types |
| **CallSessionEvent** | `class CallSessionEvent extends Event`<br>Has `state` property | `abstract interface class CallSessionEvent`<br>Defines `state` getter |
| **AttendedTransferEvent** | `abstract class extends CallSessionEvent`<br>Inherits `state` property | `abstract interface class implements CallSessionEvent`<br>Inherits `state` getter |
| **CallSetupFailedEvent** | `abstract class extends Event`<br>Has `reason` property | `abstract interface class CallSetupFailedEvent`<br>Defines `reason` getter |

## Key Differences

### Original (Class Inheritance)
- Uses traditional class inheritance with `extends`
- Base classes (`CallSessionEvent`, `CallSetupFailedEvent`) have actual implementations
- Multiple levels of inheritance (Event → CallSessionEvent → AttendedTransferEvent → concrete events)
- Concrete classes inherit behavior from parent classes

### Freezed (Interface Implementation)
- Uses `sealed class` union with interface implementation via `@Implements` annotation
- Interfaces define contracts but no implementation
- All concrete events are direct variants of the `Event` union
- Interface hierarchy maintained through `implements` relationships
- Type checking works the same way (`event is CallSessionEvent` works in both)

## Type Checking Behavior

Both implementations support the same type checking patterns:

```dart
// Check for specific interface
if (event is CallSessionEvent) {
  print(event.state); // Works in both
}

// Check for nested interface
if (event is AttendedTransferEvent) {
  print(event.state); // Works in both (AttendedTransferEvent is-a CallSessionEvent)
}

// Check for specific event type
if (event is OutgoingCallStarted) {
  // Handle outgoing call
}
```

The difference is that Freezed also provides exhaustive pattern matching via `when`/`maybeWhen` methods.
import iOSPhoneLib

internal extension Call {
    func toDictionary() -> Dictionary<String, Any?> {
        [
            "remoteNumber": remoteNumber,
            "displayName": displayName,
            "state": describeAsUpperSnakeCase(state),
            "direction": describeAsUpperSnakeCase(direction),
            "duration": duration,
            "isOnHold": isOnHold,
            "uuid": String(describing: uuid),
            "mos": mos,
            "currentMos": currentMos,
            "contact": contact?.toDictionary(),
            "remotePartyHeading": remotePartyHeading,
            "remotePartySubheading": remotePartySubheading,
            "prettyDuration": prettyDuration,
            "reason" : reason,
            "callId" : "",
        ]
    }
}

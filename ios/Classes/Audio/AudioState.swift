import iOSPhoneLib

internal extension AudioState {
    func toDictionary() -> Dictionary<String, Any?> {
        [
            "currentRoute": describeAsUpperSnakeCase(currentRoute),
            "availableRoutes": availableRoutes.map { describeAsUpperSnakeCase($0) },
            "bluetoothDeviceName": bluetoothDeviceName,
            "isMicrophoneMuted": isMicrophoneMuted,
            "bluetoothRoutes": [], // TODO
        ]
    }
}


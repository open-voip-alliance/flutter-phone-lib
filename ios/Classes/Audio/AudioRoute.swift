import iOSPhoneLib

internal func audioRouteOf(_ value: String) -> AudioRoute {
    [AudioRoute.speaker, AudioRoute.phone, AudioRoute.bluetooth].first { route in
        describeAsUpperSnakeCase(route) == value
    }!
}


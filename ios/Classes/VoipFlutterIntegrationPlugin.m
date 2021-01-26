#import "VoipFlutterIntegrationPlugin.h"
#if __has_include(<voip_flutter_integration/voip_flutter_integration-Swift.h>)
#import <voip_flutter_integration/voip_flutter_integration-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "voip_flutter_integration-Swift.h"
#endif

@implementation VoipFlutterIntegrationPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftVoipFlutterIntegrationPlugin registerWithRegistrar:registrar];
}
@end

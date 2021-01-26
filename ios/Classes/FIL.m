#import "FIL.h"
#if __has_include(<voip_flutter_integration/FIL.h>)
#import <voip_flutter_integration/FIL.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "FIL.h"
#endif

@implementation FIL
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [FIL registerWithRegistrar:registrar];
}
@end

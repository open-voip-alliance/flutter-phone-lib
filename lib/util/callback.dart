import 'dart:ui';

extension CallbackHandle on Function {
  int toCallbackHandle() {
    final handle = PluginUtilities.getCallbackHandle(this).toRawHandle();
    if (handle == null) {
      throw StateError('Callback must be a top level or static function');
    }

    return handle;
  }
}

import 'package:json_annotation/json_annotation.dart';

import 'configuration/application_setup.dart';

import 'configuration/auth.dart';
import 'configuration/preferences.dart';
import 'fil.dart';

part 'builder.g.dart';

@JsonSerializable()
class Builder {
  Preferences preferences;
  Auth auth;

  Map<String, dynamic> toJson() => _$BuilderToJson(this);
}

Future<Fil> startFil(
  ApplicationSetup Function(Builder builder) build,
) async {
  final builder = Builder();
  final applicationSetup = build(builder);

  await Fil.channel.invokeMethod(
    'startFil',
    [builder.toJson(), applicationSetup.toJson()],
  );

  return Fil(applicationSetup);
}

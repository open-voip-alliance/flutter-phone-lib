import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import '../util/equatable.dart';

part 'auth.g.dart';

@JsonSerializable()
class Auth extends Equatable {
  final String username;
  final String password;
  final String domain;
  final int port;
  final bool secure;

  const Auth({
    @required this.username,
    @required this.password,
    @required this.domain,
    @required this.port,
    @required this.secure,
  });

  @override
  @JsonKey(ignore: true)
  List<Object> get props => [username, password, domain, port, secure];

  Map<String, dynamic> toJson() => _$AuthToJson(this);
}

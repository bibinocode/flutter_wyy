import 'package:json_annotation/json_annotation.dart';

part 'login_models.g.dart';

@JsonSerializable()
class SendVerificationCodeRequest {
  final String phone;

  SendVerificationCodeRequest({required this.phone});

  factory SendVerificationCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$SendVerificationCodeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendVerificationCodeRequestToJson(this);
}

@JsonSerializable()
class SendVerificationCodeResponse {
  final int code;
  final bool data;

  SendVerificationCodeResponse({required this.code, required this.data});

  factory SendVerificationCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$SendVerificationCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SendVerificationCodeResponseToJson(this);
}

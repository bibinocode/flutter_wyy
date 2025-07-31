// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendVerificationCodeRequest _$SendVerificationCodeRequestFromJson(
  Map<String, dynamic> json,
) => SendVerificationCodeRequest(phone: json['phone'] as String);

Map<String, dynamic> _$SendVerificationCodeRequestToJson(
  SendVerificationCodeRequest instance,
) => <String, dynamic>{'phone': instance.phone};

SendVerificationCodeResponse _$SendVerificationCodeResponseFromJson(
  Map<String, dynamic> json,
) => SendVerificationCodeResponse(
  code: (json['code'] as num).toInt(),
  data: json['data'] as bool,
);

Map<String, dynamic> _$SendVerificationCodeResponseToJson(
  SendVerificationCodeResponse instance,
) => <String, dynamic>{'code': instance.code, 'data': instance.data};

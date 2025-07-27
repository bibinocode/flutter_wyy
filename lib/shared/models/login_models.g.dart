// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseLoginResponse _$BaseLoginResponseFromJson(Map<String, dynamic> json) =>
    BaseLoginResponse(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String?,
      cookie: json['cookie'] as String?,
    );

Map<String, dynamic> _$BaseLoginResponseToJson(BaseLoginResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'cookie': instance.cookie,
    };

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
  userId: (json['userId'] as num).toInt(),
  nickname: json['nickname'] as String,
  avatarUrl: json['avatarUrl'] as String?,
  backgroundUrl: json['backgroundUrl'] as String?,
  signature: json['signature'] as String?,
  gender: (json['gender'] as num?)?.toInt(),
  birthday: (json['birthday'] as num?)?.toInt(),
  province: (json['province'] as num?)?.toInt(),
  city: (json['city'] as num?)?.toInt(),
  vipType: (json['vipType'] as num?)?.toInt(),
  userType: (json['userType'] as num?)?.toInt(),
);

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
  'userId': instance.userId,
  'nickname': instance.nickname,
  'avatarUrl': instance.avatarUrl,
  'backgroundUrl': instance.backgroundUrl,
  'signature': instance.signature,
  'gender': instance.gender,
  'birthday': instance.birthday,
  'province': instance.province,
  'city': instance.city,
  'vipType': instance.vipType,
  'userType': instance.userType,
};

PhoneLoginResponse _$PhoneLoginResponseFromJson(Map<String, dynamic> json) =>
    PhoneLoginResponse(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String?,
      cookie: json['cookie'] as String?,
      profile: json['profile'] == null
          ? null
          : UserInfo.fromJson(json['profile'] as Map<String, dynamic>),
      account: json['account'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$PhoneLoginResponseToJson(PhoneLoginResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'cookie': instance.cookie,
      'profile': instance.profile,
      'account': instance.account,
    };

EmailLoginResponse _$EmailLoginResponseFromJson(Map<String, dynamic> json) =>
    EmailLoginResponse(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String?,
      cookie: json['cookie'] as String?,
      profile: json['profile'] == null
          ? null
          : UserInfo.fromJson(json['profile'] as Map<String, dynamic>),
      account: json['account'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$EmailLoginResponseToJson(EmailLoginResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'cookie': instance.cookie,
      'profile': instance.profile,
      'account': instance.account,
    };

CaptchaSendResponse _$CaptchaSendResponseFromJson(Map<String, dynamic> json) =>
    CaptchaSendResponse(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String?,
      data: json['data'] as bool?,
    );

Map<String, dynamic> _$CaptchaSendResponseToJson(
  CaptchaSendResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'message': instance.message,
  'data': instance.data,
};

CaptchaVerifyResponse _$CaptchaVerifyResponseFromJson(
  Map<String, dynamic> json,
) => CaptchaVerifyResponse(
  code: (json['code'] as num).toInt(),
  message: json['message'] as String?,
  data: json['data'] as bool?,
);

Map<String, dynamic> _$CaptchaVerifyResponseToJson(
  CaptchaVerifyResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'message': instance.message,
  'data': instance.data,
};

QRKeyResponse _$QRKeyResponseFromJson(Map<String, dynamic> json) =>
    QRKeyResponse(
      code: (json['code'] as num).toInt(),
      data: json['data'] == null
          ? null
          : QRKeyData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QRKeyResponseToJson(QRKeyResponse instance) =>
    <String, dynamic>{'code': instance.code, 'data': instance.data};

QRKeyData _$QRKeyDataFromJson(Map<String, dynamic> json) => QRKeyData(
  code: (json['code'] as num).toInt(),
  unikey: json['unikey'] as String,
);

Map<String, dynamic> _$QRKeyDataToJson(QRKeyData instance) => <String, dynamic>{
  'code': instance.code,
  'unikey': instance.unikey,
};

QRCreateResponse _$QRCreateResponseFromJson(Map<String, dynamic> json) =>
    QRCreateResponse(
      code: (json['code'] as num).toInt(),
      data: json['data'] == null
          ? null
          : QRCreateData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QRCreateResponseToJson(QRCreateResponse instance) =>
    <String, dynamic>{'code': instance.code, 'data': instance.data};

QRCreateData _$QRCreateDataFromJson(Map<String, dynamic> json) => QRCreateData(
  qrurl: json['qrurl'] as String,
  qrimg: json['qrimg'] as String?,
);

Map<String, dynamic> _$QRCreateDataToJson(QRCreateData instance) =>
    <String, dynamic>{'qrurl': instance.qrurl, 'qrimg': instance.qrimg};

QRCheckResponse _$QRCheckResponseFromJson(Map<String, dynamic> json) =>
    QRCheckResponse(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String?,
      cookie: json['cookie'] as String?,
      profile: json['profile'] == null
          ? null
          : UserInfo.fromJson(json['profile'] as Map<String, dynamic>),
      account: json['account'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$QRCheckResponseToJson(QRCheckResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'cookie': instance.cookie,
      'profile': instance.profile,
      'account': instance.account,
    };

AnonymousLoginResponse _$AnonymousLoginResponseFromJson(
  Map<String, dynamic> json,
) => AnonymousLoginResponse(
  code: (json['code'] as num).toInt(),
  message: json['message'] as String?,
  cookie: json['cookie'] as String?,
  createTime: (json['createTime'] as num?)?.toInt(),
);

Map<String, dynamic> _$AnonymousLoginResponseToJson(
  AnonymousLoginResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'message': instance.message,
  'cookie': instance.cookie,
  'createTime': instance.createTime,
};

LoginStatusResponse _$LoginStatusResponseFromJson(Map<String, dynamic> json) =>
    LoginStatusResponse(
      code: (json['code'] as num).toInt(),
      profile: json['profile'] == null
          ? null
          : UserInfo.fromJson(json['profile'] as Map<String, dynamic>),
      account: json['account'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$LoginStatusResponseToJson(
  LoginStatusResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'profile': instance.profile,
  'account': instance.account,
};

UserDetailResponse _$UserDetailResponseFromJson(Map<String, dynamic> json) =>
    UserDetailResponse(
      code: (json['code'] as num).toInt(),
      profile: json['profile'] == null
          ? null
          : UserInfo.fromJson(json['profile'] as Map<String, dynamic>),
      level: (json['level'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserDetailResponseToJson(UserDetailResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'profile': instance.profile,
      'level': instance.level,
    };

UserAccountResponse _$UserAccountResponseFromJson(Map<String, dynamic> json) =>
    UserAccountResponse(
      code: (json['code'] as num).toInt(),
      profile: json['profile'] == null
          ? null
          : UserInfo.fromJson(json['profile'] as Map<String, dynamic>),
      account: json['account'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$UserAccountResponseToJson(
  UserAccountResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'profile': instance.profile,
  'account': instance.account,
};

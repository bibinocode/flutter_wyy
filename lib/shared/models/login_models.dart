import 'package:json_annotation/json_annotation.dart';

part 'login_models.g.dart';

/// 登录响应基础类
@JsonSerializable()
class BaseLoginResponse {
  @JsonKey(name: 'code')
  final int code;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'cookie')
  final String? cookie;

  const BaseLoginResponse({required this.code, this.message, this.cookie});

  factory BaseLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseLoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseLoginResponseToJson(this);

  /// 是否登录成功
  bool get isSuccess => code == 200;
}

/// 用户信息模型
@JsonSerializable()
class UserInfo {
  @JsonKey(name: 'userId')
  final int userId;

  @JsonKey(name: 'nickname')
  final String nickname;

  @JsonKey(name: 'avatarUrl')
  final String? avatarUrl;

  @JsonKey(name: 'backgroundUrl')
  final String? backgroundUrl;

  @JsonKey(name: 'signature')
  final String? signature;

  @JsonKey(name: 'gender')
  final int? gender;

  @JsonKey(name: 'birthday')
  final int? birthday;

  @JsonKey(name: 'province')
  final int? province;

  @JsonKey(name: 'city')
  final int? city;

  @JsonKey(name: 'vipType')
  final int? vipType;

  @JsonKey(name: 'userType')
  final int? userType;

  const UserInfo({
    required this.userId,
    required this.nickname,
    this.avatarUrl,
    this.backgroundUrl,
    this.signature,
    this.gender,
    this.birthday,
    this.province,
    this.city,
    this.vipType,
    this.userType,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

/// 手机登录响应
@JsonSerializable()
class PhoneLoginResponse extends BaseLoginResponse {
  @JsonKey(name: 'profile')
  final UserInfo? profile;

  @JsonKey(name: 'account')
  final Map<String, dynamic>? account;

  const PhoneLoginResponse({
    required super.code,
    super.message,
    super.cookie,
    this.profile,
    this.account,
  });

  factory PhoneLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$PhoneLoginResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PhoneLoginResponseToJson(this);
}

/// 邮箱登录响应
@JsonSerializable()
class EmailLoginResponse extends BaseLoginResponse {
  @JsonKey(name: 'profile')
  final UserInfo? profile;

  @JsonKey(name: 'account')
  final Map<String, dynamic>? account;

  const EmailLoginResponse({
    required super.code,
    super.message,
    super.cookie,
    this.profile,
    this.account,
  });

  factory EmailLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$EmailLoginResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EmailLoginResponseToJson(this);
}

/// 验证码发送响应
@JsonSerializable()
class CaptchaSendResponse {
  @JsonKey(name: 'code')
  final int code;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'data')
  final bool? data;

  const CaptchaSendResponse({required this.code, this.message, this.data});

  factory CaptchaSendResponse.fromJson(Map<String, dynamic> json) =>
      _$CaptchaSendResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CaptchaSendResponseToJson(this);

  /// 是否发送成功
  bool get isSuccess => code == 200;
}

/// 验证码验证响应
@JsonSerializable()
class CaptchaVerifyResponse {
  @JsonKey(name: 'code')
  final int code;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'data')
  final bool? data;

  const CaptchaVerifyResponse({required this.code, this.message, this.data});

  factory CaptchaVerifyResponse.fromJson(Map<String, dynamic> json) =>
      _$CaptchaVerifyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CaptchaVerifyResponseToJson(this);

  /// 是否验证成功
  bool get isSuccess => code == 200 && data == true;
}

/// 二维码Key生成响应
@JsonSerializable()
class QRKeyResponse {
  @JsonKey(name: 'code')
  final int code;

  @JsonKey(name: 'data')
  final QRKeyData? data;

  const QRKeyResponse({required this.code, this.data});

  factory QRKeyResponse.fromJson(Map<String, dynamic> json) =>
      _$QRKeyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QRKeyResponseToJson(this);

  bool get isSuccess => code == 200;
}

@JsonSerializable()
class QRKeyData {
  @JsonKey(name: 'code')
  final int code;

  @JsonKey(name: 'unikey')
  final String unikey;

  const QRKeyData({required this.code, required this.unikey});

  factory QRKeyData.fromJson(Map<String, dynamic> json) =>
      _$QRKeyDataFromJson(json);

  Map<String, dynamic> toJson() => _$QRKeyDataToJson(this);
}

/// 二维码生成响应
@JsonSerializable()
class QRCreateResponse {
  @JsonKey(name: 'code')
  final int code;

  @JsonKey(name: 'data')
  final QRCreateData? data;

  const QRCreateResponse({required this.code, this.data});

  factory QRCreateResponse.fromJson(Map<String, dynamic> json) =>
      _$QRCreateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QRCreateResponseToJson(this);

  bool get isSuccess => code == 200;
}

@JsonSerializable()
class QRCreateData {
  @JsonKey(name: 'qrurl')
  final String qrurl;

  @JsonKey(name: 'qrimg')
  final String? qrimg;

  const QRCreateData({required this.qrurl, this.qrimg});

  factory QRCreateData.fromJson(Map<String, dynamic> json) =>
      _$QRCreateDataFromJson(json);

  Map<String, dynamic> toJson() => _$QRCreateDataToJson(this);
}

/// 二维码状态检查响应
@JsonSerializable()
class QRCheckResponse extends BaseLoginResponse {
  @JsonKey(name: 'profile')
  final UserInfo? profile;

  @JsonKey(name: 'account')
  final Map<String, dynamic>? account;

  const QRCheckResponse({
    required super.code,
    super.message,
    super.cookie,
    this.profile,
    this.account,
  });

  factory QRCheckResponse.fromJson(Map<String, dynamic> json) =>
      _$QRCheckResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$QRCheckResponseToJson(this);

  /// 二维码状态
  QRStatus get status {
    switch (code) {
      case 800:
        return QRStatus.expired;
      case 801:
        return QRStatus.waiting;
      case 802:
        return QRStatus.scanned;
      case 803:
        return QRStatus.confirmed;
      default:
        return QRStatus.unknown;
    }
  }
}

/// 二维码状态枚举
enum QRStatus {
  expired, // 800: 二维码过期
  waiting, // 801: 等待扫码
  scanned, // 802: 待确认
  confirmed, // 803: 授权登录成功
  unknown, // 其他状态
}

/// 游客登录响应
@JsonSerializable()
class AnonymousLoginResponse extends BaseLoginResponse {
  @JsonKey(name: 'createTime')
  final int? createTime;

  const AnonymousLoginResponse({
    required super.code,
    super.message,
    super.cookie,
    this.createTime,
  });

  factory AnonymousLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$AnonymousLoginResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AnonymousLoginResponseToJson(this);
}

/// 登录状态响应
@JsonSerializable()
class LoginStatusResponse {
  @JsonKey(name: 'code')
  final int code;

  @JsonKey(name: 'profile')
  final UserInfo? profile;

  @JsonKey(name: 'account')
  final Map<String, dynamic>? account;

  const LoginStatusResponse({required this.code, this.profile, this.account});

  factory LoginStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginStatusResponseToJson(this);

  /// 是否已登录
  bool get isLoggedIn => code == 200 && profile != null;
}

/// 用户详情响应
@JsonSerializable()
class UserDetailResponse {
  @JsonKey(name: 'code')
  final int code;

  @JsonKey(name: 'profile')
  final UserInfo? profile;

  @JsonKey(name: 'level')
  final int? level;

  const UserDetailResponse({required this.code, this.profile, this.level});

  factory UserDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$UserDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailResponseToJson(this);

  bool get isSuccess => code == 200;
}

/// 账号信息响应
@JsonSerializable()
class UserAccountResponse {
  @JsonKey(name: 'code')
  final int code;

  @JsonKey(name: 'profile')
  final UserInfo? profile;

  @JsonKey(name: 'account')
  final Map<String, dynamic>? account;

  const UserAccountResponse({required this.code, this.profile, this.account});

  factory UserAccountResponse.fromJson(Map<String, dynamic> json) =>
      _$UserAccountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserAccountResponseToJson(this);

  bool get isSuccess => code == 200;
}

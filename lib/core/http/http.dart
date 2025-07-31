import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:wyy_flutter/core/http/alice_interceptor.dart';
import 'package:wyy_flutter/core/http/error_interceptor.dart';

/// 封装 dio
class Http {
  // 连接超时时间
  static const int _connectTimeout = 10000;
  // 响应超时时间
  static const int _receiveTimeout = 5000;

  // 单例
  static Http? _instance;
  // 获取单例
  factory Http() {
    return _instance ??= Http._internal();
  }

  // 创建 dio 实例 延迟初始化
  static late final Dio _dio;
  static late String baseUrl;

  // Cookie 管理器
  static late CookieManager _cookieManager;
  // 路径管理器
  static late PathProvider _pathProvider;

  /// 获取 dio 实例
  static Dio get dio => _dio;

  /// 初始化
  Http._internal();

  /// 初始化 cookie 管理器
  static Future<void> _initializeCookieManager() async {
    _pathProvider = PathProvider();
    await _pathProvider.init();

    // 初始化 cookie 管理器
    _cookieManager = CookieManager(
      // 持久化 cookie 管理器 cookie_jar 的 PersistCookieJar 类
      PersistCookieJar(
        storage: FileStorage(_pathProvider.getCookieSavedPath()),
      ),
    );

    // 添加到dio 拦截器
    _dio.interceptors.add(_cookieManager);
  }

  /// 初始化
  /// - @param baseUrl 基础 url
  /// - @param connectTimeout 连接超时时间
  /// - @param receiveTimeout 响应超时时间
  static Future<void> init({
    required String baseUrl,
    int? connectTimeout,
    int? receiveTimeout,
    List<Interceptor>? interceptors,
  }) async {
    Http.baseUrl = baseUrl;

    // 初始化 dio 实例 - 这行代码缺失，导致了错误
    _dio = Dio();

    // DEUBG 模式开启日志美化
    if (bool.fromEnvironment('DEBUG')) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true, // 请求头
          requestBody: true, // 请求体
          responseBody: true, // 响应体
          responseHeader: true, // 响应头
          error: true, // 错误
          compact: true, // 紧凑
          maxWidth: 90, // 最大宽度
          logPrint: (object) {
            if (object is String) {
              // 替换掉 ║ 字符
              print(object.replaceAll('║', ''));
            }
          },
        ),
      );
    }

    // 添加 alice 拦截器
    _dio.interceptors.add(AliceInterceptor());

    // 错误处理
    _dio.interceptors.add(ErrorInterceptor());

    // 请求缓存
    final cacheStore = MemCacheStore(
      maxSize: 1024 * 1024 * 10, // 10MB  总允许大小
      maxEntrySize: 1024 * 1024 * 1, // 1MB 每个缓存条目的最大大小
    );

    final cacheOptios = CacheOptions(
      store: cacheStore, // 缓存存储
      policy: CachePolicy.request, // 缓存策略 请求时缓存
      hitCacheOnErrorCodes: [401, 403], // 错误时 不缓存
      priority: CachePriority.high, // 缓存优先级
      maxStale: const Duration(days: 7), // 缓存过期时间
      allowPostMethod: false, // 是否允许 post 请求缓存
    );

    _dio.interceptors.add(DioCacheInterceptor(options: cacheOptios));

    await _initializeCookieManager();

    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      // 连接超时时间 milliseconds 毫秒
      connectTimeout: Duration(milliseconds: connectTimeout ?? _connectTimeout),
      // 响应超时时间 milliseconds 毫秒
      receiveTimeout: Duration(milliseconds: receiveTimeout ?? _receiveTimeout),
      contentType: 'application/json;charset=utf-8',
      // 请求头
      headers: {'withCredentials': true},
    );

    if (interceptors != null && interceptors.isNotEmpty) {
      _dio.interceptors.addAll(interceptors);
    }
  }

  void setHeaders(Map<String, dynamic> map) {
    _dio.options.headers.addAll(map);
  }

  /// 检查 cookie
  static Future<bool> checkCookie() async {
    var cookies = await _cookieManager.cookieJar.loadForRequest(
      Uri.parse(baseUrl),
    );
    return cookies.isNotEmpty;
  }

  /// 加载 cookie
  static Future<List<Cookie>> loadCookies({Uri? host}) async {
    return await _cookieManager.cookieJar.loadForRequest(
      host ?? Uri.parse(baseUrl),
    );
  }

  /// 清除 cookie
  static Future<void> clearCookie() async {
    await _cookieManager.cookieJar.deleteAll();
  }

  /// get 请求
  Future get(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    bool refresh = false,
  }) async {
    // 请求选项
    Options requestOptions = options ?? Options();
    // 复制请求选项
    requestOptions = requestOptions.copyWith(extra: {"refresh": refresh});
    // 拼接参数
    Map<String, dynamic> queryParams = {...?params};
    // 响应
    Response response;
    // 拼接 &realIP=116.25.146.177
    response = await _dio.get(
      path,
      queryParameters: queryParams,
      options: requestOptions,
    );
    return response.data;
  }

  Future post(
    String path, {
    Map<String, dynamic>? params,
    data,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    var response = await dio.post(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
    );
    return response.data;
  }

  Future put(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();

    var response = await dio.put(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
    );
    return response.data;
  }

  Future delete(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();

    var response = await dio.delete(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
    );
    return response.data;
  }
}

/// 路径管理器
class PathProvider {
  var _cookiePath = '';
  var _dataPath = '';

  init() async {
    _cookiePath =
        "${(await getApplicationSupportDirectory()).absolute.path}/flutter_music/.cookies/";
    _dataPath =
        "${(await getApplicationSupportDirectory()).absolute.path}/flutter_music/.data/";
  }

  String getCookieSavedPath() {
    return _cookiePath;
  }

  String getDataSavedPath() {
    return _dataPath;
  }
}

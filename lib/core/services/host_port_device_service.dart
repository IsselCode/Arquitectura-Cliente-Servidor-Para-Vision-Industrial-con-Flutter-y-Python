class HostPortDeviceService {
  HostPortDeviceService._internal();

  static final HostPortDeviceService _instance = HostPortDeviceService._internal();

  factory HostPortDeviceService() => _instance;

  String? _host;
  String? _port;

  String? get host => _host;
  String? get port => _port;

  bool get isConfigured =>
      _host != null &&
      _host!.isNotEmpty &&
      _port != null &&
      _port!.isNotEmpty;

  void configure({
    required String host,
    required String port,
  }) {
    _host = host;
    _port = port;
  }

  String get baseUrl {
    if (!isConfigured) {
      throw StateError(
        'HostPortDeviceService is not configured. Set host and port before using it.',
      );
    }

    return 'http://$_host:$_port';
  }

  Uri configUri([String? configName]) {
    if (configName == null || configName.isEmpty) {
      return Uri.parse('$baseUrl/config');
    }

    return Uri.parse('$baseUrl/config/$configName');
  }

}

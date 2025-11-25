class DeviceEntity {
  final String name;
  final String host;
  final int port;
  final Map<String, dynamic> txt;
  bool license;
  DeviceEntity(this.name, this.host, this.port, this.txt, this.license);
}
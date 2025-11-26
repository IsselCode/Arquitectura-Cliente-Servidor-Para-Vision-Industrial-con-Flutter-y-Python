class LicenseEntity {

  bool activated;
  int limit;
  String company;
  String system;
  String responsablePersonName;

  LicenseEntity({
    required this.activated,
    required this.limit,
    required this.company,
    required this.system,
    required this.responsablePersonName,
  });

}
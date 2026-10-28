class AngkotRoute {
  const AngkotRoute({
    required this.code,
    required this.route,
    required this.childFare,
    required this.adultFare,
  });

  final String code;
  final String route;
  final int childFare;
  final int adultFare;
}

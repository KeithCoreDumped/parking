class CarPlateProvider {
  static String? carPlate;

  static void bindCarPlate(String plate) {
    carPlate = plate;
  }

  static bool isBound() => carPlate != null;

  static void unbind() {
    carPlate = null;
  }
}

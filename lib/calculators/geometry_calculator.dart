class GeometryCalculator {
  // Luas
  static double calculateRectangleArea(double length, double width) {
    return length * width;
  }

  static double calculateCircleArea(double radius) {
    return 3.14 * radius * radius;
  }

  static double calculateTriangleArea(double base, double height) {
    return 0.5 * base * height;
  }

  // Volume
  static double calculateCubeVolume(double side) {
    return side * side * side;
  }

  static double calculateSphereVolume(double radius) {
    return (4/3) * 3.14 * radius * radius * radius;
  }

  static double calculateCylinderVolume(double radius, double height) {
    return 3.14 * radius * radius * height;
  }
} 
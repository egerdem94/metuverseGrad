class Util{
  static List<int> getResizedDimensions(int desiredHeight, int width, int height) {
    if (height <= desiredHeight) return [height, width];
    double ratio = height / desiredHeight;
    return [(width / ratio).round(), desiredHeight];
  }
}
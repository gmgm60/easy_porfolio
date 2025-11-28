 enum CompressFormat { jpeg, png, webp }

class CompressOptions {
  final int quality; // 0..100
  final int? minWidth;
  final int? minHeight;
  final CompressFormat format;

  const CompressOptions({
    this.quality = 80,
    this.minWidth,
    this.minHeight,
    this.format = CompressFormat.jpeg,
  }) : assert(quality >= 0 && quality <= 100);
}

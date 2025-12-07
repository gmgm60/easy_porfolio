import 'dart:io';
import 'dart:typed_data';

class PickedImage {
  final String name;
  final String? path; // null on web sometimes
  final Uint8List? bytes;

  const PickedImage({
    required this.name,
    required this.path,
    this.bytes,
  });

  PickedImage copyWith({
    String? name,
    String? path,
    Uint8List? bytes,
  }) {
    return PickedImage(
      name: name ?? this.name,
      path: path ?? this.path,
      bytes: bytes ?? this.bytes,
    );
  }

  Future<Uint8List> readBytes() async {
    if (bytes != null) {
      return bytes!;
    }
    if (path != null) {
      final file = File(path!);
      return file.readAsBytes();
    }
    throw Exception('No bytes and no path available for image $name');
  }

  @override
  String toString() =>
      'PickedImageModel(name: $name, path: $path, bytes: ${bytes?.length ?? "null"})';
}

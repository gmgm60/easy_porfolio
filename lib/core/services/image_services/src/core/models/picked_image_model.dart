import 'dart:io';
import 'dart:typed_data';

class PickedImageModel {
  final String name;
  final String? path; // null on web sometimes
  final Uint8List? bytes;

  const PickedImageModel({
    required this.name,
    required this.path,
    this.bytes,
  });

  PickedImageModel copyWith({
    String? name,
    String? path,
    Uint8List? bytes,
  }) {
    return PickedImageModel(
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
      return await file.readAsBytes();
    }
    throw Exception('No bytes and no path available for image $name');
  }

  @override
  String toString() =>
      'PickedImageModel(name: $name, path: $path, bytes: ${bytes?.length ?? "null"})';
}

// Package imports:
import 'package:image_picker/image_picker.dart';

class ImageService {
  static Future<String?> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: source);

    return image?.path;
  }
}

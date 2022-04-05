import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageControl extends StatefulWidget {
  @override
  State<ImageControl> createState() => _ImageControlState();
}

class _ImageControlState extends State<ImageControl> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ImagePicker"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        try {
          final XFile? pickedFile =
              await _picker.pickImage(source: ImageSource.gallery);
          setState(() {
            _image = pickedFile;
          });
        } catch (e) {
          print(e);
        }
      }),
    );
  }
}

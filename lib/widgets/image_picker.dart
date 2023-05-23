import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerButton extends StatefulWidget {
  const ImagePickerButton({super.key});

  @override
  State<ImagePickerButton> createState() => _ImagePickerButtonState();
}

class _ImagePickerButtonState extends State<ImagePickerButton> {
  File? _pickedImage;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  String getFileName() {
    if (_pickedImage != null) {
      return _pickedImage!.path.split('/').last;
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _pickImage,
      child: Column(
        children: [
          Container(
            height: 48.0,
            width: 48.0,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.image,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            getFileName(),
            style: const TextStyle(fontSize: 12.0, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}

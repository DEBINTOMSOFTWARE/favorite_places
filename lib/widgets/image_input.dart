import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickedImage});

  final void Function(File image) onPickedImage;

  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  void _takeImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (pickedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(pickedImage.path);
    });
    
    widget.onPickedImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
        onPressed: _takeImage,
        icon: const Icon(Icons.camera),
        label: const Text('Take Picture'));

    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _takeImage,
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }
    return Container(
      height: 300,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3))),
      child: content,
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final double height1;
  final double width1;
  final String text;
  final void Function(File image) submitImage;
  const ImageInput(this.height1, this.width1, this.text, this.submitImage,
      {Key? key})
      : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  Future<void> _takePicture() async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 720,
        maxHeight: 720,
        imageQuality: 80);
    setState(() {
      _storedImage = File(image!.path);
    });
    widget.submitImage(_storedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(
                width: 2,
                color: _storedImage != null ? Colors.grey : Colors.red),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        height: widget.height1,
        width: widget.width1,
        child: InkWell(
          onTap: _takePicture,
          child: _storedImage != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    _storedImage!,
                    width: widget.width1,
                    height: widget.height1,
                    fit: BoxFit.cover,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Text(
                      widget.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
        ));
  }
}

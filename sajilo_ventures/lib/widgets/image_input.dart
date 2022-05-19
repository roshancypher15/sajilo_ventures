import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final double height1;
  final double width1;
  final String text;
  const ImageInput(this.height1, this.width1, this.text, {Key? key})
      : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  Future<void> _takePicture() async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(
        source: ImageSource.gallery, maxWidth: 600, maxHeight: 600);
    setState(() {
      _storedImage = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 5,
        ),
        InkWell(
          onTap: _takePicture,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    width: 2,
                    color: _storedImage != null ? Colors.red : Colors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            height: widget.height1,
            width: widget.width1,
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
                : Container(
                    child: Center(
                      child: Text(
                        widget.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
            alignment: Alignment.center,
          ),
        )
      ],
    );
  }
}

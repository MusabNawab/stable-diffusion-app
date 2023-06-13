import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String? imageSource;
  final String? _prompt;
  const ImageWidget(this.imageSource, this._prompt, {super.key});

  @override
  Widget build(BuildContext context) {
    Uint8List decodedbytes = base64.decode(imageSource!);

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 15, bottom: 15),
          height: 300,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              border: Border.all(
                width: 3,
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.memory(base64Decode(imageSource!))),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: kIsWeb
              ? const SizedBox()
              : ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      fixedSize: const Size(150, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onPressed: () async {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        "Image saved in Gallery!",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                    ));

                    ImageGallerySaver.saveImage(decodedbytes, name: _prompt);
                  },
                  label: const Text('Download'),
                  icon: const Icon(Icons.download),
                ),
        )
      ],
    );
  }
}

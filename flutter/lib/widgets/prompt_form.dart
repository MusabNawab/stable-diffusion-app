import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:major_project/widgets/err.dart';
import 'package:major_project/widgets/generate_btn.dart';
import 'package:major_project/widgets/image_widget.dart';
import 'dart:convert';
import 'package:major_project/models/text_validation.dart';
import 'package:major_project/widgets/sliders.dart';

class PromptForm extends StatefulWidget {
  String? imageSource;
  PromptForm(this.imageSource);

  @override
  State<PromptForm> createState() => _PromptFormState();
}

class _PromptFormState extends State<PromptForm> {
  final _key = GlobalKey<FormState>();
  final _prompt = TextEditingController();
  final _negativePrompt = TextEditingController();
  var _isLoading = false;
  double? gds;
  double? steps;
  double? seeds;
  bool _valid = true;

  var statusCode = 0;
  final url = Uri.https("tasty-bear-76.loca.lt", "/text2img");
  Future<void> postRequest() async {
    setState(() {
      _isLoading = true;
    });
    final response = await http.post(
      url,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Bypass-Tunnel-Reminder': '1'
      },
      body: json.encode({
        "prompt": _prompt.text,
        "negative_prompt": _negativePrompt.text,
        "scheduler": "EulerAncestralDiscreteScheduler",
        "image_height": 512,
        "image_width": 512,
        "num_images": 1,
        "guidance_scale": gds ?? 7,
        "steps": steps ?? 150,
        "seed": seeds ?? 37,
      }),
    );
    statusCode = response.statusCode;
    if (statusCode <= 400) {
      final responseBody = json.decode(response.body);
      final base64Img = responseBody['images'].toString();
      widget.imageSource = base64Img.substring(1, base64Img.length - 1);
    } else {
      widget.imageSource = '';
    }
    setState(() {
      _isLoading = false;
    });
  }

  bool validator(String val) {
    for (var element in check) {
      if (val.contains(element)) {
        _valid = true;
        return _valid;
      } else {
        _valid = false;
      }
    }
    return _valid;
  }

  @override
  void dispose() {
    super.dispose();
    _prompt.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(left: 5),
                child: const Text('Prompt* :', style: TextStyle(fontSize: 16))),
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 370,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 5),
              child: Form(
                key: _key,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter a prompt";
                    }
                    if (validator(value.toLowerCase())) {
                      return "Generating adult content isn't allowed";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Description Of Image'),
                  controller: _prompt,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(left: 5),
                child: const Text('Negative Prompt:',
                    style: TextStyle(fontSize: 16))),
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 370,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 5),
              child: Form(
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'These objects will be excluded in image'),
                  controller: _negativePrompt,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Sliders(
          gds: (val) {
            gds = val;
          },
          step: (val) {
            steps = val;
          },
          seed: (val) {
            seeds = val;
          },
        ),
        const SizedBox(
          height: 15,
        ),
        GenerateBtn(_isLoading, postRequest, _key),
        widget.imageSource == null || _isLoading
            ? Container()
            : statusCode >= 400
                ? const Err()
                : ImageWidget(widget.imageSource, _prompt.text)
      ],
    );
  }
}

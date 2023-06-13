import 'package:flutter/material.dart';

class Sliders extends StatefulWidget {
  const Sliders(
      {super.key, required this.gds, required this.step, required this.seed});

  final void Function(double val) gds;
  final void Function(double val) step;
  final void Function(double val) seed;

  @override
  State<Sliders> createState() => _SlidersState();
}

class _SlidersState extends State<Sliders> {
  double gds = 7;
  double steps = 150;
  double seed = 37;

  void setGDS(double value) {
    setState(() {
      gds = value;
      widget.gds(gds);
    });
  }

  void setSteps(double value) {
    setState(() {
      steps = value;
      widget.gds(steps);
    });
  }

  void setSeed(double value) {
    setState(() {
      seed = value;
      widget.gds(seed);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.only(left: 32),
            child: Text('Guidance Scale: ${gds.toInt()}',
                style: const TextStyle(fontSize: 16))),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: Slider(
              min: 7,
              max: 20,
              divisions: 13,
              label: gds.toInt().toString(),
              value: gds,
              activeColor: Colors.red,
              inactiveColor: Colors.red.withAlpha(35),
              onChanged: (val) {
                setGDS(val);
              }),
        ),
        Container(
            margin: const EdgeInsets.only(left: 32),
            child: Text('Steps: ${steps.toInt()}',
                style: const TextStyle(fontSize: 16))),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: Slider(
              min: 50,
              max: 200,
              divisions: 150,
              label: steps.toInt().toString(),
              value: steps,
              activeColor: Colors.red,
              inactiveColor: Colors.red.withAlpha(35),
              onChanged: (val) {
                setSteps(val);
              }),
        ),
        Container(
            margin: const EdgeInsets.only(left: 32),
            child: Text(
              'Seed: ${seed.toInt()}',
              style: const TextStyle(fontSize: 16),
            )),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: Slider(
              min: 5,
              max: 100,
              divisions: 95,
              label: seed.toInt().toString(),
              value: seed,
              activeColor: Colors.red,
              inactiveColor: Colors.red.withAlpha(35),
              onChanged: (val) {
                setSeed(val);
              }),
        ),
      ],
    );
  }
}

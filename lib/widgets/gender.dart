import 'package:flutter/material.dart';

class GenderRadioGroup extends StatefulWidget {
  const GenderRadioGroup({Key? key}) : super(key: key);

  @override
  State<GenderRadioGroup> createState() => _GenderRadioGroupState();
}

class _GenderRadioGroupState extends State<GenderRadioGroup> {

  // The inital group value
  String _selectedGender = 'male';

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Chọn giới tính:'),
            ListTile(
              leading: Radio<String>(
                value: 'male',
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
              ),
              title: const Text('Male'),
            ),
            ListTile(
              leading: Radio<String>(
                value: 'female',
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
              ),
              title: const Text('Female'),
            ),
          ],
        ));
  }
}

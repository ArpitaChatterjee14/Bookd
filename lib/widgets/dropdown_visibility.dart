import 'package:flutter/material.dart';

/// Flutter code sample for [DropdownButton].///
class Visibily {
  Visibily(this.name, this.icon);
  final String name;
  final Icon icon;
}

List<Visibily> visibily = [
  Visibily(
      'Private',
      const Icon(
        Icons.person,
        color: Color.fromARGB(255, 255, 182, 64),
      )),
  Visibily(
      'Public',
      const Icon(
        Icons.public,
        color: Color.fromARGB(255, 255, 182, 64),
      )),
  Visibily(
      'Friends',
      const Icon(
        Icons.group,
        color: Color.fromARGB(255, 255, 182, 64),
      )),
  Visibily(
      'Friends & Followers',
      const Icon(
        Icons.groups,
        color: Color.fromARGB(255, 255, 182, 64),
      )),
  Visibily(
      'Custom',
      const Icon(
        Icons.manage_accounts,
        color: Color.fromARGB(255, 255, 182, 64),
      )),
];

class DropdownVisibilyButtonExample extends StatefulWidget {
  const DropdownVisibilyButtonExample({super.key, required this.onTap});
  final void Function(Visibily items) onTap;

  @override
  State<DropdownVisibilyButtonExample> createState() =>
      _DropdownVisibilyButtonExampleState();
}

class _DropdownVisibilyButtonExampleState
    extends State<DropdownVisibilyButtonExample> {
  Visibily item = visibily.first;

  void getDropDownItem(Visibily selected) {
    widget.onTap(selected);
    setState(() {
      item = selected;
      // print(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Visibily>(
      borderRadius: BorderRadius.circular(20),
      icon: const Icon(Icons.arrow_drop_down),
      value: item,
      elevation: 16,
      style: TextStyle(color: Theme.of(context).colorScheme.primary),
      onChanged: (selected) {
        // This is called when the user selects an item.
        getDropDownItem(selected!);
      },
      items: visibily.map<DropdownMenuItem<Visibily>>((Visibily value) {
        return DropdownMenuItem<Visibily>(
          value: value,
          child: Row(
            children: [
              value.icon,
              SizedBox(
                width: 10,
              ),
              Text(
                value.name,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

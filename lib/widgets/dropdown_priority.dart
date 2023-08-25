import 'package:flutter/material.dart';

/// Flutter code sample for [DropdownButton].///
class Priority {
  Priority(this.name, this.icon);
  final String name;
  final Icon icon;
}

final List<Priority> priority = [
  Priority(
      'Low',
      const Icon(Icons.fiber_manual_record,
          color: Color.fromARGB(255, 146, 150, 255))),
  Priority(
      'Medium',
      const Icon(
        Icons.fiber_manual_record,
        color: Color.fromARGB(255, 134, 245, 158),
      )),
  Priority(
      'High',
      const Icon(
        Icons.fiber_manual_record,
        color: Color.fromARGB(255, 255, 146, 146),
      )),
  Priority(
      'Priority 4',
      const Icon(
        Icons.currency_rupee_rounded,
        color: Color(0xFF167F67),
      )),
  Priority(
      'Priority 5',
      const Icon(
        Icons.currency_rupee_rounded,
        color: Color(0xFF167F67),
      )),
];

class DropdownPriorityButtonExample extends StatefulWidget {
  const DropdownPriorityButtonExample({super.key, required this.onTap});
  final void Function(Priority items) onTap;

  @override
  State<DropdownPriorityButtonExample> createState() =>
      _DropdownPriorityButtonExampleState();
}

class _DropdownPriorityButtonExampleState
    extends State<DropdownPriorityButtonExample> {
  Priority item = priority.first;

  void getDropDownItem(Priority selected) {
    widget.onTap(selected);
    setState(() {
      item = selected;
      // print(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Priority>(
      borderRadius: BorderRadius.circular(20),
      icon: const Icon(Icons.arrow_drop_down),
      value: item,
      elevation: 16,
      style: TextStyle(color: Theme.of(context).colorScheme.primary),
      onChanged: (selected) {
        // This is called when the user selects an item.
        getDropDownItem(selected!);
      },
      items: priority.map<DropdownMenuItem<Priority>>((Priority value) {
        return DropdownMenuItem<Priority>(
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

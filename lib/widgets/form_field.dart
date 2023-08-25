import 'package:flutter/material.dart';

class InputFieldConfig extends StatelessWidget {
  final String inputVal;
  final bool hide;
  final TextInputType? fieldType;
  final String? Function(String? value) validation;
  final void Function(String? newValue) saved;
  final IconData image;
  TextEditingController? cont = TextEditingController();

  InputFieldConfig(
      {super.key,
      required this.inputVal,
      required this.hide,
      required this.fieldType,
      required this.validation,
      required this.saved,
      required this.image,
      this.cont});

  @override
  Widget build(context) {
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(20),
      shadowColor: const Color.fromARGB(43, 137, 137, 135),
      child: TextFormField(
        controller: cont,
        keyboardAppearance: Brightness.dark,
        keyboardType: fieldType,
        autocorrect: false,
        textCapitalization: TextCapitalization.none,
        validator: validation,
        decoration: InputDecoration(
            prefixIcon: Icon(image),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.error.withOpacity(0.3),
                    width: 1.0)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.error.withOpacity(0.3),
                    width: 1.0)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    width: 1.0)),
            contentPadding: const EdgeInsets.only(left: 20, right: 20),
            hintText: inputVal,
            filled: true,
            fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.07),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    width: 1.0))),
        obscureText: hide,
        onSaved: saved,
      ),
    );
  }
}

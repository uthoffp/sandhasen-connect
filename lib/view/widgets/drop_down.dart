import 'package:flutter/material.dart';

//dropdown widget which shows an outlined textfield and displays a menu dialog when clicked as dropdown menue
class DropDownInputField<T> extends StatefulWidget {
  final String? hint;
  final List<T> options;
  final void Function()? onChanged;
  final TextEditingController controller;
  bool showInitValue;

  DropDownInputField({Key? key,
    this.hint,
    required this.options,
    required this.controller,
    this.onChanged,
    required this.showInitValue,
  }) : super(key: key);

  @override
  State<DropDownInputField<T>> createState() => _DropDownInputFieldState<T>();
}

class _DropDownInputFieldState<T> extends State<DropDownInputField<T>> {
  bool _menuExpanded = false;


  @override
  void initState() {
    super.initState();
    setState(() {
      widget.controller.text = widget.showInitValue && widget.options[0] != null  ? widget.options[0].toString() : "";
    });
  }

  void _openOptions() {
    setState(() {
      _menuExpanded = true;
    });
    showDialog(
        context: context,
        builder: (_) => SimpleDialog(children: [
              for (var i = 0; i < widget.options.length; i++)
                SimpleDialogOption(
                  onPressed: () => _onOptionSelected(widget.options[i].toString()),
                  child: Text(
                    widget.options[i].toString(),
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
            ])).then((_) => setState(() {
          _menuExpanded = false;
        }));
  }

  void _onOptionSelected(String text) {
    setState(() {
      widget.controller.text = text;
      if(widget.onChanged != null) widget.onChanged!();
      Navigator.pop(context, true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.text,
      readOnly: true,
      onTap: _openOptions,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: widget.hint,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        hintText: widget.hint,
        suffixIcon: Icon(
          _menuExpanded ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up_rounded,
          color: Colors.grey,
        ),
        suffixIconConstraints: const BoxConstraints(
          minHeight: 32,
          minWidth: 32,
        ),
      ),
    );
  }
}

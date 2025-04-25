import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {
  final String title;
  final bool isPass, isNum;
  final TextEditingController controller;

  const InputWidget({
    super.key,
    required this.title,
    required this.isPass,
    required this.controller,
    required this.isNum,
  });

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(widget.title, style: TextStyle(fontSize: 15)),
          TextField(
            controller: widget.controller,
            style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark? Colors.white : Colors.black,
                fontFamily: "Arial",
                fontSize: 20),
            obscureText: widget.isPass && _isObscured,
            decoration: InputDecoration(
              hoverColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white : Colors.black,
              hintText: widget.isNum ? "+375xxxxxxxxx" : null,
              hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    width: 2
                ),
              ),
              suffixIcon: widget.isPass
                  ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              )
                  : null,
            ),
          ),
          const SizedBox(
            height: 60,
          )
        ]));
  }
}
import 'package:flutter/material.dart';

import '../../../../../utils.dart';

class InputText extends StatefulWidget {
  final String labelName;
  final String hint;
  final bool enabled;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const InputText(
      {super.key,
      required this.onChanged,
      required this.labelName,
      required this.hint,
      required this.enabled,
      required this.controller});

  @override
  State<InputText> createState() {
    return _InputTextState();
  }
}

class _InputTextState extends State<InputText> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 445;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      // input fields
      margin: EdgeInsets.fromLTRB(32 * fem, 0 * fem, 32.41 * fem, 22 * fem),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8.52 * fem),
            child: Text(
              widget.labelName,
              style: SafeGoogleFont(
                'Inter',
                fontSize: 12 * ffem,
                fontWeight: FontWeight.w400,
                height: 1.2125 * ffem / fem,
                color: const Color(0xff666666),
              ),
            ),
          ),
          Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffe7e7e7)),
                color: const Color(0xfff6f6f6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextFormField(
                controller: widget.controller,
                onChanged: (value) {
                  setState(() {
                    widget.onChanged(value);
                  });
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 14.0),
                  hintText: widget.hint,
                  hintStyle: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16 * ffem,
                    fontWeight: FontWeight.w500,
                    height: 1.2125 * ffem / fem,
                    color: const Color(0xffbdbdbd),
                  ),
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16 * ffem,
                  fontWeight: FontWeight.w500,
                  height: 1.2125 * ffem / fem,
                  color: const Color(0xff666666),
                ),
                enabled: widget.enabled,
              ))
        ],
      ),
    );

    // Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
    //   children: [
    //     IconButton(
    //       icon: Icon(
    //         Icons.remove,
    //         color: Theme.of(context).colorScheme.secondary,
    //       ),
    //       padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
    //       iconSize: 20.0,
    //       color: Theme.of(context).primaryColor,
    //       onPressed: () {
    //         setState(() {
    //           if (counter > widget.minValue) {
    //             counter--;
    //           }
    //           widget.onChanged(counter);
    //         });
    //       },
    //     ),
    //     Text(
    //       '$counter',
    //       textAlign: TextAlign.center,
    //       style: const TextStyle(
    //         color: Colors.black87,
    //         fontSize: 15.0,
    //         fontWeight: FontWeight.w500,
    //       ),
    //     ),
    //     IconButton(
    //       icon: Icon(
    //         Icons.add,
    //         color: Theme.of(context).colorScheme.secondary,
    //       ),
    //       padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
    //       iconSize: 20.0,
    //       color: Theme.of(context).primaryColor,
    //       onPressed: () {
    //         setState(() {
    //           if (counter < widget.maxValue) {
    //             counter++;
    //           }
    //           widget.onChanged(counter);
    //         });
    //       },
    //     ),
    //   ],
    // );
  }
}

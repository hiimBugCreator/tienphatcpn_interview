import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tienphatcpn_interview/extensions/number_extension.dart';

class LVMessage extends StatelessWidget {
  const LVMessage(
      {super.key,
      required this.message,
      required this.color,
      required this.prefixIcon,
      required this.textStyle});

  final String message;
  final Color color;
  final Widget prefixIcon;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Column(
            children: [
              Container(
                height: 44,
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(6)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: prefixIcon,
                      ),
                      13.horizontal,
                      Expanded(
                        child: Text(
                          message,
                          style: textStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              16.vertical,
            ],
          ),
        ),
      ],
    );
  }
}

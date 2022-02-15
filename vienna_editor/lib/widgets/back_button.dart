import 'package:flutter/material.dart';
import 'package:vienna_editor/consts.dart';

final _style = ButtonStyle(
  alignment: Alignment.center,
  padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
  side: MaterialStateProperty.all(BorderSide.none),
  backgroundColor: MaterialStateProperty.all(const Color(0xFF303030)),
);

class PaddedBackButton extends StatelessWidget {
  const PaddedBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => Navigator.of(context).pop(),
      style: _style.copyWith(
        minimumSize: MaterialStateProperty.all(
          Size.square(isDesktop() ? 60 : 45),
        ),
      ),
      child: const Icon(Icons.arrow_back),
    );
  }
}

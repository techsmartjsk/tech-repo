import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:Technovatives/constants.dart';
import 'package:Technovatives/widgets/logo.dart';

class Header extends StatelessWidget {
  final VoidCallback onSkip;

  const Header({
    @required this.onSkip,
  }) : assert(onSkip != null);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Logo(
          color: kWhite,
          size: 32.0,
        ),
        GestureDetector(
          onTap: onSkip,
          child: Text(
            'Skip',
            style:
                Theme.of(context).textTheme.subtitle.copyWith(color: kWhite),
          ),
        ),
      ],
    );
  }
}

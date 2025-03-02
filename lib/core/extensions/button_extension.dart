// Flutter imports:
import 'package:flutter/material.dart';

extension ButtonExpandedWidth on ButtonStyleButton {
  SizedBox expandedWidth() {
    return SizedBox(
      width: double.infinity,
      child: this,
    );
  }
}

// Flutter imports:
import 'package:flutter/material.dart';

extension FilledButtonExpandedWidth on FilledButton {
  SizedBox expandedWidth() {
    return SizedBox(
      width: double.infinity,
      child: this,
    );
  }
}

extension OutlinedButtonExpandedWidth on OutlinedButton {
  SizedBox expandedWidth() {
    return SizedBox(
      width: double.infinity,
      child: this,
    );
  }
}

extension TextButtonExpandedWidth on TextButton {
  SizedBox expandedWidth() {
    return SizedBox(
      width: double.infinity,
      child: this,
    );
  }
}

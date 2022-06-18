import 'package:flutter/material.dart';

// class AppScale {
//   BuildContext ctx;

//   AppScale(this.ctx);

//   double fs(double initialFontSize) {
//     return (MediaQuery.of(ctx).size.width * 0.0027) * initialFontSize;
//   }

//   double sh(double initialIcon) {
//     return (MediaQuery.of(ctx).size.height * 0.065) * initialIcon;
//   }
// }

extension Scaler on BuildContext {
  double scaleFont(double initialFontSize) {
    return (MediaQuery.of(this).size.width * 0.0027) * initialFontSize;
  }

  double scaleHeight(double initialHeight) {
    return (MediaQuery.of(this).size.height * 0.0011) * initialHeight;
  }

  double deviceWidth() {
    return (MediaQuery.of(this).size.width);
  }

  double deviceHeight() {
    return (MediaQuery.of(this).size.height);
  }
}

double keyboardHeight(BuildContext context) {
  return MediaQuery.of(context).viewInsets.bottom;
}


import 'package:mahua_pet/styles/app_size.dart';

extension DoubleFit on double {
  double get rpx {
    return SizeFit.setRpx(this);
  }

  double get px {
    return SizeFit.setPx(this);
  }
}


extension IntFit on int {
  double get rpx {
    return SizeFit.setRpx(this.toDouble());
  }

  double get px {
    return SizeFit.setPx(this.toDouble());
  }
}
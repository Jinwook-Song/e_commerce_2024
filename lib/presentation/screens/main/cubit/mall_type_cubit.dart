import 'package:e_commerce/core/theme/custom/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum MallType {
  market('마켓패캠'),
  beauty('뷰티패캠');

  const MallType(this.label);
  final String label;

  bool get isMaket => this == MallType.market;
  bool get isBeuaty => this == MallType.beauty;

  CustomAppBarTheme get theme {
    switch (this) {
      case MallType.market:
        return CustomAppBarTheme.market;
      case MallType.beauty:
        return CustomAppBarTheme.beauty;
    }
  }
}

class MallTypeCubit extends Cubit<MallType> {
  MallTypeCubit() : super(MallType.market);

  void changeIndex(int index) => emit(MallType.values[index]);
}

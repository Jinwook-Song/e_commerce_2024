import 'package:e_commerce/core/theme/constant/app_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum BottonNav {
  home('Home', AppIcons.navHome, AppIcons.navHomeOn),
  category('Category', AppIcons.navCategory, AppIcons.navCategoryOn),
  search('Search', AppIcons.navSearch, AppIcons.navSearchOn),
  user('User', AppIcons.navUser, AppIcons.navUserOn);

  const BottonNav(this.tabLabel, this.icon, this.activeIcon);

  final String tabLabel;
  final String icon;
  final String activeIcon;
}

class BottomNavCubit extends Cubit<BottonNav> {
  BottomNavCubit() : super(BottonNav.home);

  void changeIndex(int index) => emit(BottonNav.values[index]);
}

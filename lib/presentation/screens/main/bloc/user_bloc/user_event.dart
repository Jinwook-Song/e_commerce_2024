part of 'user_bloc.dart';

abstract class UserEvent {
  const UserEvent();
}

class UserLogin extends UserEvent {
  const UserLogin();
}

class UserLogout extends UserEvent {
  const UserLogout();
}

class UserLoginWithToken extends UserEvent {
  const UserLoginWithToken();
}

abstract class AuthenticationState{}

class AuthenticationInitialState extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState{}

class AuthenticationSuccessState extends AuthenticationState{}

class AuthenticationFailureState extends AuthenticationState{}
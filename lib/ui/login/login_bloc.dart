import 'package:bloc/bloc.dart';
import 'package:solar_kita/network/model/response/login_response.dart';
import 'package:solar_kita/network/repository/login_repository.dart';
import 'package:solar_kita/ui/login/login_event.dart';
import 'package:solar_kita/ui/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepository repository;

  LoginBloc(this.repository) : super(null);

  @override
  LoginState get initialState => InitialState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is ProcessLogin) {
      try {
        yield LoadingState();
        LoginResponse items = await repository.processLogin(event.username, event.password);
        print("login sukses");
        yield LoginSuccess(items: items);
      } catch (e) {
        print("login error");
        yield LoginError(message: e.toString());
      }
    }
  }
}
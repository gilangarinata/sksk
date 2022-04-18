import 'package:bloc/bloc.dart';
import 'package:solar_kita/network/model/response/help_center_list_response.dart';
import 'package:solar_kita/network/model/response/maintenance_list_response.dart';
import 'package:solar_kita/network/model/response/notification_response.dart';
import 'package:solar_kita/network/model/response/profile_response.dart';
import 'package:solar_kita/network/repository/profile_repository.dart';
import 'package:solar_kita/ui/profile/profile_event.dart';
import 'package:solar_kita/ui/profile/profile_state.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepository repository;

  ProfileBloc(this.repository) : super(null);

  @override
  ProfileState get initialState => InitialState();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is FetchProfile) {
      yield LoadingState();
      try {
        ProfileResponse items = await repository.getProfile();
        yield ProfileLoaded(items: items);
      } catch (e) {
        yield ServiceError(message: e.toString());
      }
    } else if(event is SaveProfile){
      yield LoadingState();
      try {
        bool items = await repository.saveProfile(event.name, event.company);
        if(items){
          yield SaveSuccess();
        }else{
          yield ServiceError(message: "Gagal Menyimpan");
        }
      } catch (e) {
        yield ServiceError(message: e.toString());
      }
    } else if(event is ChangePassword){
      yield LoadingState();
      try {
        bool items = await repository.changePassword(event.oldPassword, event.newPassword, event.newPassword2);
        if(items){
          yield ChangePasswordSuccess();
        }else{
          yield ServiceError(message: "Gagal Menyimpan");
        }
      } catch (e) {
        yield ServiceError(message: e.toString());
      }
    }
  }
}
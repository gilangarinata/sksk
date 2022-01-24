import 'package:bloc/bloc.dart';
import 'package:solar_kita/network/model/response/system_profile_response.dart';
import 'package:solar_kita/network/repository/system_profile_repository.dart';

import 'package:solar_kita/ui/monitoring/systemprofile/systemprofile_event.dart';
import 'package:solar_kita/ui/monitoring/systemprofile/systemprofile_state.dart';

class SystemProfileBloc extends Bloc<SystemProfileEvent, SystemProfileState> {
  SystemProfileRepository repository;

  SystemProfileBloc(this.repository) : super(null);

  @override
  SystemProfileState get initialState => null;

  @override
  Stream<SystemProfileState> mapEventToState(SystemProfileEvent event) async* {
    if (event is FetchSystemProfile) {
      try {
        SystemProfileResponse items = await repository.getSystemProfile();
        yield SystemProfileLoaded(items: items);
      } catch (e) {
        yield SystemProfileError(message: e.toString());
      }
    }else if(event is FetchSystemProfileDetail){
      try {
        SystemProfileResponse items = await repository.getSystemProfileDetail(event.id);
        yield SystemProfileDetailLoaded(items: items);
      } catch (e) {
        yield SystemProfileError(message: e.toString());
      }
    }
  }
}
import 'package:bloc/bloc.dart';
import 'package:solar_kita/network/model/response/system_profile_response.dart';
import 'package:solar_kita/network/repository/system_profile_repository.dart';

import 'package:solar_kita/ui/monitoring/systemprofile/systemprofile_event.dart';
import 'package:solar_kita/ui/monitoring/systemprofile/systemprofile_state.dart';

class SystemProfileBloc extends Bloc<SystemProfileEvent, SystemProfileState?> {
  SystemProfileRepository repository;

  SystemProfileBloc(this.repository) : super(null);


  @override
  Stream<SystemProfileState> mapEventToState(SystemProfileEvent event) async* {
    if (event is FetchSystemProfile) {
      try {
        SystemProfileResponse? items = await repository.getSystemProfile();
        if(items == null) return;

        yield SystemProfileLoaded(items: items);
      } catch (e) {
        yield SystemProfileError(message: e.toString());
      }
    }else if(event is FetchSystemProfileDetail){
      try {
        SystemProfileResponse? items = await repository.getSystemProfileDetail(event.id,event.month, event.year);
        if(items == null) return;
        yield SystemProfileDetailLoaded(items: items);
      } catch (e) {
        yield SystemProfileError(message: e.toString());
      }
    }
  }
}
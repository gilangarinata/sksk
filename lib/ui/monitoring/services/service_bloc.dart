import 'package:bloc/bloc.dart';
import 'package:solar_kita/network/model/response/help_center_list_response.dart';
import 'package:solar_kita/network/model/response/maintenance_list_response.dart';
import 'package:solar_kita/network/model/response/notification_response.dart';
import 'package:solar_kita/network/repository/service_repository.dart';
import 'package:solar_kita/ui/monitoring/services/service_event.dart';
import 'package:solar_kita/ui/monitoring/services/service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  ServiceRepository repository;

  ServiceBloc(this.repository) : super(null);

  @override
  ServiceState get initialState => InitialState();

  @override
  Stream<ServiceState> mapEventToState(ServiceEvent event) async* {
    if (event is FetchService) {
      yield LoadingState();
      try {
        bool items = await repository.postService(event.type, event.message, event.helpTypeId, event.date, event.time);
        yield ServiceLoaded(items: items);
      } catch (e) {
        yield ServiceError(message: e.toString());
      }
    }else if(event is FetchHelpCenterList){
      try {
        HelpCenterListResponse items = await repository.getHelpCenterList();
        yield HelpCenterListLoaded(items: items);
      } catch (e) {
        yield ServiceError(message: e.toString());
      }
    }else if(event is FetchMaintenanceList){
      try {
        MaintenanceListResponse items = await repository.getMaintenanceList();
        yield MaintenanceListLoaded(items: items);
      } catch (e) {
        yield ServiceError(message: e.toString());
      }
    }else if(event is FetchNotificationList){
      try {
        NotificationResponse items = await repository.getNotificationList();
        yield NotificationListLoaded(items: items);
      } catch (e) {
        yield ServiceError(message: e.toString());
      }
    }
  }
}
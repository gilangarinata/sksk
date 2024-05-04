import 'package:bloc/bloc.dart';
import 'package:solar_kita/network/model/response/graph_day_response.dart';
import 'package:solar_kita/network/model/response/graph_month_response.dart';
import 'package:solar_kita/network/model/response/graph_total_response.dart';
import 'package:solar_kita/network/model/response/graph_year_response.dart';
import 'package:solar_kita/network/repository/graph_repository.dart';
import 'package:solar_kita/ui/chart/chart_event.dart';
import 'package:solar_kita/ui/chart/chart_state.dart';

class ChartBloc extends Bloc<ChartEvent, ChartState?> {
  GraphRepository repository;

  ChartBloc(this.repository) : super(null);

  @override
  ChartState get initialState => InitialState();

  @override
  Stream<ChartState> mapEventToState(ChartEvent event) async* {
    if (event is FetchDailyGraph) {
      try {
        yield LoadingState();
        List<GraphDayResponse> items = await repository.fetchGraphDaily(event.date,event.inverterId) ?? [];
        yield ChartDailyLoaded(items: items);
      } catch (e) {
        yield ErrorState(message: e.toString());
      }
    }else if(event is FetchMonthlyGraph){
      try {
        yield LoadingState();
        List<GraphMonthResponse> items = await repository.fetchGraphMonthly(event.month,event.inverterId) ?? [];
        yield ChartMonthlyLoaded(items: items);
      } catch (e) {
        yield ErrorState(message: e.toString());
      }
    }else if(event is FetchYearlyGraph){
      try {
        yield LoadingState();
        List<GraphYearResponse> items = await repository.fetchGraphYearly(event.year,event.inverterId) ?? [];
        yield ChartYearlyLoaded(items: items);
      } catch (e) {
        yield ErrorState(message: e.toString());
      }
    }else if(event is FetchTotalGraph){
      try {
        yield LoadingState();
        List<GraphTotalResponse> items = await repository.fetchGraphTotal(event.inverterId) ?? [];
        yield ChartTotalLoaded(items: items);
      } catch (e) {
        yield ErrorState(message: e.toString());
      }
    }
  }
}

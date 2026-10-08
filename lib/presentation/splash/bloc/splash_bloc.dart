import 'package:bloc/bloc.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState()) {
    on<SplashStarted>(_onStarted);
    on<SplashCompleted>(_onCompleted);
  }

  void _onStarted(SplashStarted event, Emitter<SplashState> emit) {
    emit(state.copyWith(status: SplashStatus.animating));
  }

  void _onCompleted(SplashCompleted event, Emitter<SplashState> emit) {
    emit(state.copyWith(status: SplashStatus.readyToNavigate));
  }
}

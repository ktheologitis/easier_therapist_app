import 'package:bloc/bloc.dart';

import '../../data/models/completedhomework.dart';

class ShowCompletedHomeworkAnswersState {
  final bool showAnswersScreen;
  final CompletedHomework? completedHomework;
  ShowCompletedHomeworkAnswersState({
    required this.showAnswersScreen,
    this.completedHomework,
  });
}

class ShowCompletedHomeworkAnswersCubit
    extends Cubit<ShowCompletedHomeworkAnswersState> {
  ShowCompletedHomeworkAnswersCubit()
      : super(ShowCompletedHomeworkAnswersState(showAnswersScreen: false));

  void showAnswersScreen({required CompletedHomework completedHomework}) =>
      emit(ShowCompletedHomeworkAnswersState(
          showAnswersScreen: true, completedHomework: completedHomework));

  void hideAnswersScreen() => emit(ShowCompletedHomeworkAnswersState(
      showAnswersScreen: false, completedHomework: null));
}

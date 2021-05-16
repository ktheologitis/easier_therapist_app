import 'package:bloc/bloc.dart';

enum UpdateClientCubitState {
  dataChanged,
  dataNotchanged,
  savingChanges,
  errorSavingChanges,
  changesSaved,
}

enum UpdateCardType {
  basicInformation,
  emergencyContact,
}

class UpdateClientCubit extends Cubit<UpdateClientCubitState> {
  UpdateClientCubit() : super(UpdateClientCubitState.dataNotchanged);

  UpdateCardType updateCard = UpdateCardType.basicInformation;

  void dataChanged() => emit(UpdateClientCubitState.dataChanged);
  void noDataChange() => emit(UpdateClientCubitState.dataNotchanged);
  void savingChangedData() => emit(UpdateClientCubitState.savingChanges);
  void errorSaving() => emit(UpdateClientCubitState.errorSavingChanges);
  void changedDataSaved() => emit(UpdateClientCubitState.changesSaved);
  void reset() => emit(UpdateClientCubitState.dataNotchanged);

  void changeUpdateCard(UpdateCardType newUpdateCard) {
    updateCard = newUpdateCard;
  }
}

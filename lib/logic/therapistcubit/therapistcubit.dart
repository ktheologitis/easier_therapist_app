import 'package:bloc/bloc.dart';

import '../../data/models/therapist.dart';

class TherapistCubit extends Cubit<Therapist> {
  TherapistCubit()
      : super(Therapist(
          id: "pSn6YIRx3yOWKqnvJpgv",
          firstName: "Dionysis",
          lastName: "Pyrovolisianos",
          email: "dion@gmail.com",
          address: "Melponikis 22, Kypseli",
        ));
}

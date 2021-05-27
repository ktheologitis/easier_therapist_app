import 'package:cloud_firestore/cloud_firestore.dart';

import '../dataproviders/completedHomeworkPoolDataProvider.dart';
import '../models/completedhomework.dart';
import '../models/completedhomeworkpool.dart';

class CompletedHomeworkPoolRepository {
  final FirebaseFirestore firestoreInstance;
  final String therapistId;

  late CompletedHomeworkPoolDataProvider completedHomeworkPoolDataProvider;

  CompletedHomeworkPoolRepository({
    required this.firestoreInstance,
    required this.therapistId,
  }) {
    completedHomeworkPoolDataProvider = CompletedHomeworkPoolDataProvider(
      firestoreInstance: firestoreInstance,
      therapistId: therapistId,
    );
  }

  Future<CompletedHomeworkPool> getCompletedHomeworkPool(
      {required String clientId}) async {
    QuerySnapshot rawCompletedHomeworkPool =
        await completedHomeworkPoolDataProvider.getRawCompletedHomeworkPool(
            clientId: clientId);

    print("length: ${rawCompletedHomeworkPool.docs.length}");

    CompletedHomeworkPool completedHomeworkPool = new CompletedHomeworkPool();

    rawCompletedHomeworkPool.docs.forEach((rawCompletedomework) {
      String completedHomeworkTitle = rawCompletedomework.data()["title"];
      int sessionNumberOfCompletion =
          rawCompletedomework.data()["sessionNumberOfCompletion"];

      final CompletedHomework newCompletedHomework = CompletedHomework(
        id: rawCompletedomework.id,
        referencedAssignedHomeworkId:
            rawCompletedomework.data()["referencedAssignedHomeworkId"],
        title: rawCompletedomework.data()["title"],
        sessionNumberOfCompletion: sessionNumberOfCompletion,
        fields: rawCompletedomework.data()["fields"],
        answers: rawCompletedomework.data()["answers"],
        dateTimeAnswered:
            rawCompletedomework.data()["dateTimeAnswered"].toDate(),
      );

      completedHomeworkPool.data.update(
        completedHomeworkTitle,
        (value) => {
          ...value,
          sessionNumberOfCompletion: value.update(
            sessionNumberOfCompletion,
            (value) => {
              ...value,
              rawCompletedomework.id: newCompletedHomework,
            },
            ifAbsent: () => {rawCompletedomework.id: newCompletedHomework},
          )
        },
        ifAbsent: () => {
          sessionNumberOfCompletion: {
            rawCompletedomework.id: newCompletedHomework
          }
        },
      );
    });

    print("repository: ${completedHomeworkPool.data}");

    return completedHomeworkPool;
  }
}

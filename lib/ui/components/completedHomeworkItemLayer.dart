import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../data/models/completedhomework.dart';
import '../../logic/showCompletedHomeworkAnswersCubit/showCompletedHomeworkAnswersCubit.dart';

class CompletedHomeworkItemLayer extends StatelessWidget {
  final CompletedHomework completedHomework;

  CompletedHomeworkItemLayer({required this.completedHomework});

  @override
  Widget build(BuildContext context) {
    final ShowCompletedHomeworkAnswersCubit showCompletedHomeworkAnswersCubit =
        BlocProvider.of<ShowCompletedHomeworkAnswersCubit>(context);
    final String formattedDate =
        DateFormat.yMMMMd().format(completedHomework.dateTimeAnswered);
    final String formattedTime =
        DateFormat.Hm().format(completedHomework.dateTimeAnswered);
    return InkWell(
      onTap: () {
        print("review completed Homework");
        showCompletedHomeworkAnswersCubit.showAnswersScreen(
            completedHomework: completedHomework);
      },
      child: ListTile(
        leading: SizedBox(
          height: 40,
          width: 40,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.rate_review_outlined,
              color: Colors.white,
            ),
          ),
        ),
        title: Text("$formattedDate - $formattedTime"),
      ),
    );
  }
}

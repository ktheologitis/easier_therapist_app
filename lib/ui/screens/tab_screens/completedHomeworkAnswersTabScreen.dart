import 'package:easier_therapist_app/data/models/completedhomework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../logic/showCompletedHomeworkAnswersCubit/showCompletedHomeworkAnswersCubit.dart';
import '../../../data/models/completedhomework.dart';
import '../../components/singleAnswerPreviewBox.dart';

class CompletedHomeworkAnswersTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ShowCompletedHomeworkAnswersCubit showCompletedHomeworkAnswersCubit =
        BlocProvider.of<ShowCompletedHomeworkAnswersCubit>(context);

    final CompletedHomework completedHomework =
        showCompletedHomeworkAnswersCubit.state.completedHomework!;
    final String formattedDate =
        DateFormat.yMMMMd().format(completedHomework.dateTimeAnswered);
    final String formattedTime =
        DateFormat.Hm().format(completedHomework.dateTimeAnswered);

    final ScrollController _scrollController = ScrollController();

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 8.0, bottom: 0),
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 48,
                            width: 48,
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
                          SizedBox(
                            width: 24.0,
                          ),
                          Text(
                            "$formattedDate - $formattedTime",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.close_fullscreen),
                            onPressed: () => showCompletedHomeworkAnswersCubit
                                .hideAnswersScreen(),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    indent: 60.0,
                    thickness: 1,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 0, bottom: 16.0),
                      child: Container(
                        // color: Colors.red,
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          removeBottom: true,
                          child: Scrollbar(
                            thickness: 5,
                            controller: _scrollController,
                            child: ListView.separated(
                              controller: _scrollController,
                              itemCount: completedHomework.fields.length,
                              separatorBuilder: (_, index) => SizedBox(
                                height: 16,
                              ),
                              itemBuilder: (_, index) {
                                final currentField =
                                    completedHomework.fields.toList()[index];
                                return SingleAnswerPreviewBox(
                                  completedHomeworkField: currentField,
                                  completedHomeworkAnswer:
                                      completedHomework.answers[currentField],
                                  completeDHomework: completedHomework,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

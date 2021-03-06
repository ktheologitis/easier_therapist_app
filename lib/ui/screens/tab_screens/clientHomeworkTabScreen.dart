import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../styles/colorsIcons.dart';
import 'assignedHomeworkTab.dart';
import 'completedHomeworkTabScreen.dart';
import '../../../logic/showCompletedHomeworkAnswersCubit/showCompletedHomeworkAnswersCubit.dart';
import '../tab_screens/completedHomeworkAnswersTabScreen.dart';

class ClientHomeworkTabScreen extends StatefulWidget {
  ClientHomeworkTabScreen({required this.clientId});
  final String clientId;
  @override
  _ClientHomeworkTabScreenState createState() =>
      _ClientHomeworkTabScreenState();
}

class _ClientHomeworkTabScreenState extends State<ClientHomeworkTabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          child: Material(
            color: MyColors.primary,
            child: TabBar(
              controller: _tabController,
              labelColor: MyColors.lightTextIcon,
              labelStyle: TextStyle(fontSize: 16, wordSpacing: 1.5),
              indicatorColor: MyColors.lightTextIcon,
              indicatorWeight: 3.0,
              unselectedLabelColor: Colors.grey[500],
              tabs: [
                Tab(
                  child: Text("ASSIGNED"),
                ),
                Tab(
                  child: Text("COMPLETED"),
                )
              ],
            ),
          ),
        ),
        Container(
          height: height - 56 - 49,
          width: width - width * 0.2,
          // color: Colors.red,
          child: TabBarView(
            controller: _tabController,
            children: [
              Center(
                child: AssignedHomeworkTabScreen(
                  clientId: widget.clientId,
                ),
              ),
              BlocBuilder<ShowCompletedHomeworkAnswersCubit,
                  ShowCompletedHomeworkAnswersState>(
                builder: (_, state) {
                  return Center(
                    child: Stack(
                      children: [
                        CompletedHomeworkTabScreen(
                          clientId: widget.clientId,
                        ),
                        if (state.showAnswersScreen == true)
                          CompletedHomeworkAnswersTabScreen(),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}

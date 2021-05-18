import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/client.dart';
import '../../components/assigned_homework_list_item.dart';
import '../../../logic/homeworkpoolbloc/homeworkpoolbarrel.dart';
import '../../components/floating_button.dart';
import '../../styles/colors_icons.dart';
import '../../dialogs/assignHomeworkDialog.dart';
import '../../../data/models/homeworkpool.dart';
import '../../../logic/assignedhomeworkpoolbloc/assignedhomeworkpoolbarrel.dart';
import '../../../data/models/assignedhomeworkpool.dart';
import '../../dialogs/editNoteDialog.dart';

class AssignedHomeworkTabScreen extends StatefulWidget {
  AssignedHomeworkTabScreen({required this.clientId});
  final String clientId;

  @override
  _AssignedHomeworkTabScreenState createState() =>
      _AssignedHomeworkTabScreenState();
}

class _AssignedHomeworkTabScreenState extends State<AssignedHomeworkTabScreen> {
  late Future<HomeworkPool> currentHomeworkPool;

  @override
  void initState() {
    super.initState();
    currentHomeworkPool = BlocProvider.of<HomeworkPoolBloc>(context)
        .homeworkPoolRepository
        .getHomeworkPool();
  }

  @override
  Widget build(BuildContext context) {
    final HomeworkPoolBloc homeworkPoolBloc =
        BlocProvider.of<HomeworkPoolBloc>(context);

    final AssignedHomeworkPoolBloc assignedHomeworkPoolBloc =
        BlocProvider.of<AssignedHomeworkPoolBloc>(context);

    return BlocConsumer<AssignedHomeworkPoolBloc, AssignedHomeworkPoolState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (homeworkPoolBloc.state is HomeworkPoolDataSyncedWithDatabase) {
            if (state is AssignedHomeworkPoolInit) {
              assignedHomeworkPoolBloc.add(AssignedHomeworkPoolBeingFetched(
                  clientId: widget.clientId,
                  homeworkPool: homeworkPoolBloc.state.homeworkPool));
              return CircularProgressIndicator();
            } else {
              if (state.assignedHomeworkPool.data.isEmpty) {
                return NoAssignedHomeworkDisplay(
                  clientId: widget.clientId,
                  homeworkPool: homeworkPoolBloc.state.homeworkPool,
                );
              } else {
                return AssignedHomeworkDisplay(
                    clientId: widget.clientId,
                    homeworkPool: homeworkPoolBloc.state.homeworkPool);
              }
            }
          } else {
            return FutureBuilder(
              future: currentHomeworkPool,
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  if (state is AssignedHomeworkPoolInit) {
                    assignedHomeworkPoolBloc.add(
                        AssignedHomeworkPoolBeingFetched(
                            clientId: widget.clientId,
                            homeworkPool: snapshot.data as HomeworkPool));
                    return CircularProgressIndicator();
                  } else {
                    if (state.assignedHomeworkPool.data.isEmpty) {
                      return NoAssignedHomeworkDisplay(
                        clientId: widget.clientId,
                        homeworkPool: snapshot.data as HomeworkPool,
                      );
                    } else {
                      return AssignedHomeworkDisplay(
                          clientId: widget.clientId,
                          homeworkPool: snapshot.data as HomeworkPool);
                    }
                  }
                } else {
                  return CircularProgressIndicator();
                }
              },
            );
          }
        });
  }
}

class AssignedHomeworkDisplay extends StatelessWidget {
  const AssignedHomeworkDisplay({
    Key? key,
    required this.clientId,
    required this.homeworkPool,
  }) : super(key: key);
  final String clientId;
  final HomeworkPool homeworkPool;

  @override
  Widget build(BuildContext context) {
    final AssignedHomeworkPool assignedHomeworkPool =
        BlocProvider.of<AssignedHomeworkPoolBloc>(context)
            .state
            .assignedHomeworkPool;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            children: [
              Spacer(),
              TextButton.icon(
                icon: Icon(Icons.add),
                label: Text("ASSIGN NEW HOMEWORK"),
                onPressed: () {
                  showAssignHomeworkDialog(
                    context: context,
                    homeworkPool: homeworkPool,
                  );
                },
              ),
            ],
          ),
          SizedBox(
            height: 24.0,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: assignedHomeworkPool.data.length,
              separatorBuilder: (context, index) => SizedBox(height: 16.0),
              itemBuilder: (context, index) => AssignedHomeworkListItem(
                  assignedHomework: assignedHomeworkPool.data.values
                      .toList()
                      .reversed
                      .toList()[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class NoAssignedHomeworkDisplay extends StatelessWidget {
  const NoAssignedHomeworkDisplay({
    Key? key,
    required this.clientId,
    required this.homeworkPool,
  }) : super(key: key);
  final String clientId;
  final HomeworkPool homeworkPool;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: height - 56 - 48,
      width: width - width * 0.2,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "You have not assigned any homework to this client yet...",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 48,
            width: 240,
            child: FloatingButton(
              color: MyColors.primary,
              icon: Icon(Icons.add),
              title: "ASSIGN HOMEWORK",
              action: () {
                showAssignHomeworkDialog(
                  context: context,
                  homeworkPool: homeworkPool,
                );
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(),
          ),
        ],
      ),
    );
  }
}

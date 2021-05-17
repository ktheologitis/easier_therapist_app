import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/client.dart';
import '../../../data/models/clients.dart';
import '../../../data/models/homework.dart';
import '../../components/assigned_homework_list_item.dart';
import '../../../logic/clientsbloc/clientsbarrel.dart';
import '../../components/floating_button.dart';
import '../../styles/colors_icons.dart';
import '../../../logic/clientsbloc/clientsbarrel.dart';
import '../../../logic/homeworkpoolbloc/homeworkpoolbloc.dart';

class AssignedHomeworkTabScreen extends StatefulWidget {
  AssignedHomeworkTabScreen({required this.clientId});
  final String clientId;

  @override
  _AssignedHomeworkTabScreenState createState() =>
      _AssignedHomeworkTabScreenState();
}

class _AssignedHomeworkTabScreenState extends State<AssignedHomeworkTabScreen> {
  // this is used because when the widhet is build, clientsBloc state has not yes changed to
  // ClientsDataLoading
  bool _assignedHomeworkIsFetched = false;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ClientsBloc>(context)
        .add(ClientAssignedHomeworkScreenInit());
  }

  @override
  Widget build(BuildContext context) {
    final ClientsBloc clientsBloc = BlocProvider.of<ClientsBloc>(context);
    final HomeworkPoolBloc homeworkPoolBloc =
        BlocProvider.of<HomeworkPoolBloc>(context);

    return BlocBuilder<ClientsBloc, ClientsState>(
      builder: (context, state) {
        print(clientsBloc.state);
        final Clients clients =
            BlocProvider.of<ClientsBloc>(context).state.clients;
        final Client client = clients.data[widget.clientId]!;

        if (state is ClientsDataSyncedWithDatabase &&
            _assignedHomeworkIsFetched) {
          return client.assignedHomeworkPool.data.isNotEmpty
              ? Padding(
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
                              print("Assign new homework");
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemCount: client.assignedHomeworkPool.data.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 16.0),
                          itemBuilder: (context, index) =>
                              AssignedHomeworkListItem(
                                  homework: client
                                      .assignedHomeworkPool.data.values
                                      .toList()[index]),
                        ),
                      ),
                    ],
                  ),
                )
              : NoAssignedHomework();
        } else if (state is ClientsDataLoading) {
          clientsBloc.add(ClientAssignedHomeworkPoolBeingFetched(
              clientId: widget.clientId,
              homeworkPool: homeworkPoolBloc.state.homeworkPool));
          _assignedHomeworkIsFetched = true;
          return CircularProgressIndicator();
        } else {
          return Container(
            height: 0,
            width: 0,
          );
        }
      },
    );
  }
}

class NoAssignedHomework extends StatelessWidget {
  const NoAssignedHomework({
    Key? key,
  }) : super(key: key);

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
              action: () => {},
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

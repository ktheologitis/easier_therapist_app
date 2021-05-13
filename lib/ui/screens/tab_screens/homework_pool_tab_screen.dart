import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/homework.dart';
import '../../components/homework_pool_list_item.dart';
import '../../dialogs/create_new_homework_dialog.dart';
import '../../../logic/homeworkpoolbloc/homeworkpoolbarrel.dart';

class HomeworkPoolTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    HomeworkPoolBloc homeworkPoolBloc =
        BlocProvider.of<HomeworkPoolBloc>(context);

    return Padding(
      padding: EdgeInsets.only(
        top: 24.0,
        bottom: 24.0,
        left: width * 0.2,
        right: width * 0.2,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Spacer(),
              TextButton.icon(
                icon: Icon(Icons.add),
                label: Text("CREATE NEW HOMEWORK"),
                onPressed: () {
                  showCreateUpdateHomeworkDialog(
                      context: context, mode: Mode.create);
                },
              ),
            ],
          ),
          SizedBox(
            height: 24.0,
          ),
          BlocBuilder<HomeworkPoolBloc, HomeworkPoolState>(
            builder: (_, state) {
              if (state is HomeworkPoolLoading) {
                homeworkPoolBloc.add(HomeworkPoolBeingFetched());
                return Expanded(
                  child: Center(
                    child: Text("Loading"),
                  ),
                );
              } else if (state is HomeworkPoolDisplay) {
                var homeworkPoolList =
                    state.homeworkPool.data.values.toList().reversed.toList();
                return Expanded(
                  child: ListView.separated(
                    itemCount: state.homeworkPool.data.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 16.0),
                    itemBuilder: (context, index) =>
                        HomeworkPoolListItem(homework: homeworkPoolList[index]),
                  ),
                );
              } else {
                // state is HomeworkPoolDisplayError
                return Expanded(
                  child: Column(
                    children: [
                      Text((state as HomeworkPoolDisplayError).errorMessage),
                      SizedBox(
                        height: 24.0,
                      ),
                      ElevatedButton(
                          child: Text("RETRY FETCHING HOMEWORK POOL DATA"),
                          onPressed: () {
                            homeworkPoolBloc.add(HomeworkPoolBeingFetched());
                          }),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

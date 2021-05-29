import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/completedHomeworkPoolBloc/completedHomeworkBarrel.dart';
import '../../components/completedHomeworkTypeLayer.dart';

class CompletedHomeworkTabScreen extends StatelessWidget {
  final String clientId;

  CompletedHomeworkTabScreen({
    required this.clientId,
  });
  @override
  Widget build(BuildContext context) {
    final CompletedHomeworkPoolBloc completedHomeworkPoolBloc =
        BlocProvider.of<CompletedHomeworkPoolBloc>(context);
    print("clientId: $clientId");

    return BlocBuilder<CompletedHomeworkPoolBloc, CompletedHomeworkPoolState>(
      builder: (_, state) {
        if (state is CompletedHomeworkPoolInit) {
          completedHomeworkPoolBloc.add(CompletedHomeworkPoolBeingFetched(
            clientId: clientId,
          ));
          return CircularProgressIndicator(
            color: Theme.of(context).accentColor,
          );
        } else {
          print(state.completedHomeworkPool.data);
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: ListView.separated(
              itemCount: state.completedHomeworkPool.data.length,
              separatorBuilder: (context, index) => SizedBox(height: 8.0),
              itemBuilder: (context, index) {
                return CompletedHomeworkTypeLayer(
                    completedHomeworkTitle:
                        state.completedHomeworkPool.data.keys.toList()[index],
                    completedHomeworkTypes: state
                        .completedHomeworkPool.data.values
                        .toList()[index]);
              },
            ),
          );
        }
      },
    );
  }
}

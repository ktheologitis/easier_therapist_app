import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './ui/styles/theme.dart';
import 'ui/screens/main_screens/homeScreen.dart';
import 'ui/screens/main_screens/clientProfileScreen.dart';
import './logic/clientsbloc/clientsbloc.dart';
import './logic/homeworkpoolbloc/homeworkpoolbloc.dart';
import './logic/filteredclientscubit/filteredclientscubit.dart';
import './logic/snackbarcubit/snackbarcubit.dart';
import './logic/updateclientcubit/updateclientcubit.dart';
import './logic/firestoreinstancecubit/firestoreinstancecubit.dart';
import './logic/therapistcubit/therapistcubit.dart';
import './logic/completedHomeworkPoolBloc/completedHomeworkPoolBloc.dart';
import './logic/showCompletedHomeworkAnswersCubit/showCompletedHomeworkAnswersCubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return Center(
            child: Text(
              "Error",
              textDirection: TextDirection.ltr,
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<TherapistCubit>(
                create: (_) => TherapistCubit(),
              ),
              BlocProvider<FirestoreInstanceCubit>(
                  create: (_) => FirestoreInstanceCubit()),
              BlocProvider<SnackbarCubit>(create: (_) => SnackbarCubit()),
              BlocProvider<UpdateClientCubit>(
                create: (_) => UpdateClientCubit(),
              ),
              BlocProvider<ClientsBloc>(
                create: (context) => ClientsBloc(
                  firestoreInstance:
                      BlocProvider.of<FirestoreInstanceCubit>(context).state,
                  therapistId:
                      BlocProvider.of<TherapistCubit>(context).state.id,
                  snackbarCubit: BlocProvider.of<SnackbarCubit>(context),
                  updateClientCubit:
                      BlocProvider.of<UpdateClientCubit>(context),
                ),
              ),
              BlocProvider<HomeworkPoolBloc>(
                create: (context) => HomeworkPoolBloc(
                    firestoreInstance:
                        BlocProvider.of<FirestoreInstanceCubit>(context).state,
                    therapistId:
                        BlocProvider.of<TherapistCubit>(context).state.id,
                    snackbarCubit: BlocProvider.of<SnackbarCubit>(context)),
              ),
              BlocProvider<FilteredClientsCubit>(
                  create: (context) => FilteredClientsCubit(
                      clientsBloc: BlocProvider.of<ClientsBloc>(context))),
              BlocProvider<CompletedHomeworkPoolBloc>(
                create: (context) => CompletedHomeworkPoolBloc(
                    therapistId:
                        BlocProvider.of<TherapistCubit>(context).state.id,
                    firestoreInstance:
                        BlocProvider.of<FirestoreInstanceCubit>(context).state,
                    snackbarCubit: BlocProvider.of<SnackbarCubit>(context)),
              ),
              BlocProvider<ShowCompletedHomeworkAnswersCubit>(
                  create: (_) => ShowCompletedHomeworkAnswersCubit()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: getTheme(),
              home: HomeScreen(title: 'Easier'),
              routes: {
                ClientProfileScreen.routeName: (context) =>
                    ClientProfileScreen(),
              },
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}

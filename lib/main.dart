import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './ui/styles/theme.dart';
import './ui/screens/main_screens/home_screen.dart';
import './ui/screens/main_screens/client_profile_screen.dart';
import './logic/clientsbloc/clientsbloc.dart';
import './logic/homeworkpoolbloc/homeworkpoolbloc.dart';
import './logic/filteredclientscubit/filteredclientscubit.dart';
import './logic/snackbarcubit/snackbarcubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;
  final String therapistId = "pSn6YIRx3yOWKqnvJpgv";

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
              BlocProvider<SnackbarCubit>(create: (_) => SnackbarCubit()),
              BlocProvider<ClientsBloc>(
                create: (context) => ClientsBloc(
                    firestoreInstance: _firestoreInstance,
                    therapistId: therapistId,
                    snackbarCubit: BlocProvider.of<SnackbarCubit>(context)),
              ),
              BlocProvider<HomeworkPoolBloc>(
                create: (context) => HomeworkPoolBloc(
                    firestoreInstance: _firestoreInstance,
                    therapistId: therapistId,
                    snackbarCubit: BlocProvider.of<SnackbarCubit>(context)),
              ),
              BlocProvider<FilteredClientsCubit>(
                  create: (context) => FilteredClientsCubit(
                      clientsBloc: BlocProvider.of<ClientsBloc>(context)))
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
        return Center(
          child: Text("Loading", textDirection: TextDirection.ltr),
        );
      },
    );
  }
}

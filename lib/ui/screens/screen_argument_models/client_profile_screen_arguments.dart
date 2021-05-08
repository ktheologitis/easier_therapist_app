import '../../../data/models/client.dart';
import '../main_screens/client_profile_screen.dart';

class ClientProfileScreenArguments {
  final Client client;
  final String comingFrom = ClientProfileScreen.routeName;

  ClientProfileScreenArguments({required this.client});
}

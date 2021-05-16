import '../../../data/models/client.dart';
import '../main_screens/client_profile_screen.dart';

class ClientProfileScreenArguments {
  final String clientId;
  final String comingFrom = ClientProfileScreen.routeName;

  ClientProfileScreenArguments({required this.clientId});
}

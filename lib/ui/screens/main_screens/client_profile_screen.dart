import 'package:flutter/material.dart';

import '../../components/appBar.dart';
import '../tab_screens/client_homework_tab_screen.dart';
import '../screen_argument_models/client_profile_screen_arguments.dart';
import '../../components/client_profile_sidesheet.dart';
import '../tab_screens/client_basic_information_tab_screen.dart';

class ClientProfileScreen extends StatefulWidget {
  static const routeName = "ClientProfileScreen";

  @override
  _ClientProfileScreenState createState() => _ClientProfileScreenState();
}

class _ClientProfileScreenState extends State<ClientProfileScreen>
    with SingleTickerProviderStateMixin {
  var _selectedMenuItem = MenuSelection.BasicInformation;

  void _onSelectMenuItem(String selectedChoice) {
    setState(() {
      _selectedMenuItem = selectedChoice;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ClientProfileScreenArguments arg = ModalRoute.of(context)
        ?.settings
        .arguments as ClientProfileScreenArguments;

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    Future<void> showAddClientDialog(BuildContext context) async {
      print("yooo");
      return await showDialog(
          context: context, builder: (context) => Text("hey"));
    }

    return Scaffold(
      appBar: EasierAppBarAlternative(
        title: "Easier",
        showDialog: showAddClientDialog,
      ),
      body: SizedBox(
        height: height - 56,
        width: width,
        child: Row(
          children: [
            Container(
              width: width * 0.2,
              child: ClientProfileSideSheet(
                  client: arg.client,
                  selected: _selectedMenuItem,
                  onSelectMenuItem: _onSelectMenuItem),
            ),
            Container(
              width: width - width * 0.2,
              height: height - 56,
              child: _selectedMenuItem == MenuSelection.BasicInformation
                  ? Center(
                      child:
                          ClientBasicInformationTabScreen(client: arg.client),
                    )
                  : ClientHomeworkTabScreen(),
            )
          ],
        ),
      ),
    );
  }
}

class MenuSelection {
  static const BasicInformation = "Basic Information";
  static const ClientHomework = "Client Homework";
}

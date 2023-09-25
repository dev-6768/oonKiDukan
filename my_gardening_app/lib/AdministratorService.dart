import 'package:flutter/material.dart';
import 'package:my_gardening_app/widgets/list/item_data_class.dart';
import 'package:my_gardening_app/widgets/list/list_item.dart';
import 'package:my_gardening_app/widgets/widgets.dart';

class AdministratorService extends StatelessWidget {
  const AdministratorService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget().build(context),
      drawer: DrawerWidget(),
        body: Padding(padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
                child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: ItemsForCatalogue.administratorList.length,
                itemBuilder: (context, index) {
                  return MainAdministratorPanel(
                    item: ItemsForCatalogue.administratorList[index]
                  );
                },
              ),
            ),
          ],
        ),
      ), 
      ),
    );
  }
}
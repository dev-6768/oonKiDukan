import 'package:flutter/material.dart';
import 'package:my_gardening_app/widgets/list/item_data_class.dart';
import 'package:my_gardening_app/widgets/list/list_item.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
    child: Column(
      children: [
      SingleChildScrollView(
        child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: ItemsForCatalogue.categoriesList.length,
        itemBuilder: (context, index) {
          return CategoriesConatiner(item: ItemsForCatalogue.categoriesList[index]);
        }
      ),
    ),
      ],
    ),
    
    );
    
  }
}

// Container(
//       color: const Color(0xffC4DFCB),
//       child: Center(
//         child: Text(
//           "Page Number 2",
//           style: TextStyle(
//             color: Colors.green[900],
//             fontSize: 45,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/ItemState.dart';

class FilterAscDesc extends StatelessWidget {
  const FilterAscDesc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.sort_rounded),
      color: Colors.white,
      itemBuilder: (context) => [
        // ASC
        PopupMenuItem(
          onTap: () =>
              Provider.of<ItemState>(context, listen: false).orderAmountAsc(),
          child: const Text("Ascending"),
        ),
        // DESC
        PopupMenuItem(
          onTap: () =>
              Provider.of<ItemState>(context, listen: false).orderAmountDesc(),
          child: const Text("Descending"),
        ),
      ],
    );
  }
}

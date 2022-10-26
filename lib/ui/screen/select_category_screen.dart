import 'package:flutter/material.dart';
import 'package:places/data/model/place_type.dart';
import 'package:places/ui/models/place_type_synonym.dart';
import 'package:places/ui/screen/res/strings.dart';
import 'package:places/ui/widgets/app_bar.dart';

class SelectCategory extends StatelessWidget {
  final ValueChanged<PlaceType> onSelect;
  const SelectCategory({Key? key, required this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        height: 56,
        leading: const ReturnButton(),
        title: AppStrings.category,
        titleTextStyle: theme.textTheme.headlineSmall?.copyWith(
          color: theme.colorScheme.onBackground,
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: PlaceType.values
              .map((e) => Column(
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          alignment: Alignment.centerLeft,
                          minimumSize: const Size(double.infinity, 48),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          onSelect(e);
                        },
                        child: Text(
                          e.synonym(),
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onTertiary,
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 0.8,
                        height: 0,
                      ),
                    ],
                  ))
              .toList(),
        ),
      ),
    );
  }
}

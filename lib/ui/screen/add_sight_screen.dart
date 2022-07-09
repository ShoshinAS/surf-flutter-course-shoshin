import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/domain/location.dart';
import 'package:places/domain/sight.dart';
import 'package:places/domain/sight_type.dart';
import 'package:places/ui/models/filter_model.dart';
import 'package:places/ui/screen/res/strings.dart';
import 'package:places/ui/widgets/app_bar.dart';
import 'package:places/ui/widgets/big_button.dart';
import 'package:places/ui/widgets/clear_text_button.dart';
import 'package:provider/provider.dart';

// экран добавления интересного места в список
class AddSightScreen extends StatefulWidget {
  const AddSightScreen({Key? key}) : super(key: key);

  @override
  State<AddSightScreen> createState() => _AddSightScreenState();
}

class _AddSightScreenState extends State<AddSightScreen> {
  final FocusNode _focusNodeCategory = FocusNode();
  final FocusNode _focusNodeName = FocusNode();
  final FocusNode _focusNodeLatitude = FocusNode();
  final FocusNode _focusNodeLongitude = FocusNode();
  final FocusNode _focusNodeDescription = FocusNode();

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerLatitude = TextEditingController();
  final TextEditingController _controllerLongitude = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();

  SightType? _sightType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        height: 56,
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            AppStrings.cancel,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        title: AppStrings.newPlace,
        titleTextStyle: theme.textTheme.headlineSmall?.copyWith(
          color: theme.colorScheme.onBackground,
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CustomDropdownButton(
              title: AppStrings.category,
              value: _sightType,
              items: SightType.values.map((e) {
                return DropdownMenuItem(value: e, child: Text(e.toString()));
              }).toList(),
              onChanged: (newValue) {
                _sightType = newValue as SightType?;
                setState(() {});
              },
              focusNode: _focusNodeCategory,
              focusNodeNext: _focusNodeName,
            ),
            _CustomTextField(
              title: AppStrings.name,
              focusNode: _focusNodeName,
              focusNodeNext: _focusNodeLatitude,
              controller: _controllerName,
              onTap: () {
                setState(() {});
              },
              onSubmitted: (_) {
                setState(() {});
              },
            ),
            Row(
              children: [
                Expanded(
                  child: _CoordinateTextField(
                    title: AppStrings.latitude,
                    focusNode: _focusNodeLatitude,
                    focusNodeNext: _focusNodeLongitude,
                    controller: _controllerLatitude,
                    onTap: () {
                      setState(() {});
                    },
                    onSubmitted: (_) {
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _CoordinateTextField(
                    title: AppStrings.longitude,
                    focusNode: _focusNodeLongitude,
                    focusNodeNext: _focusNodeDescription,
                    controller: _controllerLongitude,
                    onTap: () {
                      setState(() {});
                    },
                    onSubmitted: (_) {
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            TextButton(
              onFocusChange: (value) {
                if (value) FocusScope.of(context).nextFocus();
              },
              onPressed: () {},
              child: Text(
                AppStrings.specifyOnTheMap,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.secondary,
                ),
              ),
            ),
            _CustomTextField(
              title: AppStrings.description,
              focusNode: _focusNodeDescription,
              controller: _controllerDescription,
              height: 80,
              hintText: AppStrings.enterText,
              onTap: () {
                setState(() {});
              },
              onSubmitted: (_) {
                setState(() {});
              },
            ),
          ],
        ),
      ),
      bottomSheet: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Consumer<Filter>(
            builder: (context, filter, child) => BigButton(
              title: AppStrings.create,
              active: _sightType != null &&
                  _controllerName.text.isNotEmpty &&
                  _controllerLatitude.text.isNotEmpty &&
                  _controllerLongitude.text.isNotEmpty &&
                  _controllerDescription.text.isNotEmpty,
              onPressed: () {
                final newSight = Sight(
                  name: _controllerName.text,
                  location: Location(
                    double.parse(_controllerLatitude.text),
                    double.parse(_controllerLongitude.text),
                  ),
                  url: '',
                  details: _controllerDescription.text,
                  type: _sightType!,
                );
                filter.addSight(newSight);
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}

// виджет для отображения текстового поля ввода координаты
class _CoordinateTextField extends StatelessWidget {
  static final RegExp _inputPattern = RegExp(r'^-?(\d{1,3}(\.\d*)?)?');

  final String title;
  final FocusNode focusNode;
  final FocusNode? focusNodeNext;
  final TextEditingController controller;
  final VoidCallback onTap;
  final ValueChanged<String> onSubmitted;

  const _CoordinateTextField({
    Key? key,
    required this.title,
    required this.focusNode,
    this.focusNodeNext,
    required this.controller,
    required this.onTap,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _CustomTextField(
      title: AppStrings.longitude,
      focusNode: focusNode,
      focusNodeNext: focusNodeNext,
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(_inputPattern),
        LimitRangeTextInputFormatter(-180, 180),
      ],
      onTap: onTap,
      onSubmitted: onSubmitted,
    );
  }
}

// виджет выбора категории из впадающего списка
class _CustomDropdownButton extends StatelessWidget {
  final Object? value;
  final List<DropdownMenuItem<Object>> items;
  final String title;
  final ValueChanged<Object?> onChanged;
  final FocusNode focusNode;
  final FocusNode focusNodeNext;

  const _CustomDropdownButton({
    Key? key,
    this.value,
    required this.items,
    required this.title,
    required this.onChanged,
    required this.focusNode,
    required this.focusNodeNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          title,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.outline,
          ),
        ),
        const SizedBox(height: 12),
        DropdownButton(
          value: value,
          isExpanded: true,
          hint: Text(
            AppStrings.notSelected,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onTertiary,
          ),
          borderRadius: BorderRadius.circular(8),
          items: SightType.values.map((e) {
            return DropdownMenuItem(value: e, child: Text(e.toString()));
          }).toList(),
          onChanged: (newValue) {
            focusNodeNext.requestFocus();
            onChanged(newValue);
          },
        ),
      ],
    );
  }
}

// кастомизированное текстовое поле
class _CustomTextField extends StatelessWidget {
  final String title;
  final FocusNode focusNode;
  final FocusNode? focusNodeNext;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback onTap;
  final ValueChanged<String> onSubmitted;
  final double height;
  final String? hintText;

  const _CustomTextField({
    Key? key,
    required this.title,
    required this.focusNode,
    this.focusNodeNext,
    required this.controller,
    required this.onTap,
    required this.onSubmitted,
    this.keyboardType,
    this.inputFormatters,
    this.height = 40,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = theme.colorScheme.secondary.withOpacity(0.4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          title,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.outline,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          focusNode: focusNode,
          controller: controller,
          onTap: onTap,
          onSubmitted: (_) {
            if (focusNodeNext == null) {
              focusNode.unfocus();
            } else {
              focusNodeNext!.requestFocus();
            }
            onSubmitted(_);
          },
          keyboardType: keyboardType,
          textInputAction: (focusNodeNext == null)
              ? TextInputAction.done
              : TextInputAction.next,
          inputFormatters: inputFormatters,
          maxLines: null,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: borderColor,
              ),
            ),
            constraints: BoxConstraints(
              maxHeight: height,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: borderColor,
              ),
            ),
            suffixIcon: ClearTextButton(
              controller: controller,
              visible: focusNode.hasFocus,
            ),
            hintText: hintText,
            hintStyle: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onTertiary,
          ),
        ),
      ],
    );
  }
}

// Input Formatter значения координаты
class LimitRangeTextInputFormatter extends TextInputFormatter {
  final int min;
  final int max;

  LimitRangeTextInputFormatter(this.min, this.max) : assert(min < max);
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final value = double.parse(newValue.text);

    if (value < min) {
      return oldValue;
    } else if (value > max) {
      return oldValue;
    }

    return newValue;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/location.dart';
import 'package:places/domain/sight.dart';
import 'package:places/domain/sight_type.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/models/filter_model.dart';
import 'package:places/ui/screen/res/assets.dart';
import 'package:places/ui/screen/res/strings.dart';
import 'package:places/ui/screen/select_category_screen.dart';
import 'package:places/ui/widgets/app_bar.dart';
import 'package:places/ui/widgets/big_button.dart';
import 'package:places/ui/widgets/clear_text_button.dart';
import 'package:places/ui/widgets/network_image.dart';
import 'package:provider/provider.dart';

// экран добавления интересного места в список
class AddSightScreen extends StatefulWidget {
  const AddSightScreen({Key? key}) : super(key: key);

  @override
  State<AddSightScreen> createState() => _AddSightScreenState();
}

class _AddSightScreenState extends State<AddSightScreen> {
  final FocusNode _focusNodeName = FocusNode();
  final FocusNode _focusNodeLatitude = FocusNode();
  final FocusNode _focusNodeLongitude = FocusNode();
  final FocusNode _focusNodeDescription = FocusNode();

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerLatitude = TextEditingController();
  final TextEditingController _controllerLongitude = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();

  final List<Widget> _images = [];

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
            const SizedBox(
              height: 24,
            ),
            _LoadedImages(
              images: _images,
              onAdd: (image) {
                setState(() {
                  _images.add(image);
                });
              },
              onRemove: (image) {
                setState(() {
                  _images.remove(image);
                });
              },
            ),
            const SizedBox(
              height: 24,
            ),
            _CustomCategoryButton(
              sightType: _sightType,
              onSelect: (selectedSightType) {
                _sightType = selectedSightType;
                setState(() {});
                _focusNodeName.requestFocus();
              },
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
                  imageURLs: [],
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

class _CustomCategoryButton extends StatelessWidget {
  final SightType? sightType;
  final ValueChanged<SightType> onSelect;

  const _CustomCategoryButton({
    Key? key,
    this.sightType,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.category.toUpperCase(),
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.outline,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (sightType != null)
              Text(
                sightType.toString(),
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onTertiary,
                ),
              )
            else
              Text(
                AppStrings.notSelected,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push<MaterialPageRoute>(
                  MaterialPageRoute(
                    builder: (context) => SelectCategory(onSelect: onSelect),
                  ),
                );
              },
              icon: SvgPicture.asset(AppAssets.iconView),
              padding: EdgeInsets.zero,
              splashRadius: 16,
              constraints: const BoxConstraints(
                minHeight: 24,
                minWidth: 24,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        const Divider(thickness: 0.8, height: 0),
      ],
    );
  }
}

// Виджет, реализующий горизонтальный список из кнопки добавления изображений
// и картинок уже добавленных изображений
class _LoadedImages extends StatelessWidget {
  final List<Widget> images;
  final ValueChanged<Widget> onAdd;
  final ValueChanged<Widget> onRemove;

  const _LoadedImages({
    Key? key,
    required this.images,
    required this.onAdd,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length + 1,
        itemBuilder: (context, index) => (index == 0)
            ? _AddImageButton(
                onPressed: () {
                  final image = CustomImage(
                    MockImages.randomURL(),
                    height: 72,
                    width: 72,
                  );
                  onAdd(image);
                },
              )
            : _LoadedImage(
                image: images[index - 1],
                onRemove: onRemove,
              ),
      ),
    );
  }
}

// кнопка добавления изображения
class _AddImageButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _AddImageButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // return MaterialButton(
    //   onPressed: onPressed,
    //   child: SvgPicture.asset(
    //     AppAssets.iconButtonPlus,
    //     color: theme.colorScheme.secondary,
    //   ),
    //   padding: EdgeInsets.zero,
    //   minWidth: 0,
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.all(
    //       Radius.circular(12),
    //     ),
    //   ),
    // );

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onPressed,
        child: SvgPicture.asset(
          height: 72,
          AppAssets.iconButtonPlus,
          color: theme.colorScheme.secondary,
        ),
      ),
    );
  }
}

// добавленное изображение
class _LoadedImage extends StatelessWidget {
  final Widget image;
  final ValueChanged<Widget> onRemove;

  const _LoadedImage({Key? key, required this.image, required this.onRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dismissible(
      direction: DismissDirection.up,
      key: ValueKey(image),
      onDismissed: (_) {
        onRemove(image);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Stack(
          children: [
            ClipRRect(
              child: image,
              borderRadius: BorderRadius.circular(12),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Material(
                color: Colors.transparent,
                child: IconButton(
                  onPressed: () {
                    onRemove(image);
                  },
                  icon: SvgPicture.asset(
                    AppAssets.iconClear,
                    color: theme.colorScheme.tertiary,
                  ),
                  padding: const EdgeInsets.all(6),
                  constraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  splashRadius: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

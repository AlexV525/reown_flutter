import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';
import 'package:reown_appkit/modal/widgets/avatars/account_avatar.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';

class Orb extends StatelessWidget {
  const Orb({super.key, this.size = 70.0});
  final double size;

  @override
  Widget build(BuildContext context) {
    final themeColors = AppKitModalTheme.colorsOf(context);
    final service = ModalProvider.of(context).service;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        border: Border.all(
          color: themeColors.grayGlass005,
          width: 8.0,
        ),
      ),
      child: AccountAvatar(
        service: service,
        size: size - 8.0,
      ),
    );
  }
}

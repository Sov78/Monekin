import 'package:flutter/material.dart';
import 'package:monekin/app/budgets/budgets_page.dart';
import 'package:monekin/app/categories/categories_list.dart';
import 'package:monekin/app/currencies/currency_manager.dart';
import 'package:monekin/app/settings/about_page.dart';
import 'package:monekin/app/settings/appearance_settings_page.dart';
import 'package:monekin/app/settings/backup_settings_page.dart';
import 'package:monekin/app/settings/help_us_page.dart';
import 'package:monekin/app/stats/stats_page.dart';
import 'package:monekin/app/tags/tag_list.page.dart';
import 'package:monekin/app/transactions/recurrent_transactions_page.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/color_utils.dart';
import 'package:monekin/i18n/translations.g.dart';

import '../../core/presentation/app_colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

Widget createListSeparator(BuildContext context, String title) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
    child: Text(
      title.toUpperCase(),
      style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: AppColors.of(context).primary),
    ),
  );
}

Widget createSettingItem(
  BuildContext context, {
  required String title,
  String? subtitle,
  required IconData icon,
  required Function() onTap,
  Axis mainAxis = Axis.vertical,
  bool isPrimary = false,
}) {
  return Tappable(
    bgColor: isPrimary
        ? Theme.of(context).brightness == Brightness.light
            ? AppColors.of(context).primary.lighten(0.8)
            : AppColors.of(context).primary.darken(0.8)
        : null,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(
        width: 2,
        color: isPrimary
            ? AppColors.of(context).primary
            : Theme.of(context).dividerColor,
      ),
    ),
    onTap: () => onTap(),
    child: Container(
      padding: EdgeInsets.symmetric(
        vertical: mainAxis == Axis.horizontal ? 12 : 12,
        horizontal: mainAxis == Axis.horizontal ? 16 : 16,
      ),
      child: Flex(
        direction: mainAxis,
        //mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isPrimary ? AppColors.of(context).primary : null,
            size: mainAxis == Axis.horizontal ? 24 : 28,
            // color: AppColors.of(context).primary,
          ),
          if (mainAxis == Axis.horizontal) const SizedBox(width: 12),
          if (mainAxis == Axis.vertical) const SizedBox(height: 8),
          Builder(builder: (context) {
            final toReturn = Column(
              crossAxisAlignment: mainAxis == Axis.vertical
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  textAlign: mainAxis == Axis.vertical
                      ? TextAlign.center
                      : TextAlign.start,
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: mainAxis == Axis.vertical
                        ? TextAlign.center
                        : TextAlign.start,
                  )
              ],
            );

            return mainAxis == Axis.vertical
                ? toReturn
                : Expanded(child: toReturn);
          })
        ],
      ),
    ),
  );
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(t.more.title_long),
        ),
        body: SingleChildScrollView(
          padding:
              const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              createSettingItem(
                context,
                isPrimary: true,
                title: t.more.help_us.display,
                subtitle: t.more.help_us.description,
                icon: Icons.favorite_rounded,
                mainAxis: Axis.horizontal,
                onTap: () => RouteUtils.pushRoute(context, const HelpUsPage()),
              ),
              const SizedBox(height: 8),
              createSettingItem(
                context,
                title: t.settings.title_long,
                subtitle: t.settings.description,
                icon: Icons.palette_outlined,
                mainAxis: Axis.horizontal,
                onTap: () =>
                    RouteUtils.pushRoute(context, const AdvancedSettingsPage()),
              ),
              const SizedBox(height: 8),
              createSettingItem(
                context,
                title: t.currencies.currency_manager,
                subtitle: t.currencies.currency_manager_descr,
                icon: Icons.currency_exchange,
                mainAxis: Axis.horizontal,
                onTap: () =>
                    RouteUtils.pushRoute(context, const CurrencyManagerPage()),
              ),
              const SizedBox(height: 8),
              createSettingItem(
                context,
                title: t.more.data.display,
                subtitle: t.more.data.display_descr,
                icon: Icons.storage_rounded,
                mainAxis: Axis.horizontal,
                onTap: () =>
                    RouteUtils.pushRoute(context, const BackupSettingsPage()),
              ),
              const SizedBox(height: 8),
              createSettingItem(
                context,
                title: t.more.about_us.display,
                subtitle: t.more.about_us.description,
                icon: Icons.info_outline_rounded,
                mainAxis: Axis.horizontal,
                onTap: () => RouteUtils.pushRoute(context, const AboutPage()),
              ),
              if (BreakPoint.of(context).isSmallerThan(BreakpointID.md)) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: createSettingItem(
                        context,
                        title: t.stats.title,
                        icon: Icons.area_chart_rounded,
                        onTap: () =>
                            RouteUtils.pushRoute(context, const StatsPage()),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: createSettingItem(
                        context,
                        title: t.budgets.title,
                        icon: Icons.pie_chart_rounded,
                        onTap: () =>
                            RouteUtils.pushRoute(context, const BudgetsPage()),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: createSettingItem(
                        context,
                        title: t.recurrent_transactions.title_short,
                        icon: Icons.repeat_rounded,
                        onTap: () => RouteUtils.pushRoute(
                            context, const RecurrentTransactionPage()),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: createSettingItem(
                      context,
                      title: t.general.categories,
                      icon: Icons.category_rounded,
                      onTap: () => RouteUtils.pushRoute(
                          context, const CategoriesListPage()),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: createSettingItem(
                      context,
                      title: t.tags.display(n: 10),
                      icon: Icons.label_outline_rounded,
                      onTap: () =>
                          RouteUtils.pushRoute(context, const TagListPage()),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: createSettingItem(
                      context,
                      title: t.general.accounts,
                      icon: Icons.account_balance_wallet_rounded,
                      onTap: () =>
                          RouteUtils.pushRoute(context, const TagListPage()),
                    ),
                  ),
                  if (BreakPoint.of(context).isLargerThan(BreakpointID.sm)) ...[
                    const SizedBox(width: 8),
                    Expanded(
                      child: createSettingItem(
                        context,
                        title: t.recurrent_transactions.title_short,
                        icon: Icons.repeat_rounded,
                        onTap: () => RouteUtils.pushRoute(
                            context, const RecurrentTransactionPage()),
                      ),
                    ),
                  ]
                ],
              ),
            ],
          ),
        ));
  }
}

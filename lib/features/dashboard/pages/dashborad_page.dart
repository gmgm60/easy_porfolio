import 'package:easy_porfolio/core/utils/smooth_scroll_behavior.dart';
import 'package:easy_porfolio/features/auth/presentation/widgets/slide_fade_transition_widget.dart';
import 'package:easy_porfolio/features/dashboard/widgets/metric_card_widget.dart';
import 'package:easy_porfolio/features/dashboard/widgets/quick_action_button_widget.dart';
import 'package:easy_porfolio/features/dashboard/widgets/segmented_tabs_widget.dart';
import 'package:easy_porfolio/features/dashboard/widgets/traffic_chart_painter_widget.dart';
import 'package:flutter/material.dart';

/// Dashboard main screen
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String _range = 'Month';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
         final isLargeScreen = constraints.maxWidth > 600;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ScrollConfiguration(
                behavior: const SmoothNoBarScrollBehavior(),
                child: SingleChildScrollView(
                  padding: isLargeScreen ? const EdgeInsets.all(16.0) : EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Use a responsive widget for the metric cards
                      _buildMetricCards(isLargeScreen),
                      const SizedBox(height: 20),
                      _buildTrafficChart(theme),
                      const SizedBox(height: 16),
                      // Use a responsive widget for the quick action buttons
                      _buildQuickActionButtons(isLargeScreen),
                      // Add some padding at the bottom for scroll space
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
            // This button can stay at the bottom
            Padding(
              padding: isLargeScreen ? const EdgeInsets.fromLTRB(16, 0, 16, 8) : const EdgeInsets.fromLTRB(0, 0, 0, 8),
              child: SizedBox(
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.open_in_new),
                  label: const Text(
                    'View Public Portfolio',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Builds the metric cards in a Row for large screens and a Column for small screens.
  Widget _buildMetricCards(bool isLargeScreen) {
    const cards = [
      SlideFadeTransitionWidget(
        child: MetricCardWidget(
          title: 'Portfolio Views',
          value: '1,420',
          changeLabel: '+12.5%',
          isPositive: true,
        ),
      ),
      SlideFadeTransitionWidget(
        delay: Duration(milliseconds: 100),
        child: MetricCardWidget(
          title: 'Contact Clicks',
          value: '89',
          changeLabel: '+8.2%',
          isPositive: true,
        ),
      ),
      SlideFadeTransitionWidget(
        delay: Duration(milliseconds: 200),
        child: MetricCardWidget(
          title: 'Project Views',
          value: '950',
          changeLabel: '-3.1%',
          isPositive: false,
        ),
      ),
    ];

    if (isLargeScreen) {
      // For large screens, use a Row with Expanded children
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: cards
            .map((card) => Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: card,
          ),
        ))
            .toList(),
      );
    } else {
      // For small screens, use a Column
      return Column(
        children: cards
            .map((card) => Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: card,
        ))
            .toList(),
      );
    }
  }

  /// Builds the quick action buttons horizontally for large screens and vertically for small screens.
  Widget _buildQuickActionButtons(bool isLargeScreen) {
    if (isLargeScreen) {
      // For large screens, all buttons are in a single horizontal row.
      return const SlideFadeTransitionWidget(
        delay: Duration(milliseconds: 400),
        child: Row(
          children: [
            Expanded(
              child: QuickActionButtonWidget(
                icon: Icons.person_outline,
                label: 'Manage Profile',
                fullWidth: true, // Use fullWidth to fill the Expanded space
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: QuickActionButtonWidget(
                icon: Icons.view_kanban_outlined,
                label: 'Manage Projects',
                fullWidth: true,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: QuickActionButtonWidget(
                icon: Icons.phone_outlined,
                label: 'Update Contact Info',
                fullWidth: true,
              ),
            ),
          ],
        ),
      );
    } else {
      // For small screens, keep the original vertical layout.
      return const SlideFadeTransitionWidget(
        delay: Duration(milliseconds: 400),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: QuickActionButtonWidget(
                    icon: Icons.person_outline,
                    label: 'Manage Profile',
                    fullWidth: false, // Set to false for Row layout
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: QuickActionButtonWidget(
                    icon: Icons.view_kanban_outlined,
                    label: 'Manage Projects',
                    fullWidth: false,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            QuickActionButtonWidget(
              icon: Icons.phone_outlined,
              label: 'Update Contact Info',
              fullWidth: true, // Full width for the single button
            ),
          ],
        ),
      );
    }
  }

  /// Extracted the traffic chart widget for cleanliness.
  Widget _buildTrafficChart(ThemeData theme) {
    return SlideFadeTransitionWidget(
      delay: const Duration(milliseconds: 300),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SegmentedTabsWidget(
                current: _range,
                options: const ['Week', 'Month', 'Year'],
                onChanged: (value) => setState(() => _range = value),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Portfolio Traffic',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '1.4k',
                  style: theme.textTheme.headlineMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 4),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: Text(
                    'Views',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            RichText(
              text: TextSpan(
                style: theme.textTheme.bodySmall,
                children: [
                  const TextSpan(text: 'Last 30 Days '),
                  TextSpan(
                    text: '+12.5%',
                    style: TextStyle(
                      color: theme.colorScheme.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 140,
              child: CustomPaint(
                painter: TrafficChartPainterWidget(
                  color: theme.colorScheme.primary,
                  points: const [0.35, 0.7, 0.45, 0.8, 0.4, 0.9, 0.6],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _chartLabel(context, 'W1'),
                      _chartLabel(context, 'W2'),
                      _chartLabel(context, 'W3'),
                      _chartLabel(context, 'W4'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chartLabel(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .labelSmall
          ?.copyWith(color: Colors.grey.shade500),
    );
  }
}


import 'package:easy_porfolio/core/utils/smooth_scroll_behavior.dart';
import 'package:easy_porfolio/features/auth/presentation/widgets/slide_fade_transition_widget.dart';
import 'package:easy_porfolio/features/dashboard/widgets/dashboard_top_bar_widget.dart';
import 'package:easy_porfolio/features/dashboard/widgets/metric_card_widget.dart';
import 'package:easy_porfolio/features/dashboard/widgets/quick_action_button_widget.dart';
import 'package:easy_porfolio/features/dashboard/widgets/segmented_tabs_widget.dart';
import 'package:easy_porfolio/features/dashboard/widgets/traffic_chart_painter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';


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

     return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // This Expanded widget contains all the content that should scroll.
        Expanded(
          child: ScrollConfiguration(
            behavior: const SmoothNoBarScrollBehavior(),
            child: SingleChildScrollView(
               physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DashboardTopBarWidget(onPressedMenu:()=>ZoomDrawer.of(context)?.toggle()),
                  const SizedBox(height: 16),
                  // Add staggered entrance animations for a polished feel.
                  const SlideFadeTransitionWidget(
                    child: MetricCardWidget(
                      title: 'Portfolio Views',
                      value: '1,420',
                      changeLabel: '+12.5%',
                      isPositive: true,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const SlideFadeTransitionWidget(
                    delay: Duration(milliseconds: 100),
                    child: MetricCardWidget(
                      title: 'Contact Clicks',
                      value: '89',
                      changeLabel: '+8.2%',
                      isPositive: true,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const SlideFadeTransitionWidget(
                    delay: Duration(milliseconds: 200),
                    child: MetricCardWidget(
                      title: 'Project Views',
                      value: '950',
                      changeLabel: '-3.1%',
                      isPositive: false,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SlideFadeTransitionWidget(
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
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 2.0),
                                child: Text('Views',
                                    style: theme.textTheme.bodyMedium),
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
                                points: const [
                                  0.35,
                                  0.7,
                                  0.45,
                                  0.8,
                                  0.4,
                                  0.9,
                                  0.6
                                ],
                              ),
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 4),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
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
                  ),
                  const SizedBox(height: 16),
                  const SlideFadeTransitionWidget(
                    delay: Duration(milliseconds: 400),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        QuickActionButtonWidget(
                          icon: Icons.person_outline,
                          label: 'Manage Profile',
                        ),
                        QuickActionButtonWidget(
                          icon: Icons.view_kanban_outlined,
                          label: 'Manage Projects',
                        ),
                        QuickActionButtonWidget(
                          icon: Icons.phone_outlined,
                          label: 'UpdatenContact Info',
                          fullWidth: true,
                        ),
                      ],
                    ),
                  ),
                  // Add some padding at the bottom of the scrollable area
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
         SizedBox(
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
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _chartLabel(BuildContext context, String text) {
    return Text(
      text,
      style: Theme
          .of(
        context,
      )
          .textTheme
          .labelSmall
          ?.copyWith(color: Colors.grey.shade500),
    );
  }}
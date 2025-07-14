import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widgets/persona_chat_widget.dart';

class PlatformAnalyticsScreen extends StatefulWidget {
  final String platform;

  const PlatformAnalyticsScreen({super.key, required this.platform});

  @override
  State<PlatformAnalyticsScreen> createState() => _PlatformAnalyticsScreenState();
}

class _PlatformAnalyticsScreenState extends State<PlatformAnalyticsScreen> {
  int _selectedTimeRange = 0; // 0: 7 days, 1: 30 days, 2: 90 days
  final List<String> _timeRanges = ['7 days', '30 days', '90 days'];

  // Get persona data for chat
  Map<String, dynamic> _getPersonaData() {
    final Map<String, Map<String, dynamic>> personas = {
      'twitter': {
        'name': 'Echo',
        'title': 'Real-Time Response Specialist',
        'avatar': '⚡',
      },
      'linkedin': {
        'name': 'Sterling',
        'title': 'B2B Lead Intelligence Expert',
        'avatar': '🧠',
      },
      'instagram': {
        'name': 'Vibe',
        'title': 'Creative Engagement Guru',
        'avatar': '✨',
      },
      'facebook': {
        'name': 'Harmony',
        'title': 'Community Growth Specialist',
        'avatar': '💫',
      },
    };
    return personas[widget.platform] ?? personas['twitter']!;
  }

  Map<String, dynamic> _getContextData() {
    return {
      'mentionsCount': 1200,
      'leadsCount': 247,
      'sentiment': 85,
      'platform': widget.platform,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFDAC0A7), Color(0xFFC8A882)],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.insights, size: 20, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Text(
              '${widget.platform.toUpperCase()} Analytics',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Color(0xFFDAC0A7)),
            onPressed: _shareReport,
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0F0F0F),
                  Color(0xFF1A1A1A),
                ],
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Time Range Selector
                  _buildTimeRangeSelector(),
                  const SizedBox(height: 24),
                  
                  // Key Metrics Row
                  _buildKeyMetrics(),
                  const SizedBox(height: 24),
                  
                  // Charts Section
                  _buildChartsSection(),
                  const SizedBox(height: 24),
                  
                  // Insights Section
                  _buildInsightsSection(),
                ],
              ),
            ),
          ),
          // Floating Chat Widget
          PersonaChatWidget(
            platform: widget.platform,
            persona: _getPersonaData(),
            contextData: _getContextData(),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeRangeSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: _timeRanges.asMap().entries.map((entry) {
          final isSelected = entry.key == _selectedTimeRange;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTimeRange = entry.key),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFDAC0A7) : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  entry.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildKeyMetrics() {
    return Row(
      children: [
        Expanded(child: _buildMetricCard('1.2K', 'Total Mentions', Icons.forum, Colors.blue)),
        const SizedBox(width: 16),
        Expanded(child: _buildMetricCard('85%', 'Positive Sentiment', Icons.sentiment_satisfied, Colors.green)),
        const SizedBox(width: 16),
        Expanded(child: _buildMetricCard('247', 'Leads Generated', Icons.star, const Color(0xFFDAC0A7))),
      ],
    );
  }

  Widget _buildMetricCard(String value, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF3A3A3A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(Icons.trending_up, color: color, size: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF888888),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Analytics Overview',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFFDAC0A7), // Warm sand color for header prominence
          ),
        ),
        const SizedBox(height: 16),
        
        // Mention Volume Chart
        _buildChartCard(
          'Mention Volume Trends',
          _buildLineChart(),
        ),
        const SizedBox(height: 16),
        
        // Sentiment Distribution
        Row(
          children: [
            Expanded(
              child: _buildChartCard(
                'Sentiment Distribution',
                _buildPieChart(),
                height: 250,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildChartCard(
                'Top Keywords',
                _buildBarChart(),
                height: 250,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChartCard(String title, Widget chart, {double? height}) {
    return Container(
      height: height ?? 300,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF3A3A3A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(child: chart),
        ],
      ),
    );
  }

  Widget _buildLineChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: [
              const FlSpot(0, 3),
              const FlSpot(1, 1),
              const FlSpot(2, 4),
              const FlSpot(3, 2),
              const FlSpot(4, 5),
              const FlSpot(5, 3),
              const FlSpot(6, 6),
            ],
            isCurved: true,
            color: const Color(0xFFDAC0A7),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: const Color(0xFFDAC0A7).withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart() {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            color: Colors.green,
            value: 60,
            title: '60%',
            radius: 60,
            titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          PieChartSectionData(
            color: Colors.orange,
            value: 25,
            title: '25%',
            radius: 50,
            titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          PieChartSectionData(
            color: Colors.red,
            value: 15,
            title: '15%',
            radius: 40,
            titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
        sectionsSpace: 2,
        centerSpaceRadius: 40,
      ),
    );
  }

  Widget _buildBarChart() {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 100,
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: [
          _makeGroupData(0, 80),
          _makeGroupData(1, 60),
          _makeGroupData(2, 40),
          _makeGroupData(3, 30),
          _makeGroupData(4, 20),
        ],
      ),
    );
  }

  BarChartGroupData _makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: const Color(0xFFDAC0A7),
          width: 20,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  Widget _buildInsightsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'AI-Generated Insights',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFFDAC0A7), // Warm sand color for header prominence
          ),
        ),
        const SizedBox(height: 16),
        _buildInsightCard(
          Icons.trending_up,
          'Peak Engagement',
          'Your audience is most active between 2-4 PM on weekdays. Consider scheduling posts during this time for maximum reach.',
          Colors.green,
        ),
        const SizedBox(height: 12),
        _buildInsightCard(
          Icons.psychology,
          'Content Recommendation',
          'Posts with images receive 3x more engagement. Your audience responds well to behind-the-scenes content.',
          const Color(0xFFDAC0A7),
        ),
        const SizedBox(height: 12),
        _buildInsightCard(
          Icons.warning,
          'Attention Required',
          'Negative sentiment increased by 12% this week. Review customer service response times.',
          Colors.orange,
        ),
      ],
    );
  }

  Widget _buildInsightCard(IconData icon, String title, String description, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF888888),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _shareReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Analytics report shared successfully!'),
        backgroundColor: Color(0xFFDAC0A7),
      ),
    );
  }
}
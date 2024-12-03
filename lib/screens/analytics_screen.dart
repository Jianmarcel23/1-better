import 'package:flutter/material.dart';
import '../widgets/task_analytics.dart';
import '../models/motivation.dart';
import '../models/achievement.dart';

class AnalyticsScreen extends StatelessWidget {
  final TaskAnalytics analytics;
  final List<Achievement> achievements;

  const AnalyticsScreen(
      {super.key, required this.analytics, required this.achievements});

  @override
  Widget build(BuildContext context) {
    final quote = MotivationalQuote.getRandomQuote();

    return Scaffold(
      appBar: AppBar(
        title: Text('Produktivitas Saya'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Motivational Quote Card
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        '"${quote.text}"',
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        "- ${quote.author}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Produktivitas Overview
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Produktivitas Minggu Ini',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatCard(context, 'Total Tugas',
                              analytics.totalTasksCompleted.toString()),
                          _buildStatCard(context, 'Waktu Produktif',
                              '${analytics.totalProductiveTime.inHours} jam'),
                          _buildStatCard(context, 'Skor',
                              analytics.productivityScore.toStringAsFixed(1)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Produktivitas Mingguan
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Grafik Produktivitas Mingguan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      _buildWeeklyProductivityGraph(),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Achievements
              Text(
                'Pencapaian',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.7,
                ),
                itemCount: achievements.length,
                itemBuilder: (context, index) {
                  final achievement = achievements[index];
                  return Card(
                    color: achievement.isUnlocked
                        ? Colors.green[100]
                        : Colors.grey[300],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            achievement.isUnlocked
                                ? Icons.stars
                                : Icons.lock_outline,
                            color: achievement.isUnlocked
                                ? Colors.amber
                                : Colors.grey,
                            size: 40,
                          ),
                          SizedBox(height: 8),
                          Text(
                            achievement.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: achievement.isUnlocked
                                  ? Colors.black87
                                  : Colors.black54,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            achievement.description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              color: achievement.isUnlocked
                                  ? Colors.black54
                                  : Colors.black38,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildWeeklyProductivityGraph() {
    // Simulasi data produktivitas mingguan
    final List<double> weeklyData = [2.5, 3.0, 2.8, 3.5, 3.2, 2.7, 3.6];

    return SizedBox(
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: weeklyData.map((value) {
          return Container(
            width: 30,
            height: value * 30, // Skala ketinggian batang
            color: Colors.blue[400],
            margin: EdgeInsets.symmetric(horizontal: 2),
          );
        }).toList(),
      ),
    );
  }
}

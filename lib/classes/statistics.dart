class Statistics {
  int totalGames;
  int totalWins;
  int currentStreak;
  int maxStreak;
  Map<int, int>
      guessDistribution; // Key: number of guesses, Value: count of wins

  Statistics({
    this.totalGames = 0,
    this.totalWins = 0,
    this.currentStreak = 0,
    this.maxStreak = 0,
    Map<int, int>? guessDistribution,
  }) : guessDistribution =
            guessDistribution ?? {1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0};

  void addGame({required bool won, int? numGuesses}) {
    totalGames++;

    if (won) {
      totalWins++;
      currentStreak++;
      maxStreak = currentStreak > maxStreak ? currentStreak : maxStreak;
      if (numGuesses != null) {
        guessDistribution[numGuesses] =
            (guessDistribution[numGuesses] ?? 0) + 1;
      }
    } else {
      currentStreak = 0;
      guessDistribution[7] = (guessDistribution[7] ?? 0) + 1;
    }
  }

  double get winPercentage =>
      totalGames == 0 ? 0 : (totalWins / totalGames * 100);

  Map<String, dynamic> toJson() => {
        'totalGames': totalGames,
        'totalWins': totalWins,
        'currentStreak': currentStreak,
        'maxStreak': maxStreak,
        'guessDistribution': guessDistribution
            .map((key, value) => MapEntry(key.toString(), value)),
      };

  factory Statistics.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> rawDistribution =
        json['guessDistribution'] as Map<String, dynamic>? ?? {};

    // Convert string keys back to integers
    Map<int, int> guessDistribution = rawDistribution
        .map((key, value) => MapEntry(int.parse(key), value as int));

    return Statistics(
      totalGames: json['totalGames'] as int? ?? 0,
      totalWins: json['totalWins'] as int? ?? 0,
      currentStreak: json['currentStreak'] as int? ?? 0,
      maxStreak: json['maxStreak'] as int? ?? 0,
      guessDistribution: guessDistribution,
    );
  }
}

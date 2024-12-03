class MotivationalQuote {
  final String text;
  final String author;

  MotivationalQuote({required this.text, required this.author});

  static List<MotivationalQuote> quotes = [
    MotivationalQuote(
        text: "Setiap hari adalah kesempatan untuk menjadi 1% lebih baik.",
        author: "Anonymous"),
    MotivationalQuote(
        text:
            "Produktivitas bukanlah tentang apa yang Anda selesaikan, tetapi tentang bagaimana Anda menyelesaikannya.",
        author: "Tim Ferriss"),
    MotivationalQuote(
        text: "Fokus adalah kunci utama produktivitas.", author: "James Clear"),
  ];

  static MotivationalQuote getRandomQuote() {
    return quotes[DateTime.now().millisecond % quotes.length];
  }
}

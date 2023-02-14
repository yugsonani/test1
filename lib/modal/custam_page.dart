class Joke {
  final String value;
  final String date;
  final String time;


  // final int totalConfirmed;
  Joke({
    required this.value,
    required this.date,
    required this.time,


    // required this.totalConfirmed,
  });

  factory Joke.fromjson({required Map json}) {
    return Joke(
      value: json["value"],
      date: json['created_at'],
      time: json['updated_at'],

    );
  }
}
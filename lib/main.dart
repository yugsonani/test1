import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'helper/api_helper.dart';
import 'modal/custam_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => random(),
    },
  ));
}

class random extends StatefulWidget {
  const random({Key? key}) : super(key: key);

  @override
  State<random> createState() => _randomState();
}

class _randomState extends State<random> {
  dynamic? api;

  Future refresh() async {
    setState(() {
      API.api.fetchCurrency();
    });
  }

  String? time;
  String? date;
  String? obTime;
  String? fTime;
  DateTime today = DateTime.now();
  @override
  void initState() {
    super.initState();
    date = "${today.day}-${today.month}-${today.year}";
    time =
    "${DateTime.now().hour} : ${DateTime.now().minute} :${DateTime.now().second}";
    super.initState();
    fiTime();
  }

  fiTime() async {
    final prefs = await SharedPreferences.getInstance();
    obTime = prefs.getString('time');
    fTime = prefs.getString('date');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Feych My Laugh"),
        actions: [
          IconButton(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Center(
                          child: Text(
                            "DATE & TIME",
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "DATE :-  $obTime",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "TIME :- $fTime ",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      );
                    });
              },

           icon: const Icon(Icons.save_alt_sharp))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: FutureBuilder(
          future: API.api.fetchCurrency(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              Joke? data = snapshot.data as Joke;
              return (data != null)
                  ? Center(
                      child: SingleChildScrollView(
                        child: Container(

                          decoration:BoxDecoration(border: Border.all(width: 5),),
                          child: Column(children: [
                            Text(
                              "Updated At = ${data.time}",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            const Padding(padding: EdgeInsets.all(10)),
                            Text(
                              " Created At = ${data.date}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            const Padding(padding: EdgeInsets.all(20)),
                            Text(
                              "    jock = ${data.value}",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const Padding(padding: EdgeInsets.all(20)),
                            ElevatedButton(
                              onPressed: () async {
                                setState((){

                                });
                                final prefs =
                                await SharedPreferences.getInstance();
                                setState(() async {
                                  await prefs.setString('time', '$time');
                                  await prefs.setString('date', '$date');
                                  print(obTime);
                                });
                              },
                              child: const Text(
                                "Fetch My Laugh",
                              ),
                            ),
                          ]),
                        ),
                      ),
                    )
                  : const Center(
                      child: Text("No Data"),
                    );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
  void currentTime() {
    setState(() {
      time =
      "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}";
      date = "${today.day}-${today.month}-${today.year}";
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taxi_driver_app/core/services/country_service.dart';

class SelectCountry extends StatefulWidget {
  const SelectCountry({super.key});

  @override
  _SelectCountryState createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  final List<String> _alphabets = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "Y",
    "Z"
  ];
  List<String> _countries = [];

  @override
  void initState() {
    super.initState();
    _countries = countries.map((country) => country.name).toList();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ScrollController listController = ScrollController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "Select Country",
                      style: theme.textTheme.titleLarge!.merge(
                        const TextStyle(fontSize: 30.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    color: const Color(0xffEEF1F8),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        hintText: "Search...",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  _countries == null
                      ? const CircularProgressIndicator()
                      : Flexible(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: ListView.builder(
                                  controller: listController,
                                  itemCount: _countries.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      height: 60.0,
                                      child: ListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 0.0, vertical: 0.0),
                                        title: Wrap(
                                          children: <Widget>[
                                            Text(
                                              _countries[index].toUpperCase(),
                                              style: theme.textTheme.titleLarge!
                                                  .merge(
                                                const TextStyle(fontSize: 18.0),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Column(
                                children: _alphabets.map(
                                  (String alphabet) {
                                    return GestureDetector(
                                      onTap: () {
                                        int index =
                                            _countries.indexWhere((country) {
                                                  return country.startsWith(
                                                      alphabet.toUpperCase());
                                                }) ??
                                                0;
                                        listController.jumpTo(
                                          index * 60.0,
                                        );
                                      },
                                      child: Text(
                                        alphabet,
                                        style: TextStyle(
                                          color: theme.primaryColor,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              )
                            ],
                          ),
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

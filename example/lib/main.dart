import 'package:flutter/material.dart';
import 'package:select_text_field/select_text_field.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SelectTextField Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExamplePage(),
    );
  }
}

class ExamplePage extends StatefulWidget {
  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _sController = TextEditingController();
  TextEditingController _sController2 = TextEditingController();
  final List<Map<String, dynamic>> keyValuePairs = [
    {'title': 'Alice', 'value': 101},
    {'title': 'Bob', 'value': 202},
    {'title': 'Charlie', 'value': 303},
    {'title': 'David', 'value': 404},
    {'title': 'Eve', 'value': 505},
    {'title': 'Frank', 'value': 606},
    {'title': 'Grace', 'value': 707},
    {'title': 'Henry', 'value': 808},
    {'title': 'Ivy', 'value': 909},
    {'title': 'Jack', 'value': 111},
    {'title': 'Katie', 'value': 222},
    {'title': 'Liam', 'value': 333},
    {'title': 'Mia', 'value': 444},
    {'title': 'Nathan', 'value': 555},
    {'title': 'Olivia', 'value': 666},
    {'title': 'Peter', 'value': 777},
    {'title': 'Quinn', 'value': 888},
    {'title': 'Rachel', 'value': 999},
    {'title': 'Sam', 'value': 121},
    {'title': 'Tina', 'value': 232},
  ];
  @override
  Widget build(BuildContext context) {
    //_controller.text = "Option 2";
    return Scaffold(
      appBar: AppBar(
        title: Text('SelectTextField Example'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectTextField(
                options: ['Option 1', 'Option 2', 'Option 3'],
                label: 'Select an option',
                controller: _controller,
                onChanged: (value) {
                  print(value);
                  setState(() {
                    _controller.text = value;
                  });
                }),
            SizedBox(height: 20),
            Text(
              'Selected Option: ${_controller.text}*',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            SelectTextField(
                options: countryList,
                label: 'Search Example',
                controller: _sController,
                onChanged: (value) {
                  print("==string===");
                  print(value);

                  setState(() {
                    _sController.text = value;
                  });
                }),
            Text(
              'Selected Country: ${_sController.text}*',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Using keypair example',
              style: TextStyle(fontSize: 18),
            ),
            SelectTextField(
                options: keyValuePairs,
                label: 'Search Example',
                controller: _sController2,
                onChanged: (value) {
                  print("==dynamic===");
                  print(value);
                  /*  setState(() {
                    //_sController.text = value["value"];
                  }); */
                }),
            Text(
              'Selected Country: ${_sController2.text}*',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

List<String> countryList = [
  "Afghanistan",
  "Albania",
  "Algeria",
  "Andorra",
  "Angola",
  "Antigua and Barbuda",
  "Argentina",
  "Armenia",
  "Australia",
  "Austria",
  "Azerbaijan",
  "Bahamas",
  "Bahrain",
  "Bangladesh",
  "Barbados",
  "Belarus",
  "Belgium",
  "Belize",
  "Benin",
  "Bhutan",
  "Bolivia",
  "Bosnia and Herzegovina",
  "Botswana",
  "Brazil",
  "Brunei",
  "Bulgaria",
  "Burkina Faso",
  "Burundi",
  "Cabo Verde",
  "Cambodia",
  "Cameroon",
  "Canada",
  "Central African Republic",
  "Chad",
  "Chile",
  "China",
  "Colombia",
  "Comoros",
  "Congo",
  "Costa Rica",
  "Croatia",
  "Cuba",
  "Cyprus",
  "Czechia",
  "Denmark",
  "Djibouti",
  "Dominica",
  "Dominican Republic",
  "East Timor",
  "Ecuador",
  "Egypt",
  "El Salvador",
  "Equatorial Guinea",
  "Eritrea",
  "Estonia",
  "Eswatini",
  "Ethiopia",
  "Fiji",
  "Finland",
  "France",
  "Gabon",
  "Gambia",
  "Georgia",
  "Germany",
  "Ghana",
  "Greece",
  "Grenada",
  "Guatemala",
  "Guinea",
  "Guinea-Bissau",
  "Guyana",
  "Haiti",
  "Honduras",
  "Hungary",
  "Iceland",
  "India",
  "Indonesia",
  "Iran",
  "Iraq",
  "Ireland",
  "Israel",
  "Italy",
  "Jamaica",
  "Japan",
  "Jordan",
  "Kazakhstan",
  "Kenya",
  "Kiribati",
  "Korea, North",
  "Korea, South",
  "Kosovo",
  "Kuwait",
  "Kyrgyzstan",
  "Laos",
  "Latvia",
  "Lebanon",
  "Lesotho",
  "Liberia",
  "Libya",
  "Liechtenstein",
  "Lithuania",
  "Luxembourg",
  "Madagascar",
  "Malawi",
  "Malaysia",
  "Maldives",
  "Mali",
  "Malta",
  "Marshall Islands",
  "Mauritania",
  "Mauritius",
  "Mexico",
  "Micronesia",
  "Moldova",
  "Monaco",
  "Mongolia",
  "Montenegro",
  "Morocco",
  "Mozambique",
  "Myanmar",
  "Namibia",
  "Nauru",
  "Nepal",
  "Netherlands",
  "New Zealand",
  "Nicaragua",
  "Niger",
  "Nigeria",
  "North Macedonia",
  "Norway",
  "Oman",
  "Pakistan",
  "Palau",
  "Palestine",
  "Panama",
  "Papua New Guinea",
  "Paraguay",
  "Peru",
  "Philippines",
  "Poland",
  "Portugal",
  "Qatar",
  "Romania",
  "Russia",
  "Rwanda",
  "Saint Kitts and Nevis",
  "Saint Lucia",
  "Saint Vincent and the Grenadines",
  "Samoa",
  "San Marino",
  "Sao Tome and Principe",
  "Saudi Arabia",
  "Senegal",
  "Serbia",
  "Seychelles",
  "Sierra Leone",
  "Singapore",
  "Slovakia",
  "Slovenia",
  "Solomon Islands",
  "Somalia",
  "South Africa",
  "South Sudan",
  "Spain",
  "Sri Lanka",
  "Sudan",
  "Suriname",
  "Sweden",
  "Switzerland",
  "Syria",
  "Taiwan",
  "Tajikistan",
  "Tanzania",
  "Thailand",
  "Togo",
  "Tonga",
  "Trinidad and Tobago",
  "Tunisia",
  "Turkey",
  "Turkmenistan",
  "Tuvalu",
  "Uganda",
  "Ukraine",
  "United Arab Emirates",
  "United Kingdom",
  "United States",
  "Uruguay",
  "Uzbekistan",
  "Vanuatu",
  "Vatican City",
  "Venezuela",
  "Vietnam",
  "Yemen",
  "Zambia",
  "Zimbabwe",
];

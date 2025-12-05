import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  final Map<String, bool> airlineCheckboxes;
  final bool Refundable;
  final bool NonRefundable;
  final bool NonStop;
  final bool oneStop;
  final bool twoStop;
  final bool DepartisEarlySelected;
  final bool DepartisMorningSelected;
  final bool DepartisNoonSelected;
  final bool DepartisEveningSelected;
  final bool ArrivalisEarlySelected;
  final bool ArrivalisMorningSelected;
  final bool ArrivalisNoonSelected;
  final bool ArrivalisEveningSelected;
  final   add;

  FilterPage({
    required this.airlineCheckboxes,
    required this.Refundable,
    required this.NonRefundable,
    required this.NonStop,
    required this.oneStop,
    required this.twoStop,
    required this.DepartisEarlySelected,
    required this.DepartisMorningSelected,
    required this.DepartisNoonSelected,
    required this.DepartisEveningSelected,
    required this.ArrivalisEarlySelected,
    required this.ArrivalisMorningSelected,
    required this.ArrivalisNoonSelected,
    required this.ArrivalisEveningSelected,
    required this.add,
  }) ;

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  late Map<String, bool> airlineCheckboxes;

  bool isRefundable = false;
  bool isNonRefundable = false;
  bool isNonStop = false;
  bool isOneStop = false;
  bool isTwoPlusStops = false;
  int selectedCount = 0;
  int c=0;
  List<String> airlines = [
    'Air India (AI)',
    'Air India Express (IX)',
    'Biman Bangladesh Airlines (BG)',
    'British Airways (BA)',
    'Emirates Airlines (EK)',
    'Etihad Airways (EY)',
    'Gulf Air (GF)',
    'Indigo (6E)',
    'Lufthansa (LH)',
    'Oman Aviation (WY)',
    'Qatar Airways (QR)',
    'SalamAir (OV)',
    'Singapore Airlines (SQ)',
    'SpiceJet (SG)',
    'Sri Lankan Airlines (UL)',
    'Turkish Airlines (TK)',
    'Vistara (UK)',
  ];
  int RefundableselectedCount = 0;
  int airlinesselectedCount=0;
  int DepartCount=0;
  int ArrivalCount=0;
  void _updateSelectedCount() {
    RefundableselectedCount = 0; // Reset count

    // Count refundable options
    if (isRefundable==true) {
      RefundableselectedCount = 1; // Only count if Refundable is selected
    }else {  RefundableselectedCount = 0; }

    if (isNonRefundable==true) {
      RefundableselectedCount = 1; // Only count if Non-Refundable is selected
    }

    if (isNonStop==true) {
      selectedCount = 1; // Only count if Refundable is selected
    }
    else {
      selectedCount = 0;
    } if (isOneStop) {
      selectedCount = 1; // Only count if Non-Refundable is selected
    }
    if (isTwoPlusStops) {
      selectedCount = 1; // Only count if Non-Refundable is selected
    }


    if (isAirIndia==true) {airlinesselectedCount=1;}else
    {
      airlinesselectedCount=0;
    }

    if (isAirIndiaExpress==true) {airlinesselectedCount=1;}
    if (isBimanBangladesh==true) {airlinesselectedCount=1;}
    if (isBritishAirways==true) {airlinesselectedCount=1;}
    if (isEmirates==true) {airlinesselectedCount=1;}
    if (isEtihad==true){airlinesselectedCount=1;}
    if (isGulfAir==true) {airlinesselectedCount=1;}
    if (isIndigo==true){airlinesselectedCount=1;}
    if (isLufthansa==true){airlinesselectedCount=1;}
    if (isOmanAviation==true) {airlinesselectedCount=1;}
    if (isQatarAirways==true) {airlinesselectedCount=1;}
    if (isSalamAir==true) {airlinesselectedCount=1;}
    if (isSingaporeAirlines==true) {airlinesselectedCount=1;}
    if (isSpiceJet==true) {airlinesselectedCount=1;}
    if (isSriLankanAirlines==true) {airlinesselectedCount=1;}
    if (isTurkishAirlines==true) {airlinesselectedCount=1;}
    if (isVistara==true) {airlinesselectedCount=1;}

    if (DepartisEarlySelected==true) {
      DepartCount = 1; // Count if Early is selected
    }
    else
    {
      DepartCount=0;
    }
    if (DepartisMorningSelected==true) {
      DepartCount = 1; // Count if Morning is selected
    }

    if (DepartisNoonSelected==true) {
      DepartCount = 1; // Count if Noon is selected
    }

    if (DepartisEveningSelected==true) {
      DepartCount = 1; // Count if Evening is selected
    }



    if (ArrivaltisEarlySelected==true) {
      ArrivalCount = 1; // Count if Early is selected
    }
    else
    {
      ArrivalCount=0;
    }
    if (ArrivalisMorningSelected==true) {
      ArrivalCount = 1; // Count if Morning is selected
    }

    if (ArrivalisNoonSelected==true) {
      ArrivalCount = 1; // Count if Noon is selected
    }

    if (ArrivalisEveningSelected==true) {
      ArrivalCount = 1; // Count if Evening is selected
    }
    // Log the count for debugging
    print('Total selected options: $selectedCount');
    c=RefundableselectedCount+selectedCount+airlinesselectedCount+DepartCount+ArrivalCount;
    print('Total selected options: $c');
  }

// Map to hold the checkbox states
  bool isAirIndia = false;
  bool isAirIndiaExpress = false;
  bool isBimanBangladesh = false;
  bool isBritishAirways = false;
  bool isEmirates = false;
  bool isEtihad = false;
  bool isGulfAir = false;
  bool isIndigo = false;
  bool isLufthansa = false;
  bool isOmanAviation = false;
  bool isQatarAirways = false;
  bool isSalamAir = false;
  bool isSingaporeAirlines = false;
  bool isSpiceJet = false;
  bool isSriLankanAirlines = false;
  bool isTurkishAirlines = false;
  bool isVistara = false;

// Airline checkboxes
  bool DepartisEarlySelected = false;
  bool DepartisMorningSelected = false;
  bool DepartisNoonSelected = false;
  bool DepartisEveningSelected = false;

  bool ArrivaltisEarlySelected = false;
  bool ArrivalisMorningSelected = false;
  bool ArrivalisNoonSelected = false;
  bool ArrivalisEveningSelected = false;

// Departure and Arrival Time checkboxes
  bool isMorningDeparture = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    airlineCheckboxes = Map.from(widget.airlineCheckboxes);
    print("✅ Airline Checkboxes in Filter Page: $airlineCheckboxes");

    isRefundable=widget.Refundable;
    isNonRefundable=widget.NonRefundable;
    isNonStop=widget.NonStop;
    isOneStop=widget.oneStop;
    isTwoPlusStops=widget.twoStop;
    DepartisEarlySelected=widget.DepartisEarlySelected;
    DepartisMorningSelected=widget.DepartisMorningSelected;
    DepartisNoonSelected=widget.DepartisNoonSelected;
    DepartisEveningSelected=widget.DepartisEveningSelected;
    ArrivaltisEarlySelected=widget.ArrivalisEarlySelected;
    ArrivalisMorningSelected=widget.ArrivalisMorningSelected;
    ArrivalisNoonSelected=widget.ArrivalisNoonSelected;
    ArrivalisEveningSelected=widget.ArrivalisEveningSelected;


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 1,
        title: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 27,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),

            SizedBox(width: 1), // Set the desired width
            Text(
              "Filter Page",
              style: TextStyle(
                  color: Colors.white, fontFamily: "Montserrat",
                  fontSize: 18),
            ),
          ],
        ),
        actions: [
          Image.asset(
            'assets/images/lojolog.png',
            width: 100,
            height: 50,
          ),

        ],
        backgroundColor:Color(0xFF00ADEE),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
// Refundable Options
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Refundable', style: TextStyle(fontSize: 16)),
                  Switch(
                    value: isRefundable,
                    onChanged: (value) {
                      setState(() {
                        isRefundable = value;
                        _updateSelectedCount();
                      });
                    }, activeColor: Color(0xFF00ADEE),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Non-Refundable', style: TextStyle(fontSize: 16)),
                  Switch(
                    value: isNonRefundable,
                    onChanged: (value) {
                      setState(() {
                        isNonRefundable = value;
                        _updateSelectedCount();
                      });
                    }, activeColor: Color(0xFF00ADEE),
                  ),
                ],
              ),
              Divider(),
              SizedBox(height: 10,),
// Stops From Dubai
              Text('Stops From Dubai',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 10,),
              Column(
                mainAxisSize: MainAxisSize.min, // Minimizes vertical spacing within the Column
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.zero, // Removes any additional padding around each row
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Non-Stop',
                          style: TextStyle(fontSize: 16),
                        ),
                        Checkbox(
                          visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0), // Minimizes density
                          value: isNonStop,
                          onChanged: (value) {
                            setState(() {
                              isNonStop = value!;
                              _updateSelectedCount();
                            });
                          }, activeColor: Color(0xFF00ADEE),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 3,),
                  Padding(
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '1 Stop',
                          style: TextStyle(fontSize: 16),
                        ),
                        Checkbox(
                          visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                          value: isOneStop,
                          onChanged: (value) {
                            setState(() {
                              isOneStop = value!;
                              _updateSelectedCount();
                            });
                          }, activeColor: Color(0xFF00ADEE),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 3,),
                  Padding(
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '2+ Stops',
                          style: TextStyle(fontSize: 16),
                        ),
                        Checkbox(
                          visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                          value: isTwoPlusStops,
                          onChanged: (value) {
                            setState(() {
                              isTwoPlusStops = value!;
                              _updateSelectedCount();
                            });
                          }, activeColor: Color(0xFF00ADEE),
                        ),
                      ],
                    ),
                  ),
                ],
              ),




              Divider(),
              SizedBox(height: 10,),
// Airlines
              Text('Airlines',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 10,),
              Column(
                children: [
                  ...airlineCheckboxes.keys.map((airline) {
                    return CheckboxListTile(
                      title: Text(
                        airline,
                        style: TextStyle(color: Colors.black,fontSize: 16),
                      ),
                      value: airlineCheckboxes[airline],
                      activeColor: Color(0xFF00ADEE),
                      dense: true, // ✅ Reduces vertical space
                      contentPadding: EdgeInsets.symmetric(horizontal: 0), // ✅ Less left-right padding
                      onChanged: (bool? value) {
                        setState(() {
                          airlineCheckboxes[airline] = value ?? false;
                        });
                      },
                    );
                  }).toList(),
                ],
              ),




              Divider(),
              SizedBox(height: 10,),
// Departure Time
              Text('Departure Time',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Early (Before 6AM)',
                      style: TextStyle(fontSize: 16),
                    ),
                    Checkbox(
                      visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                      value: DepartisEarlySelected,
                      onChanged: (bool? value) {
                        setState(() {
                          DepartisEarlySelected = value!;
                          _updateSelectedCount();
                        });
                      }, activeColor: Color(0xFF00ADEE),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3,),
              Padding(
                padding: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Morning (6AM - 12PM)',
                      style: TextStyle(fontSize: 16),
                    ),
                    Checkbox(
                      visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                      value: DepartisMorningSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          DepartisMorningSelected = value!;
                          _updateSelectedCount();
                        });
                      }, activeColor: Color(0xFF00ADEE),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3,),
              Padding(
                padding: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Noon (12PM - 6PM)',
                      style: TextStyle(fontSize: 16),
                    ),
                    Checkbox(
                      visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                      value: DepartisNoonSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          DepartisNoonSelected = value!;
                          _updateSelectedCount();
                        });
                      }, activeColor: Color(0xFF00ADEE),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3,),
              Padding(
                padding: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Evening (After 6PM)',
                      style: TextStyle(fontSize: 16),
                    ),
                    Checkbox(
                      visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                      value: DepartisEveningSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          DepartisEveningSelected = value!;
                          _updateSelectedCount();
                        });
                      }, activeColor: Color(0xFF00ADEE),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Text(
                'Arrival Time',
                style: TextStyle(





                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10,),

              Divider(),
              Padding(
                padding: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Early (Before 6AM)',
                      style: TextStyle(fontSize: 16),
                    ),
                    Checkbox(
                      visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                      value: ArrivaltisEarlySelected,
                      onChanged: (bool? value) {
                        setState(() {
                          ArrivaltisEarlySelected = value ?? false;
                          _updateSelectedCount();
                        });
                      }, activeColor: Color(0xFF00ADEE),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3,),
              Padding(
                padding: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Morning (6AM - 12PM)',
                      style: TextStyle(fontSize: 16),
                    ),
                    Checkbox(
                      visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                      value: ArrivalisMorningSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          ArrivalisMorningSelected = value ?? false;
                          _updateSelectedCount();
                        });
                      }, activeColor: Color(0xFF00ADEE),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3,),
              Padding(
                padding: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Noon (12PM - 6PM)',
                      style: TextStyle(fontSize: 16),
                    ),
                    Checkbox(
                      visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                      value: ArrivalisNoonSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          ArrivalisNoonSelected = value ?? false;
                          _updateSelectedCount();
                        });
                      }, activeColor: Color(0xFF00ADEE),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3,),
              Padding(
                padding: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Evening (After 6PM)',
                      style: TextStyle(fontSize: 16),
                    ),
                    Checkbox(
                      visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                      value: ArrivalisEveningSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          ArrivalisEveningSelected = value ?? false;
                          _updateSelectedCount();
                        });
                      }, activeColor: Color(0xFF00ADEE),
                    ),
                  ],
                ),
              ),



              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'isRefundable': isRefundable ? 'Refundable' : '',
                    'isNonRefundable': isNonRefundable ? 'Non-Refundable' : '',
                    'isNonStop': isNonStop ? 'Yes' : 'No',
                    'isOneStop': isOneStop ? 'Yes' : 'No',
                    'isTwoPlusStops': isTwoPlusStops ? 'Yes' : 'No',
                    'isEarlyDeparture': DepartisEarlySelected ? 'Yes' : 'No',
                    'isMorningDeparture': DepartisMorningSelected ? 'Yes' : 'No',
                    'isNoonDeparture': DepartisNoonSelected ? 'Yes' : 'No',
                    'isEveningDeparture': DepartisEveningSelected ? 'Yes' : 'No',
                    'ArrivalIsEarlyDeparture': ArrivaltisEarlySelected ? 'Yes' : 'No',
                    'ArrivalIsMorningDeparture': ArrivalisMorningSelected ? 'Yes' : 'No',
                    'ArrivalIsNoonDeparture': ArrivalisNoonSelected ? 'Yes' : 'No',
                    'ArrivalIsEveningDeparture': ArrivalisEveningSelected ? 'Yes' : 'No',
                    'add': 'Edit',
                    'selectedCount': c,
                    'airlineCheckboxes': airlineCheckboxes,
                  });
                },
                child: Center(child: Text('Save')),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00ADEE),
                  minimumSize: Size(double.infinity, 50),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}

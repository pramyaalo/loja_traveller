import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  final bool Refundable;
  final bool NonRefundable;
  final bool NonStop;
  final bool oneStop;
  final bool twoStop;
  final bool AirIndia;
  final bool AirIndiaExpress;
  final bool isBimanBangladesh;
  final bool isBritishAirways;
  final bool isEmirates;
  final bool isEtihad;
  final bool isGulfAir;
  final bool isIndigo;
  final bool isLufthansa;
  final bool isOmanAviation;
  final bool isQatarAirways;
  final bool isSalamAir;
  final bool isSingaporeAirlines;
  final bool isSpiceJet;
  final bool isSriLankanAirlines;
  final bool isTurkishAirlines;
  final bool isVistara;
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

    required this.Refundable,
    required this.NonRefundable,
    required this.NonStop,
    required this.oneStop,
    required this.twoStop,
    required this.AirIndia,
    required this.AirIndiaExpress,
    required this.isBimanBangladesh,
    required this.isBritishAirways,
    required this.isEmirates,
    required this.isEtihad,
    required this.isGulfAir,
    required this.isIndigo,
    required this.isLufthansa,
    required this.isOmanAviation,
    required this.isQatarAirways,
    required this.isSalamAir,
    required this.isSingaporeAirlines,
    required this.isSpiceJet,
    required this.isSriLankanAirlines,
    required this.isTurkishAirlines,
    required this.isVistara,
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
// Switch and Checkbox states
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
    isRefundable=widget.Refundable;
    isNonRefundable=widget.NonRefundable;
    isNonStop=widget.NonStop;
    isOneStop=widget.oneStop;
    isTwoPlusStops=widget.twoStop;
    isAirIndia=widget.AirIndia;
    isAirIndiaExpress=widget.AirIndiaExpress;
    isBimanBangladesh=widget.isBimanBangladesh;
    isBritishAirways=widget.isBritishAirways;
    isEmirates=widget.isEmirates;
    isEtihad=widget.isEtihad;
    isGulfAir=widget.isGulfAir;
    isIndigo=widget.isIndigo;
    isLufthansa=widget.isLufthansa;
    isOmanAviation=widget.isOmanAviation;
    isQatarAirways=widget.isQatarAirways;
    isSalamAir=widget.isSalamAir;
    isSingaporeAirlines=widget.isSingaporeAirlines;
    isSpiceJet=widget.isSpiceJet;
    isSriLankanAirlines=widget.isSriLankanAirlines;
    isTurkishAirlines=widget.isTurkishAirlines;
    isVistara=widget.isVistara;
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
                color: Colors.black,
                size: 27,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),

            SizedBox(width: 1), // Set the desired width
            Text(
              "Filter",
              style: TextStyle(
                  color: Colors.black, fontFamily: "Montserrat", fontSize: 19),
            ),
          ],
        ),
        actions: [
          Image.asset(
            'assets/images/lojologo.png',
           width: 100,
              height: 50,
          ),
          SizedBox(
            width: 10,
          )
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
                    },
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
                    },
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
                        },
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
                        },
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
                        },
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.zero,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Air India',
                        style: TextStyle(fontSize: 16),
                      ),
                      Checkbox(
                        visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0), // Minimize density

                        value: isAirIndia,
                        onChanged: (value) {
                          setState(() {
                            isAirIndia = value!;
                            _updateSelectedCount();
                          });
                        },
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
                        'Air India Express',
                        style: TextStyle(fontSize: 16),
                      ),
                      Checkbox(
                        visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0), // Minimize density
                        value: isAirIndiaExpress,
                        onChanged: (value) {
                          setState(() {
                            isAirIndiaExpress = value!;
                            _updateSelectedCount();
                          });
                        },
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
                        'Biman Bangladesh Airlines',
                        style: TextStyle(fontSize: 16),
                      ),
                      Checkbox(
                        visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                        value: isBimanBangladesh,
                        onChanged: (value) {
                          setState(() {
                            isBimanBangladesh = value!;
                            _updateSelectedCount();
                          });
                        },
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
                        'British Airways',
                        style: TextStyle(fontSize: 16),
                      ),
                      Checkbox(
                        visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                        value: isBritishAirways,
                        onChanged: (value) {
                          setState(() {
                            isBritishAirways = value!;
                            _updateSelectedCount();
                          });
                        },
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
                        'Emirates Airlines',
                        style: TextStyle(fontSize: 16),
                      ),
                      Checkbox(
                        visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                        value: isEmirates,
                        onChanged: (value) {
                          setState(() {
                            isEmirates = value!;
                            _updateSelectedCount();
                          });
                        },
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
                        'Etihad Airways',
                        style: TextStyle(fontSize: 16),
                      ),
                      Checkbox(
                        visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                        value: isEtihad,
                        onChanged: (value) {
                          setState(() {
                            isEtihad = value!;
                            _updateSelectedCount();
                          });
                        },
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
                        'Gulf Air',
                        style: TextStyle(fontSize: 16),
                      ),
                      Checkbox(
                        visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                        value: isGulfAir,
                        onChanged: (value) {
                          setState(() {
                            isGulfAir = value!;
                            _updateSelectedCount();
                          });
                        },
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
                        'Indigo',
                        style: TextStyle(fontSize: 16),
                      ),
                      Checkbox(
                        visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                        value: isIndigo,
                        onChanged: (value) {
                          setState(() {
                            isIndigo = value!;
                            _updateSelectedCount();
                          });
                        },
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
                        'Lufthansa',
                        style: TextStyle(fontSize: 16),
                      ),
                      Checkbox(
                        visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                        value: isLufthansa,
                        onChanged: (value) {
                          setState(() {
                            isLufthansa = value!;
                            _updateSelectedCount();
                          });
                        },
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
                        'Oman Aviation',
                        style: TextStyle(fontSize: 16),
                      ),
                      Checkbox(
                        visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                        value: isOmanAviation,
                        onChanged: (value) {
                          setState(() {
                            isOmanAviation = value!;
                            _updateSelectedCount();
                          });
                        },
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
                        'Qatar Airways',
                        style: TextStyle(fontSize: 16),
                      ),
                      Checkbox(
                        visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                        value: isQatarAirways,
                        onChanged: (value) {
                          setState(() {
                            isQatarAirways = value!;
                            _updateSelectedCount();
                          });
                        },
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
                        'SalamAir',
                        style: TextStyle(fontSize: 16),
                      ),
                      Checkbox(
                        visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                        value: isSalamAir,
                        onChanged: (value) {
                          setState(() {
                            isSalamAir = value!;
                            _updateSelectedCount();
                          });
                        },
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
                        'Singapore Airlines',
                        style: TextStyle(fontSize: 16),
                      ),
                      Checkbox(
                        visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                        value: isSingaporeAirlines,
                        onChanged: (value) {
                          setState(() {
                            isSingaporeAirlines = value!;
                            _updateSelectedCount();
                          });
                        },
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
                        'SpiceJet',
                        style: TextStyle(fontSize: 16),
                      ),
                      Checkbox(
                        visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                        value: isSpiceJet,
                        onChanged: (value) {
                          setState(() {
                            isSpiceJet = value!;
                            _updateSelectedCount();
                          });
                        },
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
                        'Sri Lankan Airlines',
                        style: TextStyle(fontSize: 16),
                      ),
                      Checkbox(
                        visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                        value: isSriLankanAirlines,
                        onChanged: (value) {
                          setState(() {
                            isSriLankanAirlines = value!;
                            _updateSelectedCount();
                          });
                        },
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
                        'Turkish Airlines',
                        style: TextStyle(fontSize: 16),
                      ),
                      Checkbox(
                        visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                        value: isTurkishAirlines,
                        onChanged: (value) {
                          setState(() {
                            isTurkishAirlines = value!;
                            _updateSelectedCount();
                          });
                        },
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
                        'Vistara',
                        style: TextStyle(fontSize: 16),
                      ),
                      Checkbox(
                        visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                        value: isVistara,
                        onChanged: (value) {
                          setState(() {
                            isVistara = value!;
                            _updateSelectedCount();
                          });
                        },
                      ),
                    ],
                  ),
                ),

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
                      },
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
                      },
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
                      },
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
                      },
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
                      },
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
                      },
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
                      },
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
                      },
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
                    'isAirIndia': isAirIndia ? 'Yes' : 'No',
                    'isAirIndiaExpress': isAirIndiaExpress ? 'Yes' : 'No',
                    'isBimanBangladesh': isBimanBangladesh ? 'Yes' : 'No',
                    'isBritishAirways': isBritishAirways ? 'Yes' : 'No',
                    'isEmirates': isEmirates ? 'Yes' : 'No',
                    'isEtihad': isEtihad ? 'Yes' : 'No',
                    'isGulfAir': isGulfAir ? 'Yes' : 'No',
                    'isIndigo': isIndigo ? 'Yes' : 'No',
                    'isLufthansa': isLufthansa ? 'Yes' : 'No',
                    'isOmanAviation': isOmanAviation ? 'Yes' : 'No',
                    'isQatarAirways': isQatarAirways ? 'Yes' : 'No',
                    'isSalamAir': isSalamAir ? 'Yes' : 'No',
                    'isSingaporeAirlines': isSingaporeAirlines ? 'Yes' : 'No',
                    'isSpiceJet': isSpiceJet ? 'Yes' : 'No',
                    'isSriLankanAirlines': isSriLankanAirlines ? 'Yes' : 'No',
                    'isTurkishAirlines': isTurkishAirlines ? 'Yes' : 'No',
                    'isVistara': isVistara ? 'Yes' : 'No',
                    'isEarlyDeparture': DepartisEarlySelected ? 'Yes' : 'No',
                    // Early: Before 6 AM
                    'isMorningDeparture':
                    DepartisMorningSelected ? 'Yes' : 'No',
                    // Morning: 6 AM - 12 PM
                    'isNoonDeparture': DepartisNoonSelected ? 'Yes' : 'No',
                    // Noon: 12 PM - 6 PM
                    'isEveningDeparture':
                    DepartisEveningSelected ? 'Yes' : 'No',
                    // Evening: After 6 PM
                    'ArrivalIsEarlyDeparture':
                    ArrivaltisEarlySelected ? 'Yes' : 'No',
                    // Early: Before 6 AM
                    'ArrivalIsMorningDeparture':
                    ArrivalisMorningSelected ? 'Yes' : 'No',
                    // Morning: 6 AM - 12 PM
                    'ArrivalIsNoonDeparture':
                    ArrivalisNoonSelected ? 'Yes' : 'No',
                    // Noon: 12 PM - 6 PM
                    'ArrivalIsEveningDeparture':
                    ArrivalisEveningSelected ? 'Yes' : 'No',
                    // Evening: After 6 PM
                    'add': 'Edit',
                    'selectedCount':c,
                  });
                },
                child: Center(child: Text('Save')),
                style: ElevatedButton.styleFrom(backgroundColor:Color(0xFF00ADEE),
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

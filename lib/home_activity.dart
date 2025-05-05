import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:regi_sim_v2/developer_info.dart';

class HomeActivity extends StatefulWidget {
  const HomeActivity({super.key});

  @override
  State<HomeActivity> createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeActivity> {
  String selectedOperation = "home";
  TextEditingController r1c = TextEditingController();
  TextEditingController r2c = TextEditingController();

  List<String> executionList = [];

  void showStepswithDelay(List<String> steps) async {
    executionList.clear();
    setState(() {});
    for (var step in steps) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        executionList.add(step);
      });
    }
  }

  Widget changeHomeUi() {
    switch (selectedOperation) {
      case "home":
        return Column(children: [Text("Home")]);
      case "move":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text("Move")),
            Row(
              children: [
                Text("From Register 1 value: "),
                Expanded(
                  child: TextField(
                    controller: r1c,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text("To Register 2 value: "),
                Expanded(
                  child: TextField(
                    controller: r2c,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ],
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber
                ),
                onPressed: () {
                  
                  setState(() {
                    String value = r1c.text;
                    if (value.isEmpty) return;
              
                    String binary = int.parse(
                      value,
                    ).toRadixString(2).padLeft(8, '0');
              
                    showStepswithDelay([
                      "##STEP BY STEP PROCEDURE:\n",
                      "Step 1 -> Instruction Decode:\nCPU decodes the instruction: MOVE from R1 to R2\n",
                      "Step 2 -> Register Fetch:\nFetching value from Register 1 (R1)\n",
                      "Step 3 -> Binary Conversion:\nConverting decimal value ($value) to binary: $binary\n",
                      "Step 4 -> Load to Internal Buffer:\nLoading binary data into CPU buffer\n",
                      "Step 5 -> Data Bus Transfer:\nTransferring binary through data bus to destination\n",
                      "Step 6 -> Write to Register 2 (R2):\nStoring binary in Register 2 (R2)\n",
                      "Step 7 -> Confirmation:\nMove operation complete. R2 now holds: $binary\n",
                    ]);
                    r2c.text = r1c.text;
                  });
                },
                
                child: Text("Move"),
              ),
            ),
            SizedBox(height: 5),
            Column(
              children: [
                for (var step in executionList) Row(children: [Text(step)]),
              ],
            ),
          ],
        );
      case "increment":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text("Increment")),
            Row(
              children: [
                Text("Register 1 value: "),
                Expanded(
                  child: TextField(
                    controller: r1c,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text("Register 1 value after Increment: "),
                Expanded(
                  child: TextField(
                    controller: r2c,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ],
            ),

            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: () {
                  setState(() {
                    String value = r1c.text;
                    if (value.isEmpty) return;
                    int intValue = int.tryParse(value) ?? 0;
                    int incrementedValue = intValue + 1;
              
                    final binaryBefore = intValue
                        .toRadixString(2)
                        .padLeft(8, '0');
                    final binaryAfter = incrementedValue
                        .toRadixString(2)
                        .padLeft(8, '0');
              
                    showStepswithDelay([
                      "##STEP BY STEP PROCEDURE:\n",
                      "Step 1 -> Instruction Decode:\nCPU decodes the instruction: INCREMENT Register 1 (R1)\n",
                      "Step 2 -> Register Fetch:\nFetching value from Register 1 (R1)\n",
                      "Step 3 -> Binary Conversion:\nConverting decimal value ($intValue) to binary: $binaryBefore\n",
                      "Step 4 -> ALU Operation:\nPerforming increment operation: $binaryBefore + 1\n",
                      "Step 5 -> Result Computation:\nNew binary value: $binaryAfter\n",
                      "Step 6 -> Write Back:\nWriting updated binary to Register 1 (R1)\n",
                      "Step 7 -> Confirmation:\nIncrement complete. R1 now holds: $binaryAfter ($incrementedValue)\n",
                    ]);
                    r2c.text = incrementedValue.toString();
                  });
                },
                child: Text("Increament"),
              ),
            ),
            SizedBox(height: 5),
            Column(
              children: [
                for (var step in executionList) Row(children: [Text(step)]),
              ],
            ),
          ],
        );
      case "decrement":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text("Decrement")),
            Row(
              children: [
                Text("Register 1 value: "),
                Expanded(
                  child: TextField(
                    controller: r1c,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text("Register 1 value after Decrement: "),
                Expanded(
                  child: TextField(
                    controller: r2c,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ],
            ),

            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: () {
                  setState(() {
                    String value = r1c.text;
                    if (value.isEmpty) return;
                    int decimalValue = int.parse(value);
                    String binaryBefore = decimalValue
                        .toRadixString(2)
                        .padLeft(8, '0');
                    int decremented = decimalValue - 1;
                    String binaryAfter = decremented
                        .toRadixString(2)
                        .padLeft(8, '0');
                    String twosComplementOfOne =
                        '11111111'; // 2's complement of 1 in 8-bit
              
                    showStepswithDelay([
                      "##STEP BY STEP PROCEDURE:\n",
                      "Step 1 -> Instruction Decode:\nCPU decodes the instruction: DECREMENT R1\n",
                      "Step 2 -> Register Fetch:\nFetching value from Register 1 (R1): $decimalValue (Binary: $binaryBefore)\n",
                      "Step 3 -> Prepare Subtrahend:\nPreparing to subtract 1 (Binary: 00000001)\n",
                      "Step 4 -> Two's Complement Conversion:\nConverting 1 to two's complement: $twosComplementOfOne\n",
                      "Step 5 -> ALU Operation:\nPerforming binary addition: $binaryBefore + $twosComplementOfOne\n",
                      "Step 6 -> Result Calculation:\nResult after addition: $binaryAfter (Decimal: $decremented)\n",
                      "Step 7 -> Write Back:\nWriting result back to Register 1 (R1)\n",
                      "Step 8 -> Confirmation:\nDecrement complete. R1 now holds: $binaryAfter ($decremented)\n",
                    ]);
                    r2c.text = decremented.toString();
                  });
                },
                child: Text("Decrement"),
              ),
            ),
            SizedBox(height: 5),
            Column(
              children: [
                for (var step in executionList) Row(children: [Text(step)]),
              ],
            ),
          ],
        );

      case "clear":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text("Clear")),
            Row(
              children: [
                Text("Register 1 value: "),
                Expanded(
                  child: TextField(
                    controller: r1c,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text("Register 1 value after Clear: "),
                Expanded(
                  child: TextField(
                    controller: r2c,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ],
            ),

            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: () {
                  setState(() {
                    String value = r1c.text;
                    if (value.isEmpty) return;
                    String valueBefore = r1c.text;
                    String binaryBefore = int.tryParse(valueBefore)?.toRadixString(2).padLeft(8, '0') ?? '00000000';
                    String binaryAfter = '0';
                    showStepswithDelay([
                      "##STEP BY STEP PROCEDURE:\n",
                      "Step 1 -> Instruction Decode:\nCPU decodes the instruction: CLEAR R1\n",
                      "Step 2 -> Register Fetch:\nFetching value from R1: $valueBefore (binary: $binaryBefore)\n",
                      "Step 3 -> Clear Operation:\nResetting R1 to 0 → 00000000\n",
                      "Step 4 -> Update Register:\nRegister R1 is now cleared to: 0\n",
                      "Step 5 -> Confirmation:\nClear operation complete. R1 holds: 0\n",
                    ]);
                    r2c.text = binaryAfter.toString();
                  });
                },
                child: Text("Clear"),
              ),
            ),
            SizedBox(height: 5),
            Column(
              children: [
                for (var step in executionList) Row(children: [Text(step)]),
              ],
            ),
          ],
        



        );      
      
      case "leftShift":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text("Left Shift")),
            Row(
              children: [
                Text("Register 1 value: "),
                Expanded(
                  child: TextField(
                    controller: r1c,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text("Register 1 value after Left Shift: "),
                Expanded(
                  child: TextField(
                    controller: r2c,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ],
            ),

            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: () {
                  setState(() {
                    String value = r1c.text;
                    if (value.isEmpty) return;
                    int decimalValue = int.tryParse(value) ?? 0;
                    String binaryBefore = decimalValue.toRadixString(2).padLeft(8, '0');
              
                    int shiftedValue = (decimalValue << 1) & 0xFF; // Keep it 8-bit
                    String binaryAfter = shiftedValue.toRadixString(2).padLeft(8, '0');
                    showStepswithDelay([
                      "##STEP BY STEP PROCEDURE:\n",
                      "Step 1 -> Instruction Decode:\nCPU decodes the instruction: SHIFT LEFT on R1\n",
                      "Step 2 -> Register Fetch:\nFetching value from Register 1 (R1): $value\n",
                      "Step 3 -> Binary Conversion:\nConverting decimal $value to binary: $binaryBefore\n",
                      "Step 4 -> Bit Shift Operation:\nPerforming left shift: $binaryBefore → $binaryAfter\n",
                      "Step 5 -> Update Register:\nUpdating Register 1 (R1) \nwith shifted value: $binaryAfter ($shiftedValue)\n",
                      "Step 6 -> Confirmation:\nShift Left complete. R1 now holds: $shiftedValue\n",
                    ]);
                    r2c.text = shiftedValue.toString();
                  });
                },
                child: Text("Shift Left"),
              ),
            ),
            SizedBox(height: 5),
            Column(
              children: [
                for (var step in executionList) Row(children: [Text(step)]),
              ],
            ),
          ],
        



        );



      case "shiftRight":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text("Shift Right")),
            Row(
              children: [
                Text("Register 1 value: "),
                Expanded(
                  child: TextField(
                    controller: r1c,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                
              ],
            ),
            Row(
              children: [
                Text("Register 1 value after Right Shift: "),
                Expanded(
                  child: TextField(
                    controller: r2c,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ],
            ),

            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: () {
                  setState(() {
                    String value = r1c.text;
                    if (value.isEmpty) return;
                    int decimalValue = int.tryParse(value) ?? 0;
                    String binaryBefore = decimalValue.toRadixString(2).padLeft(8, '0');
              
                    int shiftedValue = decimalValue >> 1;
                    String binaryAfter = shiftedValue.toRadixString(2).padLeft(8, '0');
                    showStepswithDelay([
                      "##STEP BY STEP PROCEDURE:\n",
                      "Step 1 -> Instruction Decode:\nCPU decodes the instruction: SHIFT RIGHT on R1\n",
                      "Step 2 -> Register Fetch:\nFetching value from Register 1 (R1): $value\n",
                      "Step 3 -> Binary Conversion:\nConverting decimal $value to binary: $binaryBefore\n",
                      "Step 4 -> Bit Shift Operation:\nPerforming right shift: $binaryBefore → $binaryAfter\n",
                      "Step 5 -> Update Register:\nUpdating Register 1 (R1) \nwith shifted value: $binaryAfter ($shiftedValue)\n",
                      "Step 6 -> Confirmation:\nShift Right complete. R1 now holds: $shiftedValue\n",
                    ]);
                    r2c.text = shiftedValue.toString();
                  });
                },
                child: Text("Shift Right"),
              ),
            ),
            SizedBox(height: 5),
            Column(
              children: [
                for (var step in executionList) Row(children: [Text(step)]),
              ],
            ),
          ],
        



        );

      default:
        return ListView(children: [Text("This is default")]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text("Move"),
              leading: Icon(Icons.arrow_right_alt),
              onTap: () {
                r1c.clear();
                r2c.clear();
                showStepswithDelay(["Please Enter Register 1 value."]);
                setState(() {
                  selectedOperation = "move";
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Increment"),
              leading: Icon(Icons.text_increase),
              onTap: () {
                setState(() {
                  r1c.clear();
                  r2c.clear();
                  showStepswithDelay(["Please Enter Register 1 value."]);
                  selectedOperation = "increment";
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Decrement"),
              leading: Icon(Icons.text_decrease_outlined),
              onTap: () {
                setState(() {
                  r1c.clear();
                  r2c.clear();
                  showStepswithDelay(["Please Enter Register 1 value."]);
                  selectedOperation = "decrement";
                });
                Navigator.pop(context);
              },
            ),

            ListTile(
              title: Text("Clear"),
              leading: Icon(Icons.cleaning_services),
              onTap: () {
                setState(() {
                  r1c.clear();
                  r2c.clear();
                  showStepswithDelay(["Please Enter Register 1 value."]);
                  selectedOperation = "clear";
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Left Shift"),
              leading: Icon(Icons.rotate_left),
              onTap: () {
                setState(() {
                  r1c.clear();
                  r2c.clear();
                  showStepswithDelay(["Please Enter Register 1 value."]);
                  selectedOperation = "leftShift";
                });
                Navigator.pop(context);

              },
            ),
            ListTile(
              title: Text("Right Shift"),
              leading: Icon(Icons.rotate_right),
              onTap: () {
                setState(() {
                  r1c.clear();
                  r2c.clear();
                  showStepswithDelay(["Please Enter Register 1 value."]);
                  selectedOperation = "shiftRight";
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Add"),
              leading: Icon(Icons.add),
              onTap: () {},
            ),
            ListTile(
              title: Text("Subtract"),
              leading: Icon(Icons.remove),
              onTap: () {},
            ),
            ListTile(
              title: Text("Developer Info"),
              leading: Icon(Icons.info),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeveloperInfoScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      appBar: AppBar(title: Row(children: [
         Image.asset('assets/icon/RegiSimLogoDesign40into40.png',height:40,width: 40,fit:  BoxFit.contain,),
         SizedBox(width: 1,)
        ,Text("RegiSim"),
        SizedBox(width: 110,),
        Image.asset("assets/icon/Taj_logo.png",fit: BoxFit.contain,height: 20,width: 20,)
      
        
      ],
      ),
      
      ),
      body: ListView(
        children: [
          Text("Welcome to RegiSim:A Register Operations Simulator"),

          changeHomeUi(),

          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.tealAccent),
            onPressed: () {
              setState(() {
                selectedOperation = "home";
              });
            },
            child: Text("Home"),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'ToDoList'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool clickedButton = false;
  bool deletebutton = false;
  bool ischecked = false;
  var textController = TextEditingController();
  var listArr = [];
  bool checkboxcheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          // List section
          Expanded(
            child: ListView.separated(
              itemCount: listArr.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text('${index + 1}'),
                  title: Text(listArr[index]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            listArr.removeAt(index);
                          });
                        },
                        icon: Icon(Icons.remove),
                      ),
                      Checkbox(
                        value: checkboxcheck,
                        onChanged: (bool? newvalue) {
                          setState(() {
                            checkboxcheck = newvalue ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                  tileColor:
                      checkboxcheck
                          ? Colors.black.withOpacity(0.2)
                          : Colors.transparent,
                );
              },
              separatorBuilder: (context, index) {
                return Container(
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.yellowAccent, Colors.green],
                    ),
                  ),
                );
              },
            ),
          ),

          // Input container
          if (clickedButton)
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.deepPurple[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: 'Enter text',
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        String value = textController.text.trim();
                        if (value.isNotEmpty) {
                          listArr.add(value);
                          textController.clear();
                        }
                        clickedButton = false; // Hide container after adding
                      });
                    },
                    child: const Text(
                      'Add TodoList',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[300],
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                setState(() {
                  clickedButton = true; // Show input container
                });
              },
              icon: const Icon(Icons.add, color: Colors.black87),
            ),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                setState(() {
                  listArr.clear(); // Clear the list
                });
              },
              icon: const Icon(
                Icons.delete_forever_rounded,
                color: Colors.black87,
              ),
            ),
            label: 'Delete All',
          ),
        ],
        backgroundColor: Colors.deepPurple[200],
        iconSize: 40,
        selectedLabelStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

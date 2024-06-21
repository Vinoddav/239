import 'package:flutter/material.dart';
import 'package:nots/not_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var titleController = TextEditingController();

  var descController = TextEditingController();

  List<NoteModel> listNotes = [];
  List<String> listWeekDays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: listNotes.isNotEmpty? ListView.builder(
        itemCount: listNotes.length,
        itemBuilder: (_, index){
          var created = int.parse(listNotes[index].createAt);
          var time = DateTime.fromMillisecondsSinceEpoch(created);
          var createdAtDate = time.day;
          var createdAtweekday = time.weekday;
          var createdAtTime = '${time.hour}:${time.minute}';

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        child:Padding(
          padding: const EdgeInsets.all(8.0
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        ListTile(
          leading: Container(
            width: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.purple.withOpacity(0.1)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(listWeekDays[createdAtweekday-1]),
                Text(createdAtDate.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),

              ],
            ),
          ),
          title: Text(listNotes[index].title),
          subtitle: Text(createdAtTime),
        ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text((listNotes[index].desc)),
          )

        ],
        ),
        ),
        ),
    );
    }) :Center(child: Text('No Notes!!', style: TextStyle(fontSize: 21),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(context: context, builder: (_) {
            return Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.5,
              padding: EdgeInsets.all(11),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                        label: Text('Title'),
                        hintText: "Enter title hear...",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11)
                        )

                    ),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  TextField(
                    controller: descController,
                    maxLines: 7,
                    minLines: 4,
                    decoration: InputDecoration(
                      label: Text('Desc'),
                      hintText: "Enter desc hear...",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11)
                      ),
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(onPressed: (){
                        var newNote = NoteModel(
                            title: titleController.text,
                            desc: descController.text,
                            createAt: DateTime.now().millisecondsSinceEpoch.toString());
                        listNotes.add(newNote);
                        setState((){});

                        Navigator.pop(context);
                      }, child: Text('Add',)),

                      ElevatedButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: Text('Cancel'))
                    ],

                  )

                ],

              ),
            );
          },
          );
        },child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.green,

      ),
    );


            }
}

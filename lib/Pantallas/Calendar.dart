import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendario extends StatefulWidget {
  const Calendario({super.key, required this.title});

  final String title;

  @override
  State<Calendario> createState() => _CalendarioState();
}


class _CalendarioState extends State<Calendario> {

  FirebaseFirestore db =  FirebaseFirestore.instance;
  List<String> nombreEventos = [];
  List<Map<String, dynamic>> eventos=[];

  void _leerEventos() async{
    nombreEventos.clear();
    eventos.clear();
    QuerySnapshot consulta = await db.collection("eventos").get();
    for(DocumentSnapshot doc in consulta.docs){
      nombreEventos.add(doc.id);
      eventos.add(doc.data() as Map<String, dynamic>);

    }
    setState(() {});
  }

  void _escribeDatos(String nombreEvento) async{
    Map<String, dynamic> datos={
      "fechaInicio": _fechaAgendarI,
      "fechaFin": _fechaAgendarF,
      "color": _pickerColor.toARGB32(),
      "todoDia": _todoDia,
    };
    print("guardado en bd");
    await db.collection("eventos").doc(nombreEvento).set(datos);
  }

  void limpiarValores(){
    _nombreEvento.clear();
    _fechaAgendarI = null;
    _fechaAgendarF = null;
    _todoDia = false;
    _pickerColor = Colors.orange;
  }


  @override
  void initState() {
    super.initState();
    _leerEventos();
  }


  DateTime? _fechaAgendarI;
  DateTime? _fechaAgendarF;
  bool _todoDia=false;
  Color _pickerColor = Colors.orange;
  TextEditingController _nombreEvento = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.systemBlue,
        title: Text(widget.title),
      ),
      body: Container(
        child: SfCalendar(
          dataSource: MeetingDataSource(_getDataSource(nombreEventos,eventos)),
          view: CalendarView.month,
          monthViewSettings: MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            showAgenda: true,

          ),
        ),

      ),
      floatingActionButton: Column(
        verticalDirection: VerticalDirection.up,
        children: [
          FloatingActionButton(
            onPressed: (){

              showDialog(
                  context: context,
                  builder: (BuildContext context){
                    return AlertDialog(
                      title: Text(
                        "Agenda tu cita",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      content: Container(
                        height: 400,
                        child: Column(
                          children: [
                            TextField(
                                controller: _nombreEvento,
                              decoration: InputDecoration(
                                labelText:"Nombre del evento"
                              ),
                            ),
                            SizedBox(height: 30),
                            MaterialButton(onPressed: ()async{
                              final DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100)
                              );
                              if (pickedDate != null) {
                                _fechaAgendarI = pickedDate;

                                final TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );

                                if (pickedTime != null) {
                                  _fechaAgendarI = DateTime(
                                    _fechaAgendarI!.year,
                                    _fechaAgendarI!.month,
                                    _fechaAgendarI!.day,
                                    pickedTime.hour,
                                    pickedTime.minute,
                                  );

                                } else {

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Hora no seleccionada")),
                                  );
                                }
                              } else {

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Fecha no seleccinada")),
                                );
                              }

                            },
                            color: Theme.of(context).colorScheme.inversePrimary,
                              child: Text(
                                "Fecha Inicio",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            SizedBox(height: 20),
                            MaterialButton(onPressed: ()async{
                              final DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100)
                              );
                              if (pickedDate != null) {
                                _fechaAgendarF = pickedDate;

                                final TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );

                                if (pickedTime != null) {

                                  _fechaAgendarF = DateTime(
                                    _fechaAgendarF!.year,
                                    _fechaAgendarF!.month,
                                    _fechaAgendarF!.day,
                                    pickedTime.hour,
                                    pickedTime.minute,
                                  );

                                } else {

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Hora no seleccionada")),
                                  );
                                }
                              } else {

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Fecha no seleccionada")),
                                );
                              }

                            },
                              color: Theme.of(context).colorScheme.inversePrimary,
                              child: Text(
                                  "Fecha Fin",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            SizedBox(height: 20),
                            MaterialButton(

                                onPressed: (){
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context){

                                        return AlertDialog(
                                          title: const Text("Selecciona un color"),
                                          content: SingleChildScrollView(
                                            child: ColorPicker(
                                                pickerColor: _pickerColor,
                                                onColorChanged: (color){
                                                  setState(() {
                                                    _pickerColor=color;

                                                  });

                                                }
                                            ),

                                          ),
                                          actions: [
                                            TextButton(
                                              child: Text("Aceptar"),
                                              onPressed: () => Navigator.of(context).pop(),


                                            ),
                                          ],
                                        );
                                      }
                                  );

                            },
                              color: _pickerColor,
                              child: Text("Seleccionar color"),
                            ),
                            SizedBox(height: 20),
                            StatefulBuilder(
                              builder: (BuildContext context, StateSetter setDialogState) {
                                return SwitchListTile(
                                  title: Text("¿Todo el día?",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  value: _todoDia,
                                  onChanged: (value) {
                                    setDialogState(() {
                                      _todoDia = value;
                                    });
                                    print("ultimaMod:   $_todoDia");
                                  },
                                );
                              },
                            ),
                            SizedBox(height: 20),
                            MaterialButton(
                              onPressed: () {
                                String nombreEvento = _nombreEvento.text;
                                if(nombreEvento.isNotEmpty){
                                  if (_fechaAgendarI != null && _fechaAgendarF != null) {
                                    _escribeDatos(nombreEvento);
                                    _leerEventos();
                                    limpiarValores();
                                    Navigator.of(context).pop();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Debes seleccionar fechas de inicio y fin")),
                                    );
                                    limpiarValores();
                                    Navigator.of(context).pop();
                                  }
                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("No has escrito nombre de evento")),
                                  );
                                  limpiarValores();
                                  Navigator.of(context).pop();
                                }
                              },
                              color: Colors.green,
                              child: Text(
                                "Agendar Evento",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),

                          ],
                        ),
                      ),
                    );
                  }
              );
            },
            tooltip: 'Agendar cita',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}


List<Meeting> _getDataSource(List<String> nombreEventos, List<Map<String, dynamic>> eventos) {

  final List<Meeting> meetings = <Meeting>[];

  for(int i=0; i<nombreEventos.length; i++){

    DateTime fechaInicio, fechaFin;
    fechaInicio = (eventos[i]["fechaInicio"] as Timestamp).toDate();
    fechaFin = (eventos[i]["fechaFin"] as Timestamp).toDate();
    Color color = Color((eventos[i]["color"]));
    bool todoDia = eventos[i]["todoDia"] ?? false;

    meetings.add(
        Meeting(nombreEventos[i], fechaInicio, fechaFin, color, todoDia)
    );


  }
  return meetings;
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

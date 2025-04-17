import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulario',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ).copyWith(
          secondary: Colors.blueAccent,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade700,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            textStyle: TextStyle(fontSize: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveWith<Color?>((states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.blue;
            }
            return Colors.grey;
          }),
          trackColor: MaterialStateProperty.resolveWith<Color?>((states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.blueAccent;
            }
            return Colors.grey.shade400;
          }),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Formulario'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.blue.shade300],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade100, Colors.blue.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: FormularioCapturaDatos(),
        ),
      ),
    );
  }
}

class FormularioCapturaDatos extends StatefulWidget {
  const FormularioCapturaDatos({Key? key}) : super(key: key);

  @override
  _FormularioCapturaDatosState createState() => _FormularioCapturaDatosState();
}

class _FormularioCapturaDatosState extends State<FormularioCapturaDatos> {
  String nombre = '';
  bool trabaja = false;
  bool estudia = false;
  String genero = '';
  bool activarNotificaciones = false;
  double precioEstimado = 50.0;
  DateTime? fecha;
  TextEditingController fechaController = TextEditingController();
  TextEditingController horaController = TextEditingController();

  @override
  void dispose() {
    fechaController.dispose();
    horaController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fecha ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            hintColor: Colors.blueAccent,
            colorScheme: ColorScheme.light(primary: Colors.blue),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != fecha) {
      setState(() {
        fecha = picked;
        fechaController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            hintColor: Colors.blueAccent,
            colorScheme: ColorScheme.light(primary: Colors.blue),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        horaController.text = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Logo centrado y más pequeño
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  'assets/imagen/LOGO.png',
                  height: MediaQuery.of(context).size.width * 0.15,
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Instituto Universitario Jesús Obrero\nExtensión Barquisimeto',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                fontFamily: 'Montserrat',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),

            // Nombre
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nombre Completo',
                hintText: 'Ingrese su nombre',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.blue.shade300,
                  ),
                ),
                prefixIcon: Icon(Icons.person, color: Colors.blue),
              ),
              onChanged: (value) => setState(() => nombre = value),
            ),
            SizedBox(height: 16),

            // Trabaja y Estudia
            Text('Estado Actual',
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.blue.shade700)),
            CheckboxListTile(
              title: Text('Trabaja'),
              value: trabaja,
              onChanged: (bool? value) => setState(() => trabaja = value!),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              activeColor: Colors.blue,
            ),
            CheckboxListTile(
              title: Text('Estudia'),
              value: estudia,
              onChanged: (bool? value) => setState(() => estudia = value!),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              activeColor: Colors.blue,
            ),
            SizedBox(height: 16),

            // Género
            Text('Género',
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.blue.shade700)),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: Text('Masculino'),
                    value: 'Masculino',
                    groupValue: genero,
                    onChanged: (value) => setState(() => genero = value!),
                    activeColor: Colors.blue,
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: Text('Femenino'),
                    value: 'Femenino',
                    groupValue: genero,
                    onChanged: (value) => setState(() => genero = value!),
                    activeColor: Colors.blue,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Activar Notificaciones
            SwitchListTile(
              title: Text('Activar Notificaciones'),
              value: activarNotificaciones,
              onChanged: (bool value) =>
                  setState(() => activarNotificaciones = value),
              contentPadding: EdgeInsets.zero,
              activeColor: Colors.blue,
            ),
            SizedBox(height: 16),

            // Precio Estimado
            Text('Precio Estimado',
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.blue.shade700)),
            Slider(
              value: precioEstimado,
              min: 0,
              max: 100,
              divisions: 5,
              label: precioEstimado.round().toString(),
              onChanged: (double value) => setState(() => precioEstimado = value),
              activeColor: Colors.blue,
              thumbColor: Colors.blue,
            ),
            SizedBox(height: 16),

            // Fecha
            TextFormField(
              controller: fechaController,
              decoration: InputDecoration(
                labelText: 'Fecha de Nacimiento',
                hintText: 'Seleccione la fecha',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.blue.shade300,
                  ),
                ),
                prefixIcon: Icon(Icons.calendar_today, color: Colors.blue),
              ),
              readOnly: true,
              onTap: () => _selectDate(context),
            ),
            SizedBox(height: 16),

            // Hora
            TextFormField(
              controller: horaController,
              decoration: InputDecoration(
                labelText: 'Hora de Preferencia',
                hintText: 'Seleccione la hora',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.blue.shade300,
                  ),
                ),
                prefixIcon: Icon(Icons.access_time, color: Colors.blue),
              ),
              readOnly: true,
              onTap: () => _selectTime(context),
            ),
            SizedBox(height: 32),

            // Botón de Guardar (ElevatedButton)
            ElevatedButton(
              onPressed: () {
                // Implementa la lógica para guardar los datos
                print('Guardando datos...');
                print(
                    'Nombre: $nombre, Trabaja: $trabaja, Estudia: $estudia, Género: $genero, Notificaciones: $activarNotificaciones, Precio: $precioEstimado, Fecha: $fecha, Hora: ${horaController.text}');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Datos enviados para su procesamiento!')),
                );
              },
              child: Text('Guardar Datos', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}



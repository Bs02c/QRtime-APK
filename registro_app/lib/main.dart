import 'package:flutter/material.dart';

void main() {
  runApp(const RegistrosApp());
}

class RegistrosApp extends StatelessWidget {
  const RegistrosApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QRtime Registros',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2c3e50), // Color principal
          primary: const Color(0xFF2c3e50), // Color principal
          secondary: const Color(0xFF3498db), // Color secundario para botones
        ),
      ),
      home: const RegistrosPage(),
    );
  }
}

class RegistrosPage extends StatefulWidget {
  const RegistrosPage({Key? key}) : super(key: key);

  @override
  _RegistrosPageState createState() => _RegistrosPageState();
}

class _RegistrosPageState extends State<RegistrosPage> {
  final TextEditingController _idController = TextEditingController();
  String? _selectedTurno;
  String _message = '';

  final List<Map<String, String>> _registros = [];

  void _marcarEntrada() {
    setState(() {
      _message = '';
    });
    if (_idController.text.isEmpty || _selectedTurno == null) {
      setState(() {
        _message = 'Debes ingresar todos los datos';
      });
    } else {
      setState(() {
        _registros.add({
          'id': _idController.text,
          'turno': _selectedTurno!,
          'tipo': 'Entrada',
          'fecha': DateTime.now().toString().substring(0, 10),
          'hora': DateTime.now().toString().substring(11, 16),
        });
        _message = 'Registro de entrada exitoso';
        _idController.clear();
        _selectedTurno = null;
      });
    }
  }

  void _marcarSalida() {
    setState(() {
      _message = '';
    });
    if (_idController.text.isEmpty || _selectedTurno == null) {
      setState(() {
        _message = 'Debes ingresar todos los datos';
      });
    } else {
      setState(() {
        _registros.add({
          'id': _idController.text,
          'turno': _selectedTurno!,
          'tipo': 'Salida',
          'fecha': DateTime.now().toString().substring(0, 10),
          'hora': DateTime.now().toString().substring(11, 16),
        });
        _message = 'Registro de salida exitoso';
        _idController.clear();
        _selectedTurno = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registrar Asistencia Manualmente',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF2c3e50),
              ),
              child: Text(
                'Menú Principal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Empleados'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt),
              title: const Text('Registros'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.analytics),
              title: const Text('Reportes'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Registrar Asistencia Manualmente',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2c3e50),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text('ID:', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8.0),
                  TextField(
                    controller: _idController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Introduce tu ID de Empleado',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text('Turno:', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _selectedTurno,
                        hint: const Text('Selecciona un turno'),
                        items: const [
                          DropdownMenuItem(
                            value: '1',
                            child: Text('Turno 1 (6am-2pm)'),
                          ),
                          DropdownMenuItem(
                            value: '2',
                            child: Text('Turno 2 (2pm-10pm)'),
                          ),
                          DropdownMenuItem(
                            value: '3',
                            child: Text('Turno 3 (10pm-6am)'),
                          ),
                        ],
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedTurno = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _marcarEntrada,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3498db),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text('Marcar Entrada'),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _marcarSalida,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3498db),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text('Marcar Salida'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: Text(
                      _message,
                      style: TextStyle(
                        color: _message.contains('exitoso') ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Historial de Registros',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2c3e50),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  _registros.isEmpty
                      ? const Text('Aún no hay registros.')
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _registros.length,
                          itemBuilder: (context, index) {
                            final registro = _registros[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: ListTile(
                                leading: Icon(
                                  registro['tipo'] == 'Entrada' ? Icons.login : Icons.logout,
                                  color: registro['tipo'] == 'Entrada' ? Colors.green : Colors.red,
                                ),
                                title: Text('ID Empleado: ${registro['id']} - Turno: ${registro['turno']}'),
                                subtitle: Text('${registro['fecha']} a las ${registro['hora']}'),
                                trailing: Text(registro['tipo']!),
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
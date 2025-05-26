import 'package:flutter/material.dart';
import 'details.dart';

class FlightForm extends StatefulWidget {
  const FlightForm({Key? key}) : super(key: key);

  @override
  State<FlightForm> createState() => _FlightFormState();
}

class _FlightFormState extends State<FlightForm> {
  // Controladores para todos los campos
  final _flightIdController = TextEditingController();
  final _employeeIdController = TextEditingController();
  final _flightNumberController = TextEditingController();
  final _originController = TextEditingController();
  final _destinationController = TextEditingController();
  final _departureTimeController = TextEditingController();
  final _arrivalTimeController = TextEditingController();
  final _statusController = TextEditingController();

  final List<Map<String, String>> _flights = [];

  void _removeFlight(int index) {
    setState(() {
      _flights.removeAt(index);
    });
  }

  @override
  void dispose() {
    _flightIdController.dispose();
    _employeeIdController.dispose();
    _flightNumberController.dispose();
    _originController.dispose();
    _destinationController.dispose();
    _departureTimeController.dispose();
    _arrivalTimeController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Vuelos'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildFlightIdField(),
            const SizedBox(height: 15),
            _buildEmployeeIdField(),
            const SizedBox(height: 15),
            _buildFlightNumberField(),
            const SizedBox(height: 15),
            _buildOriginField(),
            const SizedBox(height: 15),
            _buildDestinationField(),
            const SizedBox(height: 15),
            _buildDepartureTimeField(context),
            const SizedBox(height: 15),
            _buildArrivalTimeField(context),
            const SizedBox(height: 15),
            _buildStatusField(),
            const SizedBox(height: 25),
            _buildSubmitButton(context),
            const SizedBox(height: 20),
            _buildViewFlightsButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFlightIdField() {
    return TextFormField(
      controller: _flightIdController,
      decoration: const InputDecoration(
        labelText: 'ID Vuelo',
        prefixIcon: Icon(Icons.confirmation_number),
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.text,
    );
  }

  Widget _buildEmployeeIdField() {
    return TextFormField(
      controller: _employeeIdController,
      decoration: const InputDecoration(
        labelText: 'ID Empleado',
        prefixIcon: Icon(Icons.badge),
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.text,
    );
  }

  Widget _buildFlightNumberField() {
    return TextFormField(
      controller: _flightNumberController,
      decoration: const InputDecoration(
        labelText: 'Número de Vuelo',
        prefixIcon: Icon(Icons.airplanemode_active),
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.text,
    );
  }

  Widget _buildOriginField() {
    return TextFormField(
      controller: _originController,
      decoration: const InputDecoration(
        labelText: 'Origen',
        prefixIcon: Icon(Icons.flight_takeoff),
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDestinationField() {
    return TextFormField(
      controller: _destinationController,
      decoration: const InputDecoration(
        labelText: 'Destino',
        prefixIcon: Icon(Icons.flight_land),
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDepartureTimeField(BuildContext context) {
    return TextFormField(
      controller: _departureTimeController,
      decoration: const InputDecoration(
        labelText: 'Hora de Salida',
        prefixIcon: Icon(Icons.access_time),
        border: OutlineInputBorder(),
      ),
      onTap: () async {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (time != null) {
          _departureTimeController.text = time.format(context);
        }
      },
    );
  }

  Widget _buildArrivalTimeField(BuildContext context) {
    return TextFormField(
      controller: _arrivalTimeController,
      decoration: const InputDecoration(
        labelText: 'Hora de Llegada',
        prefixIcon: Icon(Icons.access_time),
        border: OutlineInputBorder(),
      ),
      onTap: () async {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (time != null) {
          _arrivalTimeController.text = time.format(context);
        }
      },
    );
  }

  Widget _buildStatusField() {
    return TextFormField(
      controller: _statusController,
      decoration: const InputDecoration(
        labelText: 'Estado',
        prefixIcon: Icon(Icons.info),
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
      ),
      onPressed: () {
        if (_validateFields()) {
          setState(() {
            _flights.add({
              'id_vuelo': _flightIdController.text,
              'id_empleado': _employeeIdController.text,
              'numero_vuelo': _flightNumberController.text,
              'origen': _originController.text,
              'destino': _destinationController.text,
              'hora_salida': _departureTimeController.text,
              'hora_llegada': _arrivalTimeController.text,
              'estado': _statusController.text,
            });
          });

          _clearFields();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Vuelo registrado correctamente')),
          );
        }
      },
      child: const Text('REGISTRAR VUELO'),
    );
  }

  Widget _buildViewFlightsButton(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FlightDetails(
              flights: _flights,
              onFlightDeleted: _removeFlight,
            ),
          ),
        );
      },
      child: Text('VER VUELOS (${_flights.length})'),
    );
  }

  bool _validateFields() {
    if (_flightIdController.text.isEmpty ||
        _employeeIdController.text.isEmpty ||
        _flightNumberController.text.isEmpty ||
        _originController.text.isEmpty ||
        _destinationController.text.isEmpty ||
        _departureTimeController.text.isEmpty ||
        _arrivalTimeController.text.isEmpty ||
        _statusController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Todos los campos son requeridos')),
      );
      return false;
    }
    return true;
  }

  void _clearFields() {
    _flightIdController.clear();
    _employeeIdController.clear();
    _flightNumberController.clear();
    _originController.clear();
    _destinationController.clear();
    _departureTimeController.clear();
    _arrivalTimeController.clear();
    _statusController.clear();
  }
}
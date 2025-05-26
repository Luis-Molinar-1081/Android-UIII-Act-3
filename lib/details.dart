import 'package:flutter/material.dart';

class FlightDetails extends StatelessWidget {
  const FlightDetails({
    Key? key,
    required this.flights,
    required this.onFlightDeleted,
  }) : super(key: key);

  final List<Map<String, String>> flights;
  final Function(int) onFlightDeleted;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Vuelos'),
        centerTitle: true,
      ),
      body: flights.isEmpty
          ? const Center(child: Text('No hay vuelos registrados'))
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: flights.length,
              itemBuilder: (context, index) {
                final flight = flights[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(
                      'Vuelo #${flight['numero_vuelo']}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ID: ${flight['id_vuelo']}'),
                        Text('Origen: ${flight['origen']} → Destino: ${flight['destino']}'),
                        Text('Salida: ${flight['hora_salida']} - Llegada: ${flight['hora_llegada']}'),
                        Text('Estado: ${flight['estado']}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        onFlightDeleted(index);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Vuelo ${flight['numero_vuelo']} eliminado')),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
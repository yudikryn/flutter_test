import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/common/state_enum.dart';
import 'package:test_flutter/data/models/send_request.dart';
import 'package:test_flutter/domain/entities/city.dart';
import 'package:test_flutter/presentation/provider/my_notifier.dart';
import 'package:test_flutter/presentation/provider/user_notifier.dart';

class AddPage extends StatefulWidget {
  static const ROUTE_NAME = '/add-page';

  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  City? selectedCity;

  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<MyNotifier>(context, listen: false).fetchCity());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Name'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _nameController,
            ),
            const SizedBox(height: 16),
            dropDownCity(),
            const SizedBox(height: 16),
            const Text('Address'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _addressController,
            ),
            const SizedBox(height: 24),
            MaterialButton(
              color: Theme.of(context).primaryColor,
              textTheme: ButtonTextTheme.primary,
              height: 40.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text('Send'),
              onPressed: () async {
                if (_nameController.text.isEmpty ||
                    _addressController.text.isEmpty ||
                    selectedCity == null) {
                  if (mounted) {
                    final scaffoldMessenger = ScaffoldMessenger.of(context);

                    scaffoldMessenger.showSnackBar(
                      const SnackBar(
                        content: Text('Form cannot empty!'),
                      ),
                    );
                  }
                  return;
                }

                await Provider.of<MyNotifier>(context, listen: false)
                    .postData(SendRequest(
                  name: _nameController.text,
                  city: selectedCity!,
                  address: _addressController.text,
                ));

                final readProvider =
                    Provider.of<MyNotifier>(context, listen: false);

                switch (readProvider.sendState) {
                  case RequestState.Loading:
                    const Center(
                      child: CircularProgressIndicator(),
                    );
                    break;
                  case RequestState.Error:
                    const Text('Failure');
                    break;
                  case RequestState.Loaded:
                    if (mounted) {
                      final scaffoldMessenger = ScaffoldMessenger.of(context);

                      final snackBar = SnackBar(
                        content: Text(readProvider.send.message),
                      );

                      scaffoldMessenger.showSnackBar(snackBar);
                      
                      Provider.of<UserNotifier>(context, listen: false).refresh();
                      Navigator.pop(context);
                    }
                    break;
                  default:
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget dropDownCity() {
    return Consumer<MyNotifier>(builder: (context, data, child) {
      final state = data.cityState;
      if (state == RequestState.Loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state == RequestState.Loaded) {
        return DropdownButton<City>(
          value: selectedCity,
          iconSize: 24,
          hint: const Text('Select a city'),
          onChanged: (City? newValue) {
            setState(() {
              selectedCity = newValue;
            });
          },
          items: data.listCity.map((City city) {
            return DropdownMenuItem<City>(
              value: city,
              child: Text(city.city),
            );
          }).toList(),
        );
      } else {
        return const Text('Failed');
      }
    });
  }
}

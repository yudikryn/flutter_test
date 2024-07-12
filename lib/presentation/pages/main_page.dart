import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/common/state_enum.dart';
import 'package:test_flutter/domain/entities/user.dart';
import 'package:test_flutter/presentation/pages/add_page.dart';
import 'package:test_flutter/presentation/provider/user_notifier.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<UserNotifier>(context, listen: false).fetchListUser());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List User'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(
            context,
            AddPage.ROUTE_NAME,
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Consumer<UserNotifier>(builder: (context, data, child) {
              final state = data.userState;
              if (state == RequestState.Loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.Loaded) {
                if (data.userList.isEmpty) {
                  return const Center(
                    child: Text('Empty Data'),
                  );
                } else {
                  return Expanded(
                    child: listView(data.userList),
                  );
                }
              } else {
                return const Text('Failed');
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget listView(List<User> listUser) {
    return ListView.builder(
      itemCount: listUser.length,
      itemBuilder: (context, index) {
        final user = listUser[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name),
                const SizedBox(height: 8),
                Text(user.city),
                const SizedBox(height: 8),
                Text(user.address),
              ],
            ),
          ),
        );
      },
    );
  }
}

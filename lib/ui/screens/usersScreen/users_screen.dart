import 'package:flutter/material.dart';
import 'package:motoon_api_example/models/card_info.dart';
import 'package:motoon_api_example/models/user.dart';
import 'package:motoon_api_example/repos/users.dart';
import 'package:motoon_api_example/ui/components/info_card.dart';

class UsersScreen extends StatefulWidget {
  String? token;
  UsersScreen({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late Future<List<User>> _usersListFuture;
  @override
  void initState() {
    super.initState();

    _usersListFuture = Users().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("User token is ${widget.token}"),
        title: const Text('Users List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.visibility),
            tooltip: 'Show user token',
            onPressed: () {
              var snackBar =
                  SnackBar(content: Text('User token is ${widget.token}'));
              // Step 3
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        ],
      ),
      body: Container(child: _getUsersGrid()),
    );
  }

  Widget _getUsersGrid() {
    return FutureBuilder<List<User>>(
        future: _usersListFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            User users = snapshot.data![0];
            return GridView.count(
              crossAxisCount: 2,
              children: List.generate(
                snapshot.data!.length,
                (index) => InfoCardComponent(
                  cardInfo: CardInfo(
                    title: "${users.data![index].name}",
                    subtitle: 'snapshot.data![index].email',
                    image: 'https://www.w3schools.com/howto/img_avatar.png',
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

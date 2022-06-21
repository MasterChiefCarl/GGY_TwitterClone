import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomSearchPeople extends SearchDelegate {
  final CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection("users");

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:  _firebaseFirestore.where('username', isEqualTo: query.toLowerCase()).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data!.size > 0) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.orange,
          ));
        } else {
          //fetch data HERE
          print(snapshot.data);
          return ListView(children: [
            ...snapshot.data!.docs
                .where((element) =>
                    element['username']
                        .toString()
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                .map((data) {
              final String username = data.get('username');
              final String image = data['image'];
              final String handlename = data.get('handle') ?? '';

              return ListTile(
                title: Text(username),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(image),
                ),
                subtitle: Text(handlename),
              );
            })
          ]);
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(child: Text('Search Anything Here!'));
  }
}

class CustomSearchHandle extends SearchDelegate {
  List<String> allData = [
    'Handle1',
    'Handle2',
    'Handle3',
    'Handle4',
    'Handle5'
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var item in allData) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var item in allData) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }
}

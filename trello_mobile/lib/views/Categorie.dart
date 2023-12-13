import 'package:flutter/material.dart';
import 'package:trello_mobile/domains/categories.dart';
import 'package:trello_mobile/repository/categories_repository.dart';

class CategorieScreen extends StatelessWidget {
  final String title;
  final CategoriesRepositoryImpl repository;
  const CategorieScreen(
      {super.key, required this.title, required this.repository});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: FutureBuilder<List<Categories>>(
          future: repository.get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Show a loading indicator while data is being fetched
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return TaskListWidget(taskList: snapshot.data!);
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return AddCategoryModal(repository: repository);
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class TaskListWidget extends StatelessWidget {
  final List<Categories> taskList;

  TaskListWidget({required this.taskList});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Text('Nom')),
        DataColumn(label: Text('Descriptions')),
      ],
      rows: taskList.map((task) {
        return DataRow(cells: [
          DataCell(Text(task.name)),
          DataCell(Text(task.description)),
        ]);
      }).toList(),
    );
  }
}

class AddCategoryModal extends StatelessWidget {
  final CategoriesRepositoryImpl repository;

  AddCategoryModal({required this.repository});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ajouter une Nouvelle Catégorie',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Nom'),
            // Implement text field logic
          ),
          TextFormField(
            controller: descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
            // Implement text field logic
          ),
          ElevatedButton(
            onPressed: () {
              // Perform category creation logic here
              Categories category = Categories(
                name: nameController.text,
                description: descriptionController.text,
              );
              repository.create(category);
              Navigator.pop(context); // Close the modal
            },
            child: Text('Enregistrer'),
          ),
        ],
      ),
    );
  }
}

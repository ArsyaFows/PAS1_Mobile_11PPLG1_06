// views/PostView.dart

import 'sportController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../bottomNav/bottom_nav.dart'; 
import '../../database/db_helper.dart'; 

class SportView extends StatelessWidget {
  final SportController sportController = Get.put(SportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sport List'),
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        if (sportController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (sportController.postList.isEmpty) {
          return Center(child: Text('No Data Available'));
        }
        return ListView.builder(
          itemCount: sportController.postList.length,
          itemBuilder: (context, index) {
            final post = sportController.postList[index];
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: ListTile(
                title: Text(post.strTeam),
                leading: post.strTeamBadge != null 
                  ? Image.network(
                      post.strTeamBadge!,
                      width: 50,
                      height: 50,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.sports_soccer);
                      },
                    )
                  : Icon(Icons.sports_soccer),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.favorite_border),
                      onPressed: () async {
                        try {
                          bool exists = await DatabaseHelper.instance.checkFavorite(post.idTeam);
                          
                          if (!exists) {
                            await DatabaseHelper.instance.addFavorite(post);
                            Get.snackbar(
                              'Success',
                              '${post.strTeam} added to favorites',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                              duration: Duration(seconds: 2),
                            );
                          } else {
                            Get.snackbar(
                              'Info',
                              '${post.strTeam} is already in favorites',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.blue,
                              colorText: Colors.white,
                              duration: Duration(seconds: 2),
                            );
                          }
                        } catch (error) {
                          print('Error adding to favorites:');
                          Get.snackbar(
                            'Error',
                            'Failed to add to favorites:',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                            duration: Duration(seconds: 2),
                          );
                        }
                      },
                    ),
                    
                  ],
                ),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: BottomNavBar(), // Tambahkan bottom navigation bar
    );
  }
}

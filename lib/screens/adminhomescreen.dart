import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchyou/widgets/fieldwidget.dart';
import 'package:watchyou/widgets/kroundbutton.dart';

import '../firebaseCrud/firebaseCreateReadUpdateDelete.dart';
import '../firebaseCrud/firebaseJasonData.dart';
import '../widgets/collectionNamesAdminPanel.dart';
import '../widgets/kdrawer.dart';
import 'LoginPage.dart';

class AdminControlHomeScreen extends StatefulWidget {
  const AdminControlHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminControlHomeScreen> createState() => _AdminControlHomeScreenState();
}

TextEditingController collectionNameController = TextEditingController();
String title = 'Admin Panel Movie';

class _AdminControlHomeScreenState extends State<AdminControlHomeScreen> {
  TextEditingController movieNameController = TextEditingController();
  TextEditingController imdbRatingController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController maturityController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController videoUrlController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  TextEditingController movieUrlLinkController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    collectionNameController.dispose();
    movieNameController.dispose();
    imageUrlController.dispose();
    imdbRatingController.dispose();
    descriptionController.dispose();
    maturityController.dispose();
    durationController.dispose();
    videoUrlController.dispose();
    movieUrlLinkController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        drawer: const KDrawer(),
        appBar: AppBar(
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.person))],
          elevation: 0,
          backgroundColor: primaryColor,
          centerTitle: true,
          title: Text(title),
        ),
        body: Material(
          color: Colors.grey.shade800,
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Collections Names',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const collectionNames(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: KFieldWidget(
                      controller: collectionNameController,
                      hintText: 'CollectionName',
                      labelText: 'CollectionName'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: KFieldWidget(
                      controller: movieNameController,
                      hintText: 'MovieName',
                      labelText: 'MovieName'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: KFieldWidget(
                      controller: imdbRatingController,
                      hintText: '0.0',
                      labelText: 'Imdb Rating'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: KFieldWidget(
                      controller: descriptionController,
                      hintText: 'description',
                      labelText: 'description',
                      maxLength: 160),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: KFieldWidget(
                      controller: maturityController,
                      hintText: 'Maturity',
                      labelText: 'Maturity'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: KFieldWidget(
                      controller: durationController,
                      hintText: 'Duration',
                      labelText: 'Duration'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: KFieldWidget(
                      controller: genreController,
                      hintText: 'Genre',
                      labelText: 'Genre'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: KFieldWidget(
                      controller: videoUrlController,
                      hintText: ' Trailer Video Url',
                      labelText: 'Trailer Video Url'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: KFieldWidget(
                      controller: imageUrlController,
                      hintText: 'Image Url',
                      labelText: 'Image Url'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: KFieldWidget(
                      controller: movieUrlLinkController,
                      hintText: 'movie',
                      labelText: 'Movie Link Url'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70.0),
                  child: KElevatedButton(
                      maximumSize: const Size(80, 58),
                      minimumSize: const Size(80, 58),
                      title: "Create",
                      color: Colors.blueGrey,
                      opacity: 0,
                      size: 17,
                      onTap: () async {
                        await FirebaseCreateReadUpdateDelete.create(
                            FirebaseJasonData(
                              maturity: maturityController.text,
                              duration: durationController.text,
                              description: descriptionController.text,
                              genre: genreController.text,
                              videoUrl: videoUrlController.text,
                              imageUrl: imageUrlController.text,
                              movieName: movieNameController.text,
                              imdbRating: imdbRatingController.text,
                              movieUrl: movieUrlLinkController.text,
                            ),
                            context,
                            collectionNameController.text);
                      },
                      borderRadius: 50,
                      textColor: Colors.white.withOpacity(0.8)),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}

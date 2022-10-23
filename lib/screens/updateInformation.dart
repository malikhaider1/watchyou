import 'package:flutter/material.dart';

import '../firebaseCrud/firebaseCreateReadUpdateDelete.dart';
import '../firebaseCrud/firebaseJasonData.dart';
import '../widgets/fieldwidget.dart';
import '../widgets/kroundbutton.dart';

class UpdateInformation extends StatefulWidget {
  const UpdateInformation({Key? key, required this.jasonData})
      : super(key: key);
  final FirebaseJasonData jasonData;

  @override
  State<UpdateInformation> createState() => _UpdateInformationState();
}

class _UpdateInformationState extends State<UpdateInformation> {
  TextEditingController? movieNameController;
  TextEditingController? imdbRatingController;
  TextEditingController? descriptionController;
  TextEditingController? maturityController;
  TextEditingController? durationController;
  TextEditingController? videoUrlController;
  TextEditingController? imageUrlController;
  TextEditingController? genreController;
  TextEditingController? movieUrlController;

  @override
  void initState() {
    movieNameController =
        TextEditingController(text: widget.jasonData.movieName);
    imdbRatingController =
        TextEditingController(text: widget.jasonData.imdbRating);
    descriptionController =
        TextEditingController(text: widget.jasonData.description);
    maturityController = TextEditingController(text: widget.jasonData.maturity);
    durationController = TextEditingController(text: widget.jasonData.duration);
    videoUrlController = TextEditingController(text: widget.jasonData.videoUrl);
    imageUrlController = TextEditingController(text: widget.jasonData.imageUrl);
    genreController = TextEditingController(text: widget.jasonData.genre);
    movieUrlController = TextEditingController(text: widget.jasonData.movieUrl);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    movieNameController!.dispose();
    imageUrlController!.dispose();
    imdbRatingController!.dispose();
    descriptionController!.dispose();
    maturityController!.dispose();
    durationController!.dispose();
    videoUrlController!.dispose();
    genreController!.dispose();
    movieUrlController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: KFieldWidget(
                controller: movieNameController!,
                hintText: 'MovieName',
                labelText: 'MovieName'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: KFieldWidget(
                controller: imdbRatingController!,
                hintText: '0.0',
                labelText: 'Imdb Rating'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: KFieldWidget(
                controller: descriptionController!,
                hintText: 'description',
                labelText: 'description',
                maxLength: 160),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: KFieldWidget(
                controller: maturityController!,
                hintText: 'Maturity',
                labelText: 'Maturity'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: KFieldWidget(
                controller: durationController!,
                hintText: 'Duration',
                labelText: 'Duration'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: KFieldWidget(
                controller: genreController!,
                hintText: 'Genre',
                labelText: 'Genre'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: KFieldWidget(
                controller: videoUrlController!,
                hintText: 'Video Url',
                labelText: 'Video Url'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: KFieldWidget(
                controller: imageUrlController!,
                hintText: 'Image Url',
                labelText: 'Image Url'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: KFieldWidget(
                controller: movieUrlController!,
                hintText: 'Movie Video Url',
                labelText: 'Movie Video Url'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70.0),
            child: KElevatedButton(
                maximumSize: const Size(80, 58),
                minimumSize: const Size(80, 58),
                title: "update",
                color: Colors.blueGrey,
                opacity: 0,
                size: 17,
                ontap: () async {
                  await FirebaseCreateReadUpdateDelete.update(
                          FirebaseJasonData(
                            id: widget.jasonData.id,
                            maturity: maturityController!.text,
                            duration: durationController!.text,
                            description: descriptionController!.text,
                            genre: genreController!.text,
                            videoUrl: videoUrlController!.text,
                            imageUrl: imageUrlController!.text,
                            movieName: movieNameController!.text,
                            imdbRating: imdbRatingController!.text,
                            movieUrl: movieUrlController!.text,
                          ),
                          context,
                          "action")
                      .then((value) => Navigator.pop(context));
                },
                borderRadius: 50,
                textColor: Colors.white.withOpacity(0.8)),
          ),
        ],
      ),
    ));
  }
}
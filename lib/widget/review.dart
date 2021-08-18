import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/review_model.dart';
import 'package:restaurant_app/provider/detail_provider.dart';

class ReviewDialog extends StatelessWidget {
  ReviewDialog({required this.provider, required this.id});
  final DetailProvider provider;
  final String id;

  @override
  Widget build(BuildContext context) {
    var _nameController = TextEditingController();
    var _reviewController = TextEditingController();
    var _formKey = GlobalKey<FormState>();

    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      title: Text(
        "Tambahkan Review",
        style: Theme.of(context).textTheme.subtitle2,
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              validator: (value) {
                if (value!.isEmpty) return "Nama tidak boleh kosong!";
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Nama',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _reviewController,
              validator: (value) {
                if (value!.isEmpty) return "Review tidak boleh kosong!";
                return null;
              },
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Review',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  primary: Colors.black,
                  backgroundColor: Colors.transparent,
                  textStyle: Theme.of(context).textTheme.subtitle1,
                ),
                child: Text("Batal")),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  CustomerReview review = CustomerReview(
                    id: id,
                    name: _nameController.text,
                    review: _reviewController.text,
                    date: '',
                  );
                  provider.postReview(review).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Berhasil ditambahkan"),
                      backgroundColor: Colors.green,
                      elevation: 10,
                      behavior: SnackBarBehavior.floating,
                    ));
                    Navigator.pop(context);
                  });
                }
              },
              style: TextButton.styleFrom(
                primary: Colors.black,
                backgroundColor: Colors.amber,
                textStyle: Theme.of(context).textTheme.subtitle1,
              ),
              child: Text("Tambah"),
            ),
            SizedBox(
              width: 15,
            )
          ],
        ),
      ],
    );
  }
}

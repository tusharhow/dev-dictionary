import 'package:dev_dictionary/constants.dart';
import 'package:dev_dictionary/models/word_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/word_controller.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wordController = Get.put(WordController());
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
      body: GetBuilder<WordController>(builder: (cont) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 60),
              Center(
                child: Text(
                  'Dev Dictionary',
                  style: GoogleFonts.oswald(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Programmer\'s Dictionary',
                  style: GoogleFonts.openSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 70),
              SizedBox(
                height: 70,
                width: 400,
                child: TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: bgColor2,
                    hintText: 'Enter your word',
                    hintStyle: const TextStyle(color: Colors.white54),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    suffixIcon: searchController.text.isNotEmpty
                        ? IconButton(
                            icon:
                                const Icon(Icons.clear, color: Colors.white54),
                            onPressed: () {
                              searchController.clear();
                              cont.getData('');
                              cont.update();
                            },
                          )
                        : null,
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      cont.getData(value);
                    } else {
                      cont.filteredTitle = null;
                    }
                  },
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 150.0),
              searchController.text.isEmpty
                  ? const Text(
                      'উপরে কিছু লিখুন, আমরা খুঁজে দিচ্ছি',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 20,
                      ),
                    )
                  : cont.filteredTitle == null
                      ? const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white54,
                            ),
                          ),
                        )
                      : ListView(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                height: 65,
                                decoration: BoxDecoration(
                                  color: bgColor2,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Text(
                                    cont.filteredTitle,
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                height: 210,
                                decoration: BoxDecoration(
                                  color: bgColor2,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      cont.filteredDescription,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
            ],
          ),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mind_gen/controller/image_gen_controller.dart';
import 'package:mind_gen/utility/constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textController = TextEditingController();
  String imageUrl = "";
  bool isLoaded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.history))],
          title: const Text("MindGen", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25))),
      body: GetBuilder<ImageGeneratorController>(builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                if (controller.loading) const Center(child: CircularProgressIndicator()),
                isLoaded
                    ? Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                        child: Image.network(imageUrl, fit: BoxFit.contain))
                    : const Text("Type command to generate AI image"),
                const SizedBox(height: 30),
                if (isLoaded)
                  Row(children: [
                    Expanded(
                        flex: 2,
                        child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.download_for_offline_rounded),
                            label: const Text("Download"))),
                    const SizedBox(width: 10),
                    Expanded(
                        child: ElevatedButton.icon(
                            onPressed: () {}, icon: const Icon(Icons.share), label: const Text("Share"))),
                  ])
              ])),
              TextField(
                  maxLines: 3,
                  controller: textController,
                  decoration: const InputDecoration(hintText: "Type any commands...")),
              const SizedBox(height: 16),
              Visibility(
                visible: controller.loading == false,
                replacement: const Center(child: CircularProgressIndicator()),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: getImageUrl, child: const Text("Generate")),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      }),
    );
  }

  Future<void> getImageUrl() async {
    if (textController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(backgroundColor: kOrange, content: Text("please fill the command")));
    } else {
      final response = await Get.find<ImageGeneratorController>().generateImage(textController.text.trim());
      if (response) {
        imageUrl = Get.find<ImageGeneratorController>().imageUrl;
        isLoaded = true;
        setState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(backgroundColor: kOrange, content: Text("Failed to generate image")));
      }
    }
  }
}

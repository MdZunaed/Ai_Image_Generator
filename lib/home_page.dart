import 'package:flutter/material.dart';
import 'package:mind_gen/api_service.dart';
import 'package:mind_gen/constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var sizes = ["small", "medium", "large"];
  var values = ["256x256", "512x512", "1024x1024"];
  String? dropValue;
  var textController = TextEditingController();
  var image = "";
  var isLoded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.history))
          ],
          title: const Text("MINDGEN",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25))),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: kOrange, width: 2)),
              child: TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Type any commands...")),
            ),
            const SizedBox(height: 10),
            Row(children: [
              Expanded(
                flex: 1,
                child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                  dropdownColor: kOrange,
                  borderRadius: BorderRadius.circular(8),
                  value: dropValue,
                  hint: const Text("select size"),
                  items: List.generate(
                      sizes.length,
                      (index) => DropdownMenuItem(
                          value: values[index], child: Text(sizes[index]))),
                  onChanged: (value) {
                    setState(() {
                      dropValue = value.toString();
                    });
                  },
                )),
              ),
              const SizedBox(width: 10),
              Expanded(
                  flex: 1,
                  child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoded = false;
                        });
                        if (textController.text.isNotEmpty &&
                            dropValue!.isNotEmpty) {
                          image = await Api.generateImage(
                              textController.text, dropValue!);
                          setState(() {
                            isLoded = true;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              backgroundColor: kOrange,
                              content: Text(
                                  "please fill the command and select the size")));
                        }
                      },
                      child: const Text("Generate")))
            ]),
            const SizedBox(height: 30),
            isLoded
                ? Container(
                    clipBehavior: Clip.antiAlias,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: Image.network(image, fit: BoxFit.contain))
                : Column(
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(height: 20),
                      Text("Type command and select size to Generate image")
                    ],
                  ),
            const SizedBox(height: 30),
            (isLoded == true)
                ? Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(
                                  Icons.download_for_offline_rounded),
                              label: const Text("Download"))),
                      const SizedBox(width: 10),
                      Expanded(
                          child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.share),
                              label: const Text("Share"))),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:recipe/model/RecipeMode.dart';
import 'package:recipe/model/data/recipe_storage.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:tabler_icons/tabler_icons.dart';

class RecipeDetails extends StatefulWidget {
  final RecipeModel recipeModel;

  RecipeDetails({required this.recipeModel});

  @override
  _RecipeDetailsState createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  late RecipeStorage recipeStorage;
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    recipeStorage = RecipeStorage();
    checkIfSaved();
  }

  Future<void> checkIfSaved() async {
    List<String> savedRecipeIds = await recipeStorage.getSavedRecipes();
    setState(() {
      isSaved = savedRecipeIds.contains(widget.recipeModel.id);
    });
  }

  Future<void> toggleSaveRecipe() async {
    if (isSaved) {
      await recipeStorage.removeRecipe(widget.recipeModel.id);
    } else {
      await recipeStorage.saveRecipe(widget.recipeModel);
    }
    setState(() {
      isSaved = !isSaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SlidingUpPanel(
        parallaxEnabled: true,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12),
        minHeight: (size.height / 2),
        maxHeight: size.height / 1.2,
        panel: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 5,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(widget.recipeModel.title),
              SizedBox(height: 10),
              Text(widget.recipeModel.writer),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(TablerIcons.heart, color: Colors.red),
                  SizedBox(width: 5),
                  Text("198"),
                  SizedBox(width: 10),
                  Icon(TablerIcons.timeline),
                  SizedBox(width: 4),
                  Text('${widget.recipeModel.cookingTime}\''),
                  SizedBox(width: 20),
                  Container(width: 2, height: 30, color: Colors.black),
                  SizedBox(width: 10),
                  Text('${widget.recipeModel.servings} Servings'),
                ],
              ),
              SizedBox(height: 10),
              Divider(color: Colors.black.withOpacity(0.3)),
              Expanded(
                child: DefaultTabController(
                  length: 3,
                  initialIndex: 0,
                  child: Column(
                    children: [
                      TabBar(
                        isScrollable: true,
                        indicatorColor: Colors.red,
                        tabs: [
                          Tab(text: "Ingredients".toUpperCase()),
                          Tab(text: "Preparation".toUpperCase()),
                          Tab(text: "Reviews".toUpperCase()),
                        ],
                        labelColor: Colors.black,
                        indicator: DotIndicator(
                          color: Colors.black,
                          distanceFromCenter: 16,
                          radius: 3,
                          paintingStyle: PaintingStyle.fill,
                        ),
                        unselectedLabelColor: Colors.black.withOpacity(0.3),
                        labelStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        labelPadding: EdgeInsets.symmetric(horizontal: 32),
                      ),
                      Divider(color: Colors.black.withOpacity(0.3)),
                      Expanded(
                        child: TabBarView(
                          children: [
                            Ingredients(recipeModel: widget.recipeModel),
                            Container(child: Text("Preparation Tab")),
                            Container(child: Text("Reviews Tab")),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Hero(
                    tag: widget.recipeModel.imgPath,
                    child: ClipRRect(
                      child: Image(
                        width: double.infinity,
                        height: (size.height / 2) + 50,
                        fit: BoxFit.cover,
                        image: AssetImage(widget.recipeModel.imgPath),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 40,
                right: 20,
                child: InkWell(
                  onTap: toggleSaveRecipe,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        isSaved
                            ? TablerIcons.bookmark
                            : TablerIcons.bookmark_off,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 20,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    TablerIcons.arrow_back,
                    color: Colors.white,
                    size: 38,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Ingredients extends StatelessWidget {
  const Ingredients({required this.recipeModel});

  final RecipeModel recipeModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: recipeModel.ingredients.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Text('⚫️ ' + recipeModel.ingredients[index]),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(color: Colors.black.withOpacity(0.3));
              },
            ),
          ],
        ),
      ),
    );
  }
}

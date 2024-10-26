import 'package:flutter/material.dart';
import 'package:recipe/model/RecipeMode.dart';
import 'package:recipe/model/data/recipe_storage.dart';
import 'package:recipe/screen/RecipeDetails.dart';
import 'package:tabler_icons/tabler_icons.dart';

class NewRecipe extends StatelessWidget {
  final RecipeStorage recipeStorage = RecipeStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: RecipeModel.demoRecipe.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetails(
                            recipeModel: RecipeModel.demoRecipe[index],
                          ),
                        ),
                      ),
                      child: RecipeCard(
                        recipeModel: RecipeModel.demoRecipe[index],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecipeCard extends StatefulWidget {
  final RecipeModel recipeModel;

  RecipeCard({required this.recipeModel});

  @override
  _RecipeCardState createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  bool loved = false;
  bool saved = false;

  Future<void> checkIfSaved() async {
    List<String> savedRecipeIds = await RecipeStorage().getSavedRecipes();
    setState(() {
      saved = savedRecipeIds.contains(widget.recipeModel.id);
    });
  }

  @override
  void initState() {
    super.initState();
    checkIfSaved();
  }

  Future<void> toggleSaveRecipe() async {
    if (saved) {
      await RecipeStorage().removeRecipe(widget.recipeModel.id);
    } else {
      await RecipeStorage().saveRecipe(widget.recipeModel);
    }
    setState(() {
      saved = !saved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Hero(
                  tag: widget.recipeModel.imgPath,
                  child: Image(
                    height: 320,
                    width: 320,
                    fit: BoxFit.cover,
                    image: AssetImage(widget.recipeModel.imgPath),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 40,
              child: InkWell(
                onTap: toggleSaveRecipe,
                child: Icon(
                  saved ? TablerIcons.bookmark : TablerIcons.bookmark_off,
                  color: Colors.white,
                  size: 38,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.recipeModel.title,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.recipeModel.writer,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(width: 20),
                    Icon(
                      TablerIcons.timeline,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      widget.recipeModel.cookingTime.toString() + '\'',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        setState(() {
                          loved = !loved;
                        });
                      },
                      child: Icon(
                        TablerIcons.heart,
                        color: loved ? Colors.red : Colors.black,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

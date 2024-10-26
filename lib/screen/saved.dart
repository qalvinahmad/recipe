import 'package:flutter/material.dart';
import 'package:recipe/model/RecipeMode.dart';
import 'package:recipe/model/data/recipe_storage.dart';
import 'package:recipe/screen/NewRecipe.dart';
import 'package:recipe/screen/RecipeDetails.dart';

class SavedRecipesPage extends StatefulWidget {
  @override
  _SavedRecipesPageState createState() => _SavedRecipesPageState();
}

class _SavedRecipesPageState extends State<SavedRecipesPage> {
  List<RecipeModel> savedRecipes = [];
  RecipeStorage recipeStorage = RecipeStorage();

  @override
  void initState() {
    super.initState();
    loadSavedRecipes();
  }

  Future<void> loadSavedRecipes() async {
    List<String> savedRecipeIds = await recipeStorage.getSavedRecipes();
    savedRecipes = await getRecipesByIds(savedRecipeIds);
    setState(() {});
  }

  Future<List<RecipeModel>> getRecipesByIds(List<String> ids) async {
    return RecipeModel.demoRecipe
        .where((recipe) => ids.contains(recipe.id))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: savedRecipes.isEmpty
          ? Center(child: Text("No data saved"))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ListView.builder(
                itemCount: savedRecipes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetails(
                              recipeModel: savedRecipes[index],
                            ),
                          ),
                        );
                      },
                      child: RecipeCard(
                        recipeModel: savedRecipes[index],
                        // Tidak perlu menambahkan parameter saved di sini
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

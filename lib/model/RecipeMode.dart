class RecipeModel {
  final String id;
  String title, writer, description;
  int cookingTime;
  int servings;
  List<String> ingredients = [];
  String imgPath;
  RecipeModel({
    required this.id,
    required this.title,
    required this.writer,
    required this.description,
    required this.cookingTime,
    required this.servings,
    required this.imgPath,
    required this.ingredients,
  });
  static List<RecipeModel> demoRecipe = [
    RecipeModel(
      id: '1',
      title: 'Gruyère, Bacon, and Spinach Scrambled Eggs',
      writer: "Rosie Nguyen",
      description:
          'A touch of Dijon mustard, salty bacon, melty cheese, and a handful of greens seriously upgrades scrambled eggs, without too much effort!',
      cookingTime: 10,
      servings: 4,
      imgPath: 'assets/images/img1.jpg',
      ingredients: [
        '8 large eggs',
        '1 tsp. Dijon mustard',
        'Kosher salt and pepper',
        '1 tbsp. olive oil or unsalted butter',
        '2 slices thick-cut bacon, cooked and broken into pieces',
        '2 c. spinach, torn',
        '2 oz. Gruyère cheese, shredded',
      ],
    ),
    RecipeModel(
      id: '2',
      title: 'Classic Omelet and Greens ',
      writer: "Zachary Chen",
      description:
          'Sneak some spinach into your morning meal for a boost of nutrients to start your day off right.',
      cookingTime: 10,
      servings: 4,
      imgPath: 'assets/images/img2.jpg',
      ingredients: [
        '8 large eggs',
        '1 tsp. Dijon mustard',
        'Kosher salt and pepper',
        '1 tbsp. olive oil or unsalted butter',
        '2 slices thick-cut bacon, cooked and broken into pieces',
        '2 c. spinach, torn',
        '2 oz. Gruyère cheese, shredded',
      ],
    ),
    RecipeModel(
      id: '3',
      title: 'Sheet Pan Sausage and Egg Breakfast Bake ',
      writer: "Imran Sefat",
      description:
          'A hearty breakfast that easily feeds a family of four, all on one sheet pan? Yes, please.',
      cookingTime: 10,
      servings: 4,
      imgPath: 'assets/images/img3.jpg',
      ingredients: [
        '8 large eggs',
        '1 tsp. Dijon mustard',
        'Kosher salt and pepper',
        '1 tbsp. olive oil or unsalted butter',
        '2 slices thick-cut bacon, cooked and broken into pieces',
        '2 c. spinach, torn',
        '2 oz. Gruyère cheese, shredded',
      ],
    ),
    RecipeModel(
      id: '4',
      title: 'Shakshuka',
      writer: "Sophia Bella",
      description:
          'Just wait til you break this one out at the breakfast table: sweet tomatoes, runny yolks, and plenty of toasted bread for dipping.',
      cookingTime: 10,
      servings: 4,
      imgPath: 'assets/images/img4.jpg',
      ingredients: [
        '8 large eggs',
        '1 tsp. Dijon mustard',
        'Kosher salt and pepper',
        '1 tbsp. olive oil or unsalted butter',
        '2 slices thick-cut bacon, cooked and broken into pieces',
        '2 c. spinach, torn',
        '2 oz. Gruyère cheese, shredded',
      ],
    ),
  ];
}

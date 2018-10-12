require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
      @chef = Chef.create!(chefname: "Rico", email: "rico@gmail.com")
      @recipe = Recipe.create(name: "veg saute",description: "greate veg saute with sandwiches", chef: @chef)
      @recipe2 = @chef.recipes.build(name:"chicken saute", description: "greate chick saute")
      @recipe2.save
  end

test "should get recipes index" do
  get recipes_path
  assert_response :success
end

test "should get Recipes listings" do
  get recipes_path
  assert_template 'recipes/index'
  assert_match @recipe.name, response.body
  assert_match @recipe2.name, response.body

end

end

require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.create!(chefname: "surenth", email: "surenth@gmail.com")
    @recipe = @chef.recipes.build(name: "Vegetable",description: "Great vegetable recipe")
  end

  test "Recipe should be valid" do
    assert @recipe.valid?
  end

  test "Recipe without chef is invalid" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end

  test "name should be Present" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end

  test "Description should be present" do
    @recipe.description = " "
    assert_not @recipe.valid?
  end

  test "Description should not be less than 5 Characters" do
    @recipe.description = "a" * 3
    assert_not @recipe.valid?
  end

  test "description should not be more than 5 Characters" do
    @recipe.description = "a" * 501
    assert_not @recipe.valid?
  end
end

require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.new(chefname: "Surenth", email: "surenth@gmail.com")
  end

  test "should be valid" do
    assert @chef.valid?
  end
  test "Name should be Present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end

  test "Name should be less than 30 Characters" do
    @chef.chefname = "a" * 31
    assert_not @chef.valid?
  end

  test "Email should be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end

  test "Email should be not be too long" do
    @chef.email = "a" * 245 + "@example.com"
    assert_not @chef.valid?
  end

  test "Email should accept correct format" do
    valid_emails = %w[user@example.com SURENTH@gmail.com vignesh.last@yahoo.ca john+smith@co.uk.org]
    valid_emails.each do |valids|
      @chef.email = valids
      assert @chef.valid?, "#{valids.inspect} should be valid"
    end
  end

  test "Should reject invalid emails" do
    invalid_emails = %w[surenth@example surenth@gmail,com surenth.name@gmail. joe+foo.com]
    invalid_emails.each do |invalids|
      @chef.email = invalids
      assert_not @chef.valid?, "#{invalids.inspect} should be valid"
    end
  end

  test "Email should be unique and case insensitive" do
    duplicate_chef = @chef.dup
    duplicate_chef.email = @chef.email.upcase
    @chef.save
    assert_not duplicate_chef.valid?
  end

  test "Email should be loweer case before hitting db" do
    mixed_email = "john@EXAMPLE.com"
    @chef.email=mixed_email
    @chef.save
    assert_equal mixed_email.downcase, @chef.reload.email
  end

end

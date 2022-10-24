require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    context "given all fields" do
      it "saves the product" do
        @category = Category.new(:name => "flowers")
        @category.save
        @category = Category.all
        fields = {:name => "Daisy", :price => "$5.99", :quantity =>"12", :category_id => "46"}
        @product = Product.new(fields)
        @product.save
        @product =  Product.all[0]["name"]
        expect(@product).to include("Daisy")
      end
    end
    context "not given name" do
      it "should not save" do
        @category = Category.new(:name => "flowers")
        @category.save
        @category = Category.all
        fields = {:price => "$5.99", :quantity =>"12", :category_id => "47"}
        @product = Product.new(fields)
        @product.save
        message = "Name can't be blank"
        expect(@product.errors.full_messages[0]).to eq(message) 
      end
    end
    context "not given price" do
      it "should not save" do
        @category = Category.new(:name => "flowers")
        @category.save
        @category = Category.all
        fields = {:name => "Daisy", :quantity =>"12", :category_id => "48"}
        @product = Product.new(fields)
        @product.save
        message = "Price can't be blank"
        expect(@product.errors.full_messages[2]).to eq(message) 
      end
    end
    context "not given quantity" do
      it "should not save" do
        @category = Category.new(:name => "flowers")
        @category.save
        @category = Category.all
        fields = {:name => "Daisy", :price => "$5.99", :category_id => "49"}
        @product = Product.new(fields)
        @product.save
        message = "Quantity can't be blank"
        expect(@product.errors.full_messages[0]).to eq(message) 
      end
    end
    context "not given category" do
      it "should not save" do
        fields = {:name => "Daisy", :price => "$5.99", :quantity =>"12"}
        @product = Product.new(fields)
        @product.save
        message = "Category can't be blank"
        expect(@product.errors.full_messages[1]).to eq(message) 
      end
    end
  end
end

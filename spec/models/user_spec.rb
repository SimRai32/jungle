require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    context 'given all fields' do
      it "will create a user" do
        fields = {:first_name => "Sim", :last_name => "Rai", :email => "d@g.com", :password => "password", :password_confirmation => "password"}
        @user = User.new(fields)
        @user.save
        @user = User.all[0]
        expect(@user.first_name).to eq("Sim")
      end
    end
    
    context 'given unmatching passwords' do
      it "will not create a user" do
        fields = {:first_name => "Sim", :last_name => "Rai", :email => "d@g.com", :password => "password", :password_confirmation => "pssword"}
        @user = User.new(fields)
        @user.save
        message = ["Password confirmation doesn't match Password"]
        expect(@user.errors.full_messages).to eq(message)
      end
    end

    context 'when missing a password' do
      it "will not create a user" do
        fields = {:first_name => "Sim", :last_name => "Rai", :email => "d@g.com", :password_confirmation => "password"}
        @user = User.new(fields)
        @user.save
        message = "Password can't be blank"
        expect(@user.errors.full_messages[0]).to eq(message)
      end
    end

    context 'when missing a password' do
      it "will not create a user" do
        fields = {:first_name => "Sim", :last_name => "Rai", :email => "d@g.com", :password => "password"}
        @user = User.new(fields)
        @user.save
        message = "Password confirmation can't be blank"
        expect(@user.errors.full_messages[0]).to eq(message)
      end
    end

    context 'when missing an email' do
      it "will not create a user" do
        fields = {:first_name => "Sim", :last_name => "Rai", :password => "password", :password_confirmation => "password"}
        @user = User.new(fields)
        @user.save
        message = "Email can't be blank"
        expect(@user.errors.full_messages[0]).to eq(message)
      end
    end

    context 'when missing first name' do
      it "will not create a user" do
        fields = {:email => "d@g.com", :last_name => "Rai", :password => "password", :password_confirmation => "password"}
        @user = User.new(fields)
        @user.save
        message = "First name can't be blank"
        expect(@user.errors.full_messages[0]).to eq(message)
      end
    end

    context 'when missing first name' do
      it "will not create a user" do
        fields = {:email => "d@g.com", :first_name => "Sim", :password => "password", :password_confirmation => "password"}
        @user = User.new(fields)
        @user.save
        message = "Last name can't be blank"
        expect(@user.errors.full_messages[0]).to eq(message)
      end
    end

    context 'given the same email twice' do
      it "will not create the second user" do
        fields = {:first_name => "Sim", :last_name => "Rai", :email => "d@G.com", :password => "password", :password_confirmation => "password"}
        fields2 = {:first_name => "Hei", :last_name => "Hachi", :email => "d@g.com", :password => "pass", :password_confirmation => "pass"}
        @user = User.new(fields)
        @user.save
        @user2 = User.new(fields)
        @user2.save
        message = "Email is already taken"
        expect(@user2.errors.full_messages[0]).to eq(message)
      end
    end

    context 'given a password of 2 chars' do
      it "will not create the user" do
        fields = {:first_name => "Sim", :last_name => "Rai", :email => "d@g.com", :password => "pa", :password_confirmation => "pa"}
        @user = User.new(fields)
        @user.save
        message = "Password is too short (minimum is 3 characters)"
        expect(@user.errors.full_messages[0]).to eq(message)
      end
    end
  end

  describe '.authenticate_with_credentials' do
    context "given correct username and password" do
      it "login successfully" do
        fields = {:first_name => "Sim", :last_name => "Rai", :email => "d@g.com", :password => "pass", :password_confirmation => "pass"}
        @user = User.new(fields)
        @user.save
        email = "d@g.com"
        password = "pass"
        check = User.authenticate_with_credentials(email, password)
        expect(check.first_name).to eq("Sim")
      end
    end

    context "given incorrect username and password" do
      it " does not login successfully" do
        fields = {:first_name => "Sim", :last_name => "Rai", :email => "d@g.com", :password => "pass", :password_confirmation => "pass"}
        @user = User.new(fields)
        @user.save
        email = "d@g.com"
        password = "pss"
        check = User.authenticate_with_credentials(email, password)
        expect(check).to eq(nil)
      end
    end

    context "given white spaces around email" do
      it "login successfully" do
        fields = {:first_name => "Sim", :last_name => "Rai", :email => "d@g.com", :password => "pass", :password_confirmation => "pass"}
        @user = User.new(fields)
        @user.save
        email = "  d@g.com  "
        password = "pass"
        check = User.authenticate_with_credentials(email, password)
        expect(check.first_name).to eq("Sim")
      end
    end

    context "given email is written in random caps" do
      it "login successfully" do
        fields = {:first_name => "Sim", :last_name => "Rai", :email => "d@g.com", :password => "pass", :password_confirmation => "pass"}
        @user = User.new(fields)
        @user.save
        email = "D@G.cOm"
        password = "pass"
        check = User.authenticate_with_credentials(email, password)
        expect(check.first_name).to eq("Sim")
      end
    end
  end
end

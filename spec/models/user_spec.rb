require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = { :name=>"Example User", :email=>"user@example.com", :password=>"foobar",
              :password_confirmation=>"foobar"}
  end
  
  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require a name" do
    # my attempt - doesn't work
    # @attr.merge!(:name=>"")
    # User.create!(@attr).should_not be_valid

    # example from tut chap 6
    no_name_user = User.new(@attr.merge(:name=>""))
    no_name_user.should_not be_valid
    
  end
  
  it "should have a unique email address" do
    # put a user with given email address into the db
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  
  it "should require a valid email address" do
    no_email_user = User.new(@attr.merge(:email=>""))
    no_email_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.co.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email=>address))
      valid_email_user.should be_valid
    end
  end
  
  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo example.user@foo.]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email=>address))
      valid_email_user.should_not be_valid
    end
  end
  
  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name=>long_name))
    long_name_user.should_not be_valid
  end
  
  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  describe "password validations"  do
    
    it "should require a password" do
      User.new(@attr.merge(:password=>"",:password_confirmation=>"")).
        should_not be_valid
    end
    
    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation=>"picklefish")).
        should_not be_valid
    end
    
    it "should reject short passwords" do
      short_password = "a" * 5
      User.new(@attr.merge( :password=>short_password, 
                            :password_confirmation=>short_password)).
        should_not be_valid
    end
    
    it "should reject long passwords" do
      long_password = "a" * 41
      User.new(@attr.merge( :password=>long_password, 
                            :password_confirmation=>long_password)).
        should_not be_valid      
    end
  end
    
  describe "password encryption" do
    
    before(:each) do
      @user = User.create!(@attr)  # create the user first
    end
    
    # the do tests on the created user object...
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end
    
    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end
    
    describe "has_password? method" do
      
      it "should be true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end
      
      it "should be false if the passwords do not match" do
        @user.has_password?("picklefishy").should be_false        
      end
    end
  end
  
end
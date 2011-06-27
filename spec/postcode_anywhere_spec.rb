require 'spec_helper'

describe PostcodeAnywhere do

  before :each do
    @acc_code = "XXXXX00000"
    @lic_code = "AA00-BB11-CC22-DD33"
  end

  describe "the PostcodeAnywhere class" do

    it "should define the BASE_URL constant" do
      PostcodeAnywhere.const_get('BASE_URL').should_not be nil
      PostcodeAnywhere.const_get('BASE_URL').should_not be_empty
    end

    it "should include HTTParty" do
      PostcodeAnywhere.included_modules.should include HTTParty
    end

    it "should specify a base_uri" do
      PostcodeAnywhere.base_uri.should_not be nil
    end

    it "should use BASE_URL as the base_uri" do
      PostcodeAnywhere.base_uri.should eq PostcodeAnywhere.const_get('BASE_URL')
    end

  end

  describe "the PostcodeAnywhere initializer" do

    it "takes an options hash as its argument" do
      lambda { PostcodeAnywhere.new({}) }.should_not raise_error ArgumentError
    end

    it "uses an empty hash as its default argument" do
      lambda { PostcodeAnywhere.new() }.should_not raise_error ArgumentError
    end

  end

  describe "the PostcodeAnywhere account_code method" do

    it "should be implemented" do
      PostcodeAnywhere.new.should respond_to(:account_code).with(0).arguments
    end

    it "should return nil by default" do
      PostcodeAnywhere.new.account_code.should be nil
    end

    it "should configure itself from the options hash" do
      pca = PostcodeAnywhere.new(:account_code => @acc_code)
      pca.account_code.should_not be nil
      pca.account_code.should eq @acc_code
    end

  end

  describe "the PostcodeAnywhere license_code method" do

    it "should be implemented" do
      PostcodeAnywhere.new.should respond_to(:license_code).with(0).arguments
    end

    it "should return nil by default" do
      PostcodeAnywhere.new.license_code.should be nil
    end

    it "should configure itself from the options hash" do
      pca = PostcodeAnywhere.new(:license_code => @lic_code)
      pca.license_code.should_not be nil
      pca.license_code.should eq @lic_code
    end

  end

  describe "the PostcodeAnywhere lookup_uri method" do

    it "should be implemented" do
      PostcodeAnywhere.new.should respond_to(:lookup_uri).with(1).arguments
    end

    it "should have a mandatory String argument" do
      lambda { PostcodeAnywhere.new().lookup_uri() }.should raise_error ArgumentError
      lambda { PostcodeAnywhere.new().lookup_uri("") }.should_not raise_error ArgumentError
    end

    it "should include the account code" do
      PostcodeAnywhere.new(:account_code => @acc_code).lookup_uri("").should match /account_code=#{@acc_code}/
    end

    it "should include the license code" do
      PostcodeAnywhere.new(:license_code => @lic_code).lookup_uri("").should match /license_code=#{@lic_code}/
    end

    it "should include the lookup action" do
      PostcodeAnywhere.new.lookup_uri("").should match /action=lookup/
    end

    it "should include the postcode" do
      PostcodeAnywhere.new.lookup_uri("EC1").should match /postcode=EC1/
    end

    it "should include the postcode with whitespace stripped" do
      PostcodeAnywhere.new.lookup_uri(" EC1 2AE ").should match /postcode=EC12AE/
    end

    it "should start with base_uri" do
      PostcodeAnywhere.new.lookup_uri("").should match /\A#{PostcodeAnywhere.base_uri}/
    end

  end

  describe "the PostcodeAnywhere fetch_uri method" do

    it "should be implemented" do
      PostcodeAnywhere.new.should respond_to(:fetch_uri).with(1).arguments
    end

    it "should have a mandatory String argument" do
      lambda { PostcodeAnywhere.new().fetch_uri() }.should raise_error ArgumentError
      lambda { PostcodeAnywhere.new().fetch_uri("") }.should_not raise_error ArgumentError
    end

    it "should include the account code" do
      PostcodeAnywhere.new(:account_code => @acc_code).fetch_uri("").should match /account_code=#{@acc_code}/
    end

    it "should include the license code" do
      PostcodeAnywhere.new(:license_code => @lic_code).fetch_uri("").should match /license_code=#{@lic_code}/
    end

    it "should include the fetch action" do
      PostcodeAnywhere.new.fetch_uri("").should match /action=fetch/
    end

    it "should include the id" do
      PostcodeAnywhere.new.fetch_uri("123").should match /id=123/
    end

    it "should include the postcode with whitespace stripped" do
      PostcodeAnywhere.new.fetch_uri(" 123 ").should match /id=123/
    end

    it "should start with base_uri" do
      PostcodeAnywhere.new.fetch_uri("").should match /\A#{PostcodeAnywhere.base_uri}/
    end

  end

end

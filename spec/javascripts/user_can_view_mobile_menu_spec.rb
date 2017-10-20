
require 'test/unit'
require 'rack/test'
require 'rspec'
require 'watir'
require 'selenium-webdriver'

browser = Watir::Browser.new :chrome



driver = Selenium::WebDriver.for :chrome

RSpec.configure do |config|
  config.before(:each) { @browser = browser }
  config.after(:suite) { browser.close unless browser.nil? }
end

describe "user can view mobile menu" do
  before(:each) do
    @browser.goto("http://localhost:9393/")
    @browser.window.resize_to(375, 671)
  end

  describe "that we have hit a valid URL" do
    it "should not return an invalid error message" do
      @browser.element(id: "hamburger").click

      @browser.ul(:class,"mobile-menu-list").li(:text,"Tuition Plans").visible?.eql?(true)
      @browser.p(:text, "CIRCLE OF FRIENDS").visible?.eql?(false)
    end
  end
end

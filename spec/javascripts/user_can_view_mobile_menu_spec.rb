require 'spec_helper'
require 'test/unit'
require 'rack/test'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'pry'

Capybara.app = Sinatra::Application
Capybara.javascript_driver = :poltergeist

describe('User can view mobile menu', {:type => :feature}) do

  scenario "user can view sign-in overlay form", js: true do
    visit '/'
    page.current_window.resize_to(375, 667)

    find('#hamburger').click

    before_hover = computed_style('.mobile-menu-list li a', 'color')

    menu_item = find(:css, '.mobile-menu-list li a', match: :first)
    menu_item.hover

    sleep 1  #there has to be a better alternative

    after_hover = computed_style('.mobile-menu-list li a', 'color')

    expect(menu_item.text).to have_content('Tuition Plans')
    expect(before_hover).to have_content('rgb(129, 129, 129)')
    expect(after_hover).to have_content('rgb(241, 241, 241)')
  end
end




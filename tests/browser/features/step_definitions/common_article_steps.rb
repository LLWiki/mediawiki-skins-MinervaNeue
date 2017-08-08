Given(/^I click continue$/) do
  on(ArticlePage).continue_button_element.when_present.click
end

Given(/^I click submit$/) do
  on(ArticlePage) do |page|
    page.spinner_loading_element.when_not_present
    page.submit_button_element.when_present.click
  end
end

When(/^I click on the history link in the last modified bar$/) do
  on(ArticlePage).last_modified_bar_history_link_element.when_present.click
  expect(on(SpecialHistoryPage).side_list_element.when_present(10)).to be_visible
end

When(/^I click on the page$/) do
  on(ArticlePage).content_wrapper_element.click
end

When(/^I click the unwatch star$/) do
  on(ArticlePage).unwatch_star_element.when_present.click
end

When(/^I click the watch star$/) do
  on(ArticlePage).watch_star_element.when_present.click
end

Then(/^I should see a toast notification$/) do
  # To avoid flakey tests check the notification area element first (T170890)
  on(ArticlePage) do |page|
    # Minerva loads mediawiki.notify at startup which defers the loading of this module
    # We must wait until the lazy loading has happened before checking for the toast (T170890)
    page.wait_until_rl_module_ready('mediawiki.notification')
    expect(page.notification_area_element.when_visible).to be_visible
  end
end

Then(/^I should see a toast with message "(.+)"$/) do |msg|
  on(ArticlePage) do |page|
    page.wait_until_rl_module_ready('mediawiki.notification')
    page.wait_until do
      page.toast_element.when_present.text.include? msg
    end
    expect(page.toast_element.when_present.text).to match msg
  end
end

Then /^I should see a drawer with message "(.+)"$/ do |text|
  expect(on(ArticlePage).drawer_element.when_present.text).to match text
end

Then(/^the text of the first heading should be "(.*)"$/) do |title|
  on(ArticlePage) do |page|
    page.wait_until do
      page.first_heading_element.when_present.text.include? title
    end
    expect(page.first_heading_element.when_present.text).to match title
  end
end

Then /^the watch star should be selected$/ do
  expect(on(ArticlePage).unwatch_star_element).to be_visible
end

Then /^the watch star should not be selected$/ do
  expect(on(ArticlePage).watch_star_element).to be_visible
end

# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(title: movie[:title], release_date: movie[:release_date], rating: movie[:rating])
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  page.body.should match /#{e1}.*#{e2}/m
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(/,\s*/).each do |rating|
    field = "ratings_#{rating}"
    if uncheck
      uncheck(field)
    else
      check(field)
    end
  end
end

Then /^I should see (.*) of the movies$/ do |option|
  # express the regexp above with the code you wish you had
  if option == 'all'
    page.should have_css('#movies tbody tr', count: 10)
  elsif option == 'none'
    page.should_not have_css('#movies tbody tr')    
  end
end
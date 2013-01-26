# CN320 Software Engineering
# Semester 2/2555
# Homework #4 - BDD+TDD Cycle
# Theetawat Tangkhajiwarngkoon	ID: 5210612361
# Wittaya Siriporn		ID: 5210530019

# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  assert page.body.index(e1) < page.body.index(e2), "Wrong order"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  if uncheck == "un"
    rating_list.split(", ").each {|x| step %{I uncheck "ratings_#{x}"}}
  else
    rating_list.split(", ").each {|x| step %{I check "ratings_#{x}"}}
  end
end

Then /I should see all of the movies/ do
  # use page.body
  rows = page.all("#movies tr").size - 1
  assert rows == Movie.count()
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |title, director|
  movie = Movie.find_by_title(title)
  movie.director.should == director
end

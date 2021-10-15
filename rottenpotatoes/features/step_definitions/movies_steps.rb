
Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

# Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |arg1, arg2|
#   Movie.find_by_title(arg1).director == arg2
# end

Then /the director of "(.*)" should be "(.*)"/ do |movie_name, director_name|
  movie = Movie.find_by(title: movie_name)
  expect(movie.director).to eq director_name
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|    #step definition for sorting tests     
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  regular_exp = /#{e1}.*{e2}/m
  regular_exp.match(page.body)
  # fail "Unimplemented"
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  
  if uncheck == "un"
    rating_list.split(', ').each { |x| step %{I uncheck "ratings_#{x}"} }
  else
    rating_list.split(', ').each { |x| step %{I check "ratings_#{x}"} }
  end

end

Then /I should not see any of the movies/ do
  rows = page.all('#movies tr').size - 1
  assert rows == 0
end


Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  Movie.all.each do |movie|
    step %{I should see "#{movie.title}"}
  end
end


Then /I should see the movies : (.*)/ do |movie_list|    #step definition for filtering tests
  # pending # Write code here that turns the phrase above into concrete actions
  movies = movie_list.split(', ')
  for movie in movies
      step "I should see " + movie
  end
end
 
Then /I should not see the movies : (.*)/ do |movie_list|  #step definition for filtering tests  
  # pending # Write code here that turns the phrase above into concrete actions
  movies = movie_list.split(', ')
  for movie in movies
      step "I should not see " + movie
  end
end
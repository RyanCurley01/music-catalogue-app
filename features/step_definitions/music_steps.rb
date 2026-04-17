Given(/the following music exist/) do |music_table|
  music_table.hashes.each do |music|
    Music.create music
  end
end

Then(/I should see "(.*)" before "(.*)"/) do |e1, e2|
  # ensure that that e1 occurs before e2.
  # page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

When(/I (un)?check the following ratings: (.*)/) do |uncheck, rating_list|
  rating_list.split(', ').each do |rating|
    step %(I #{uncheck.nil? ? '' : 'un'}check "ratings_#{rating}")
  end
end

Then(/I should see all the music/) do
  # Make sure that all the movies in the app are visible in the table
  Music.all.each do |music|
    step %(I should see "#{music.title}")
  end
end

Then(/^the artist of "([^"]*)" should be "([^"]*)"$/) do |title, artist|
  music = Music.find_by(title: title)
  expect(music.artist).to eq(artist)
end

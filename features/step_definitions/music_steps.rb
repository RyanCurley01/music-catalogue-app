Given(/the following music exist/) do |music_table|
  music_table.hashes.each do |music|
    Music.create music
  end
end

Then(/I should see "(.*)" before "(.*)"/) do |e1, e2|
  expect(page.body.index(e1) < page.body.index(e2))
end

When(/I (un)?check the following ratings: (.*)/) do |uncheck, rating_list|
  rating_list.split(', ').each do |rating|
    step %(I #{uncheck.nil? ? '' : 'un'}check "ratings_#{rating}")
  end
end

Then(/I should see all the music/) do
  Music.all.each do |music|
    step %(I should see "#{music.title}")
  end
end

Then(/^the artist of "([^"]*)" should be "([^"]*)"$/) do |title, artist|
  music = Music.find_by(title: title)
  expect(music.artist).to eq(artist)
end

Then(/^the genre of "([^"]*)" should be "([^"]*)"$/) do |title, genre|
  music = Music.find_by(title: title)
  expect(music.genre).to eq(genre)
end

Then(/^the rating of "([^"]*)" should be "([^"]*)"$/) do |title, rating|
  music = Music.find_by(title: title)
  expect(music.rating).to eq(rating.to_i)
end


Given('the following songs exist:') do |table|
  table.hashes.each do |song|
    Music.create!(
      title: song['title'],
      rating: song['rating'] || 3
    )
  end
end

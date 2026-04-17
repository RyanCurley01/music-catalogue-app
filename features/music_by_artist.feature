Feature: Search for electronic music by artists

  As a electronic music fan
  So that I can find music with my favorite artist
  I want to include and search on artist information in music I enter

Background: music in database

  Given the following music exists:
  | title           | album              | artist                 | release_date |
  | last rushup 10 M| Rushup Edge        | The Tuss               |   2017-07-20 |
  | Mangle 11       | Rephlexions        | Aphex Twin             |   2003-11-03 |
  | Papua New Guinea| Accelerator        | Future Sound of London |   1979-05-25 |
  | Nothing is Real | Tomorrow's Harvest | Boards of Canada       |   2013-06-04 |
  | Vordhosbn       | Druqs              | Aphex Twin             |   2001-10-22 |

Scenario: add artist to existing music
  When I go to the edit page for "last rushup 10 M"
  And  I fill in "Artist" with "The Tuss"
  And  I press "Update Music Info"
  Then the artist of "last rushup 10 M" should be "The Tuss"

Scenario: find music with same artist
  Given I am on the details page for "Mangle 11"
  When  I follow "Find Music With Same Artist"
  Then  I should be on the Similar Music page for "Mangle 11"
  And   I should see "Vordhosbn"
  But   I should not see "Nothing is Real"

Scenario: view list of all music
  Given I am on the home page
  Then I should see "last rushup 10 M"
  And I should see "Mangle 11"

Scenario: view details of a music
  Given I am on the details page for "Papua New Guinea"
  Then I should see "Future Sound of London"

Scenario: add a new song
  When I go to the new music page
  And I fill in "Title" with "Can You Feel It"
  And I select "Druqs" from "Album"
  And I fill in "Artist" with "Mr. Fingers"
  And I fill in "Released On" with "1986-05-23"
  And I press "Save Changes"
  Then I should be on the home page
  And I should see "Can You Feel It"

Scenario: delete a song
  Given I am on the details page for "last rushup 10 M"
  When I press "Delete"
  Then I should be on the home page
  And I should not see "last rushup 10 M"
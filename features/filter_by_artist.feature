Feature: Search for electronic music by artists

  As a electronic music fan
  So that I can find music with my favorite artist
  I want to include and search on artist information in music I enter

Background: music in database

  Given the following music exists:
  | title           | album              | artist                 | genre    | release_date | rating |
  | Last Rushup 10  | Rushup Edge        | The Tuss               | IDM      | 2017-07-20   |    4   |
  | Mangle 11       | Rephlexions        | Aphex Twin             | IDM      | 2003-11-03   |    2   |
  | Papua New Guinea| Accelerator        | Future Sound of London | Ambient  | 1979-05-25   |    5   |
  | Nothing is Real | Tomorrow's Harvest | Boards of Canada       | Ambient  | 2013-06-04   |    3   |
  | Vordhosbn       | Druqs              | Aphex Twin             | IDM      | 2001-10-22   |    5   |
  | Unknown         | Unknown            |                        | IDM      | 2000-01-01   |    3   |

Scenario: add artist to existing music
  When I go to the edit page for "Last Rushup 10"
  And  I fill in "Artist" with "The Tuss"
  And  I press "Update Music Info"
  Then the artist of "Last Rushup 10" should be "The Tuss"

Scenario: find music with same artist
  Given I am on the details page for "Mangle 11"
  When  I follow "Find Music With Same Artist"
  Then  I should be on the Similar Music page for "Mangle 11"
  And   I should see "Vordhosbn"
  But   I should not see "Nothing is Real"

Scenario: view list of all music
  Given I am on the home page
  Then I should see "Last Rushup 10"
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
  Given I am on the details page for "Last Rushup 10"
  When I press "Delete"
  Then I should be on the home page
  And I should not see "Last Rushup 10"

Scenario: music has no artist
  Given I am on the details page for "Unknown"
  When I follow "Find Music With Same Artist"
  Then I should be on the home page
  And I should see "'Unknown' has no artist info"
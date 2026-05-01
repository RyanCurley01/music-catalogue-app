Feature: Search for electronic music by genre

  As a electronic music fan
  So that I can find styles of music I like
  I want to filter and search music by the same genre

Background: music in database

  Given the following music exists:
  | title           | album              | artist                 | genre    | release_date | rating |
  | Last Rushup 10  | Rushup Edge        | The Tuss               | IDM      | 2017-07-20   |    4   |
  | Mangle 11       | Rephlexions        | Aphex Twin             | IDM      | 2003-11-03   |    2   |
  | Papua New Guinea| Accelerator        | Future Sound of London | Ambient  | 1979-05-25   |    5   |
  | Nothing is Real | Tomorrow's Harvest | Boards of Canada       | Ambient  | 2013-06-04   |    3   |
  | Vordhosbn       | Druqs              | Aphex Twin             | IDM      | 2001-10-22   |    5   |
  | Unknown         | Unknown            | Aphex Twin             |          | 2000-01-01   |    3   |

Scenario: add genre to existing music
  When I go to the edit page for "Last Rushup 10"
  And  I fill in "Genre" with "IDM"
  And  I press "Update Music Info"
  Then the genre of "Last Rushup 10" should be "IDM"

Scenario: find music with same genre
  Given I am on the details page for "Mangle 11"
  When  I follow "Find Music With Same Genre"
  Then  I should be on the Similar Genre page for "Mangle 11"
  And   I should see "Last Rushup 10"
  But   I should not see "Papua New Guinea"

Scenario: music has no genre
  Given I am on the details page for "Unknown"
  When I follow "Find Music With Same Genre"
  Then I should be on the home page
  And I should see "'Unknown' has no genre info"

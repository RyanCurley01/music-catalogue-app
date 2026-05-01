Feature: Rate Music

  As a electronic music fan
  So that I can save styles of music I like
  I want to add a rating from 1 to 5

Background: music in database

  Given the following music exists:
  | title           | album              | artist                 | genre    | release_date | rating |
  | Last Rushup 10  | Rushup Edge        | The Tuss               | IDM      | 2017-07-20   |    4   |
  | Mangle 11       | Rephlexions        | Aphex Twin             | IDM      | 2003-11-03   |    2   |
  | Papua New Guinea| Accelerator        | Future Sound of London | Ambient  | 1979-05-25   |    5   |
  | Nothing is Real | Tomorrow's Harvest | Boards of Canada       | Ambient  | 2013-06-04   |    3   |
  | Vordhosbn       | Druqs              | Aphex Twin             | IDM      | 2001-10-22   |    5   |

Scenario: add rating to existing music
  When I go to the edit page for "Last Rushup 10"
  And  I fill in "Rating" with "4"
  And  I press "Update Music Info"
  Then the rating of "Last Rushup 10" should be "4"

Scenario: find music with top rating
  Given I am on the home page
  When  I select "5" from "Rating"
  And I press "Search"
  Then I should see "Papua New Guinea"
  And I should see "Vordhosbn"

Scenario: update rating to existing music
  Given I am on the details page for "Mangle 11"
  When I fill in "Rating" with "5"
  And I press "Update Music Info"
  Then the rating of "Mangle 11" should be "5"

Scenario: no music matches selected rating
  Given I am on the home page
  When I select "1" from "Rating"
  And I press "Search"
  Then I should not see "Mangle 11"
  And I should not see "Vordhosbn"
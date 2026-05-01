Feature: song sorting

  Background:
    Given the following songs exist:
      | title             | album               | artist                   | genre   | release_date | rating |
      | last rushup 10 M  | Rushup Edge         | The Tuss                 | IDM     | 2017-07-20   | 4      |
      | Mangle 11         | Rephlexions         | Aphex Twin               | IDM     | 2003-11-03   | 2      |
      | Papua New Guinea  | Accelerator         | Future Sound of London   | Ambient | 1979-05-25   | 5      |
      | Nothing is Real   | Tomorrow's Harvest  | Boards of Canada         | Ambient | 2013-06-04   | 3      |
      | Vordhosbn         | druqs               | Aphex Twin               | IDM     | 2001-10-22   | 5      |

  Scenario: sort songs by title
    When I go to the home page
    And I follow "Title"
    Then I should see "Mangle 11" before "Nothing is Real"

  Scenario: sort songs by album
    When I go to the home page
    And I follow "Album"
    Then I should see "Papua New Guinea" before "Vordhosbn"

  Scenario: sort songs by artist
    When I go to the home page
    And I follow "Artist"
    Then I should see "Mangle 11" before "Nothing is Real"
        
  Scenario: sort songs by genre
    When I go to the home page
    And I follow "Genre"
    Then I should see "Papua New Guinea" before "Mangle 11"

  Scenario: sort songs by release date
    When I go to the home page
    And I follow "Release Date"
    Then I should see "Papua New Guinea" before "last rushup 10 M"

  Scenario: sort songs by rating
    When I go to the home page
    And I follow "Rating"
    Then I should see "Mangle 11" before "Papua New Guinea"
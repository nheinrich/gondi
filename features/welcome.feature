Feature: Welcome
  In order to get inspired by shred
  As a viewer
  I want to see videos when I load the site
  
  Scenario: A video has been added
    Given a video exists
    When I go to the welcome page
    Then I should see "Shred Premiere 2011!" within "h2"
    And I should see "today" within "span.created_at"
    
  Scenario: List of videos
    pending
    Given the following videos exist
    | title |
    | "Shred Flick Title" |
    | "Skinny Pants Flick: Season 1 Ep 1" |
    | "Baggy Pants Flick / The Return" |
    When I go to the welcome page
    Then I should see
Feature: Configure auto capture sessions

Background:
  Given I set environment variable "API_KEY" to "a35a2a72bd230ac0aa0f52715bbdc6aa"
  And I configure the bugsnag endpoint
  And I have built the service "nethttp"
  And I stop the service "nethttp"
  And I set environment variable "SERVER_PORT" to "4512"

Scenario: A session is not sent if auto capture sessions is off
  Given I set environment variable "AUTO_CAPTURE_SESSIONS" to "false"
  When I start the service "nethttp"
  And I wait for the app to open port "4512"
  And I wait for 1 seconds
  And I open the URL "http://localhost:4512/session"
  And I wait for 1 seconds
  Then I should receive no requests

Scenario: A session is sent if auto capture sessions is on
  Given I set environment variable "AUTO_CAPTURE_SESSIONS" to "true"
  When I start the service "nethttp"
  And I wait for the app to open port "4512"
  And I wait for 1 seconds
  And I open the URL "http://localhost:4512/session"
  And I wait for 1 seconds
  Then I should receive 1 request
  And the request is valid for the session tracking API
  And the session contained the api key "a35a2a72bd230ac0aa0f52715bbdc6aa"
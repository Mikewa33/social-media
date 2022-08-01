# README

# Description

This is the billion dollar social media feed puller. It runs a worker for every social media platform every minute to sync the latest data. Because these social media feeds are erratic we store the data we get in the database. This prevents outages and allows us to present the data quickly to our billion dollar clients. When the worker runs into the error we just skip that sync and in the next run it gets the new data.

# SETUP

1. run `bundle install`
2. run `rails db:create`
3. run `rails db:migrate`
4. run in a different console tab `bundle exec sidekiq`
5. Give the workers a min or two and then run `rails s`

# Next Steps for live social media feed

1. We pass the created_at date of the last post into the feed. This would eliminate getting duplicate post
2. Store the post ID from the external feed. This allows us to retrieve and update the post as needed. It also works as a second safeguard against duplicate post
3. Depending on future plans we may want to implement STI and move common logic to a Post model and table. For now 3 different models/table work best cause while the logic is the same we don't have IDs so don't want content overlapping
4. Add some pagination to the json call at '/'. In a real world situation this would bloat very quickly
5. Possibly Cache responses


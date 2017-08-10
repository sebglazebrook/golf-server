require "repositories/user_repository"
require "repositories/competition_repository"

class GolfServer < Sinatra::Base

  get "/_health" do
    [200, "OK"]
  end

  get "/competitions/:name/daily_status" do
    competition = Repositories::CompetitionRepository.find!(params[:name])
    [200, competition.status.to_json]
  end

  post "/competitions/:name/users" do
    # TODO create a user for a competition
    user = Repositories::UserRepository.create!(params[:user])
    competition = Repositories::CompetitionRepository.find(:name)
    competition.users << user
    competition.save!
    [201, "Yay! You've been added to #{competition.name}!"]
  end

  get "/competitions/:name/users/:username/challenge" do
    # TODO fetch the challenge available for the user
  end

  post "/competitions/:name/users/:username/challenges/:challenge_id/answers" do
    # TODO create a user's answer to a challenge
  end

  delete "/competitions/:name/users/:username" do
    # TODO remove a user from a competition
  end

end

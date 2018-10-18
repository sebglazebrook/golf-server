require "repositories/user_repository"
require "repositories/competition_repository"

class GolfServer < Sinatra::Base

  get "/_health" do
    [200, "OK"]
  end

  # bot status
  get "/competitions/:name/daily_status" do
    competition = Repositories::CompetitionRepository.find!(params[:name])
    [200, competition.status.to_json]
  end

  # bot join
  post "/competitions/:name/users" do
    user = Repositories::UserRepository.create!(params[:user])
    competition = Repositories::CompetitionRepository.find!(params[:name])
    competition.users << user
    Repositories::CompetitionRepository.save!(competition)
    [201, "Yay! You've been added to #{competition.name}!"]
  end

  # bot start
  get "/competitions/:name/users/:username/challenge" do
    # TODO fetch the challenge available for the user
    user = Repositories::UserRepository.find!(params[:username])
    competition = user.competitions.select { |competition| competition.name = params[:name] }
    if competition.challenge_available_for_user?(user)
      [200, competition.challenge_for_user(user).to_json]
    else
      [404, "There are no challenges available for you at the moment"] 
    end
  end

  post "/competitions/:name/users/:username/challenges/:challenge_id/answers" do
    # TODO create a user's answer to a challenge
    #fetch competition
    #fetch user
    #fetch challenge
    #answer for user
    #if correct
      #score?
    #else
      #what?
    #end
  end

  # bot leave
  delete "/competitions/:name/users/:username" do
    # TODO remove a user from a competition
  end

end

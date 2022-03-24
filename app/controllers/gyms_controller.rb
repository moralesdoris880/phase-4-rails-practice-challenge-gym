class GymsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    def show 
        gym = Gym.find(params[:id])
        if gym
            render json: gym, status: :ok
        else
            not_found
        end
    end

    def destroy 
        gym = Gym.find(params[:id])
        if gym
            gym.memberships.destroy
            gym.clients.destroy
            gym.destroy
            head :no_content
        else
            not_found
        end
    end 
    
    private

    def not_found
        render json: {error: 'Gym not found'}, status: :not_found
    end
end

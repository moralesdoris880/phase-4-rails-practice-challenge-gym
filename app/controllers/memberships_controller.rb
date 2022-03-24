class MembershipsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def create 
        gym = Gym.find(params[:gym_id])
        if gym
            client = Client.find(params[:client_id])
            if client && client.memberships.length === 0
                membership = gym.memberships.create!(membership_params)
                render json: membership, status: :created
            else 
                not_found
            end
        else
            not_found
        end
    end

    private 

    def membership_params
        params.permit(:gym_id,:client_id,:charge)
    end

    def not_found
        render json: {error: 'Gym not found'}, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end

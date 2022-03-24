class ClientsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    def show 
        client = Client.find(params[:id])
        if client
            render json: client, status: :ok
        else
            not_found
        end
    end

    private

    def not_found
        render json: {error: 'Client not found'}, status: :not_found
    end

end

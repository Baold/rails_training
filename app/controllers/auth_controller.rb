class AuthController < ApplicationController
    before_action :require_user, only: [:destroy]

    def index
    end

    def create
        @user = User.new(user_params)
        if @user.save
            token = encode_token(@user.id)
            UserToken.create(token: token, user_id: @user.id)
            response.headers['Authorization'] = "Bearer #{token}"
            render json: { user: @user, 
                            token: token, 
                                message: 'User created successfully' }, status: :created
        else
            render json: { message: @user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def login
        @user = User.find_by(email: params.permit![:email]) 
        if @user && @user.authenticate(user_params[:password]) 
            token = encode_token(@user.id)
            UserToken.create(token: token, user_id: @user.id)
            response.headers['Authorization'] = "Bearer #{token}"
            render json: { user: @user, 
                            token: token,
                            message: 'User logged in successfully' }, status: :created 
        else
            render json: { errors: "Invalid email or password" }, status: :unprocessable_entity
        end
    end

    def show 
    end

    def update
    end

    def destroy
        token = UserToken.find_by(user_id: current_user[:id])
        if token
            token.destroy
            render json: {
                message: "Logged out successfully"
            }, status: :ok
        else
            render json: { message: "User not logged out" }, status: :unprocessable_entity
        end 
    end

    def user_params
        params.permit(:email, :password, :full_name)
    end

end
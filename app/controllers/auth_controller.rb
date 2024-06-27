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

# skip_before_action :authorized, only: [:signup]

#   def signup
#     @user = User.new(user_params)
#     if @user.save
#       render json: {
#         user: @user
#       }, status: :created
#     else
#       render json: @user.errors, status: :unprocessable_entity
#     end
#   end

#   def signin
#     # Check email is existing in the database
#     # Base on password on user_params - compare with password hash stored in database
#     @user = User.find_by!(email: user_params[:email])
#     if @user.authenticate(user_params[:password])
#       # Generate and store jwt token
#       token = encode_token(user_id: @user.id)

#       if token
#         user_token = UserToken.create!(token: token, user_id: @user.id)
#         user_token.save

#         # response
#         render json: { user: @user, token: token }
#       else
#         render json: { message: 'Please login again' }, status: :unauthorized
#       end
#     else
#       render json: { message: 'Invalid email or password' }, status: :unauthorized
#     end
#   end

#   def me
#     render json: { user: current_user }, status: :ok
#   end

#   # Addendum/Correction: For controllers, you should mark the "helper" methods as protected private,
#   #   and only the actions themselves should be public.
#   #   The framework will never route any incoming HTTP calls to actions/methods that are not public,
#   #   so your helper methods should be protected in that way.
#   private
#     def user_params
#       params.permit(:email, :password)
#     end
# end
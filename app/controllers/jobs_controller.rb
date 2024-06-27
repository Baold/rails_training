class JobsController < ApplicationController
    
    def index

    end

    def create
        @job = Job.new(job_params)
        @job.created_by_id = current_user.id
        @job.published_date = Time.now if job_params[:status] == "publish"
        if @job.save
            render json: { job: @job, 
                                message: 'Job is created successfully' }, status: :created
        else
            render json: { 
                message: @job.errors.full_messages
             }, status: :unprocessable_entity
        end
    end

    def show

    end

    def update

    end

    def destroy

    end

    def job_params
        params.permit(:title, :salary_from, :salary_to, :status)
    end

end
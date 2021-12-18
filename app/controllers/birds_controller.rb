class BirdsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  # GET /birds
  def index
    birds = Bird.all
    render json: birds
  end

  # POST /birds
  def create
    bird = Bird.create(bird_params)
    render json: bird, status: :created
  end

  # GET /birds/:id
  def show
    bird = find_bird
    #using the rescue_from method above, no need to add the rescue inside of show, only use it above for every def, only add the render if bird is found is true
    render json: bird

    # using the rescue method
  #   render json: bird
  # rescue ActiveRecord::RecordNotFound
  #   render_not_found_response

    # using the if statement
    # if bird
    #   render json: bird
    # else
    #   render_not_found_response    
    # end
  end

  # PATCH /birds/:id
  def update
    bird = find_bird
    bird.update(bird_params)
    render json: bird

    # without the rescue_from method above
  # rescue ActiveRecord::RecordNotFound
  #   render_not_found_response

    # if bird
    #   bird.update(bird_params)
    #   render json: bird
    # else
    #   render_not_found_response
    # end
  end

  # PATCH /birds/:id/like
  def increment_likes
    bird = find_bird
    bird.update(likes: bird.likes + 1)
    render json: bird

    # without the rescue_from method above
    # if bird
    #   bird.update(likes: bird.likes + 1)
    #   render json: bird
    # else
    #   render_not_found_response
    # end
  end

  # DELETE /birds/:id
  def destroy
    bird = find_bird
    bird.destroy
    head :no_content

    # without the rescue_from method above
    # if bird
    #   bird.destroy
    #   head :no_content
    # else
    #   render_not_found_response
    # end
  end

  private

  def find_bird
    Bird.find(params[:id])
  end

  def bird_params
    params.permit(:name, :species, :likes)
  end

  def render_not_found_response
    render json: { error: "Bird not found" }, status: :not_found
  end
  

end

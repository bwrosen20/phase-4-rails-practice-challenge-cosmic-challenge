class PlanetsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

before_action :set_scientist, only: [:show, :create, :update, :destroy]

  # GET /planets
  def index
    planets = Planet.all

    render json: planets
  end

  def show
    planet = Planet.find(params[:id])
    render json: planet
  end

  def create
    planet = Planet.new(planet_params)
    render json: planet
  end

  def update
    planet = Planet.find(params[:id])
    planet.update(planet_params)
    render json: planet
  end

  def destroy
    planet = Planet.find(params[:id])
    planet.destroy
  end


  private

  def planet_params 
    params.permit(:name, :distance_from_earth, :nearest_star, :image)
  end

  def render_not_found_response
    render json: {error: "Planet not found"}, status: :not_found
  end

  def render_unprocessable_entity(invalid)
    render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
  end
end

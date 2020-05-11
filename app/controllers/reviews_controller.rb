class ReviewsController < ApplicationController
  # Create
  def create
    @review = Review.new(review_params)

    if @review.save
      redirect_to user_path(params[:review][:reviewer_id])
    end
  end

  private
    # Parmas
    def review_params
      params.require(:review).permit(:reviewer_id, :reviewed_id, :rate, :comment)
    end
end

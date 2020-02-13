class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    respond_to do |format|
      if @review.save
        format.html { redirect_back(fallback_location: root_path) }
      else
        format.html { redirect_back(fallback_location: root_path) }
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:reviewer_id, :reviewed_id, :rate, :comment)
  end
end

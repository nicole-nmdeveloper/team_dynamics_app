class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]

  # GET /reviews or /reviews.json
  def index
    @reviews = Review.all
  end

  # GET /reviews/1 or /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @dinamica = Dinamica.find(params[:dinamica_id])
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews or /reviews.json
  def create
    @review = Review.new(review_params)

    respond_to do |format|
      if @review.save
        Rails.logger.info "Review criada com sucesso: #{@review.inspect}"

        format.html { redirect_to @review.dinamica, notice: "A review foi cadastrada." }
        format.json { render :show, status: :created, location: @review }
      else
        Rails.logger.error "Erro ao criar review: #{@review.errors.full_messages.join(', ')}"

        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        Rails.logger.info "Review atualizada com sucesso: #{@review.inspect}"

        format.html { redirect_to @review.dinamica, notice: "A review foi atualizada." }
        format.json { render :show, status: :ok, location: @review }
      else
        Rails.logger.error "Erro ao atualizar review: #{@review.errors.full_messages.join(', ')}"

        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review.destroy!

    respond_to do |format|
      Rails.logger.info "Review apagada com sucesso: #{@review.inspect}"
      format.html { redirect_to @review.dinamica, status: :see_other, notice: "A review foi apagada." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.expect(review: [ :comentario, :nota, :data_criacao, :dinamica_id ])
    end
end

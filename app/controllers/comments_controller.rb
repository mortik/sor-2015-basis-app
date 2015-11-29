class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy, :update]

  # GET /comments
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  def show
    @link = @comment.link
  end

  # GET /comments/new
  def new
    @comment = Comment.new
    @link = Link.find(params[:link_id])
    @comment.link_id = params[:link_id]
  end

  # GET /comments/1/edit
  def edit
    @link = @comment.link
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params.merge(user_id: current_user.id, user_name: current_user.name ))
    @comment.link_id = params[:link_id]
    @link = @comment.link

    if @comment.save
      redirect_to @link, notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /comments/1
  def update
    @link = @comment.link
    if @comment.update(comment_params)
      redirect_to @link, notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
    @link = @comment.link
    redirect_to @link, notice: 'Comment was successfully destroyed.'
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:body)
    end
end

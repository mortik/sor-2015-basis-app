class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy, :like]
  before_action :authenticate_user!, only: [:new, :edit, :destroy, :update]

  # GET /links
  def index
    if params[:tag]
      @tag = params[:tag]
      @links = Link.all.select { |link| link.tags.include? params[:tag]}
    else
      @links = Link.all
    end
    @likes = Hash.new
    Link.all.each do |link|
      @likes[link.id] = Like.where(:link_id => link.id).count
    end
  end

  # GET /links/1
  def show
    @link = Link.find(params[:id])
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  def create
    tags = link_params['tags']
    link_params['tags'] = tags.split(' ')
    @link = Link.new(link_params.merge(user_id: current_user.id))

    if @link.save
      redirect_to @link, notice: 'Link was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /links/1
  def update
    tags = link_params['tags']
    link_params['tags'] = tags.split(' ')
    if @link.update(link_params)
      redirect_to @link, notice: 'Link was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /links/1
  def destroy
    @link.destroy
    redirect_to links_url, notice: 'Link was successfully destroyed.'
  end

  def like
    @like = Like.new({:user_id => current_user.id, :link_id => params[:id]})
    if @like.save
      redirect_to links_url, notice: 'Geliked'
    else
      redirect_to links_url, alert: "Bereits geliked"
    end
    
  end

  def rankings
   @links = Link.all
   @likes = Hash.new
    Link.all.each do |link|
      @likes[link.id] = Like.where(:link_id => link.id).count
    end
    @links = @links.sort_by do |link|
      link.num_likes
    end.reverse
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def link_params
      params[:link]
    end
end

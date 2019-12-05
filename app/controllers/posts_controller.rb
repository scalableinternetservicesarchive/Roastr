class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.left_outer_joins(:user).select('posts.*, users.username').paginate(page: params[:page], per_page: 10).order("posts.created_at DESC")
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    if @post.user_id
      @user = User.find(@post.user_id)
    else
      @user = nil
    end
    @comments = Comment.left_outer_joins(:user).select('comments.*, users.username').where(post_id: @post.id).order("comments.created_at DESC")
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if current_user == nil or current_user.id != @post.user_id
      respond_to do |format|
          format.html { redirect_to @post, notice: 'You do not have the proper permissions to edit that post.' }
          format.json { render json: {'error' => 'You do not have the proper permissions to edit that post.'} }
      end
      return
    end
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    if current_user == nil or current_user.id != @post.user_id
      respond_to do |format|
          format.html { redirect_to posts_url, notice: 'You do not have the proper permissions to delete that post.' }
          format.json { render json: {'error' => 'You do not have the proper permissions to delete that post.'} }
      end
      return
    end
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      p = params.require(:post).permit(:image, :caption)
      if current_user
        p[:user_id] = current_user.id
      end
      return p
    end
end

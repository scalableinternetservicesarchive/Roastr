class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  # before_action :set_user
  before_action :set_post

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  # def create
  #   @comment = Comment.new(comment_params)
  #
  #   respond_to do |format|
  #     if @comment.save
  #       format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
  #       format.json { render :show, status: :created, location: @comment }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @comment.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def create
    @post = Post.find(params[:comment][:post_id])
    @comment = @post.comments.create(comment_params)
    # @comment.post_id = Post.find(params[:post_id])
    # @comment.user_id = current_user.id #or whatever is you session name
    if @comment.save
      redirect_to post_path(@post)
    else
      flash.now[:danger] = "error"
    end
  end


  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    redirect_to post_path(@post)

    # respond_to do |format|
    #   format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_post
      @post_id = params[:post_id]
      # @post = Posts.find(params[:post_id])
    end

    # def set_user
    #   @user = User.find(params[:user_id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      p = params.require(:comment).permit(:post_id, :comment)
      if current_user
        p[:user_id] = current_user.id
      end
      return p
    end
end

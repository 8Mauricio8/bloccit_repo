class PostsController < ApplicationController
  def index
    @posts = policy_scope(Post)
    authorize @posts
  end

  def show
    @post = Post.find(params[:id])
     @topic = Topic.find(params[:topic_id])
  end

  def new
     @topic = Topic.find(params[:topic_id])
    @post = Post.new
    authorize @post
  end
  
  def create
     @topic = Topic.find(params[:topic_id])
       @post = current_user.posts.build(post_params)
    authorize @post
    summary_body = params[:post][:summary]
    @post.summary = Summary.new body: summary_body
     if @post.save
       flash[:notice] = "Post was saved."
       redirect_to [@topic, @post]
     else
       flash[:error] = "There was an error saving the post. Please try again."
       render :new
     end
   end

  def edit
     @topic = Topic.find(params[:topic_id])
     @post = Post.find(params[:id])
    authorize @post
  end

   def update
      @topic = Topic.find(params[:topic_id])
     @post = Post.find(params[:id])
     authorize @post
     if @post = current_user.posts.build(post_params)
       flash[:notice] = "Post was updated."
       redirect_to @post
     else
       flash[:error] = "There was an error saving the post. Please try again."
       render :edit
     end
   end
  def post_params
  params.require(:post).permit(:title, :body)
  end
end

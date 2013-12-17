require_dependency "kebapress/application_controller"

module Kebapress
  class Hq::PostsController < ApplicationController
    layout 'layouts/hq/application'

    def new
      @post = Kebapress::Post.new
    end

    def create
      @post = Kebapress::Post.new(post_params)

      @post.commentable = false unless @post.commentable
      @post.published = false unless @post.published
      @post.published_at = Time.now if @post.published

      if @post.save
        redirect_to '/blog/hq/dashboard'
      else
        render 'new'
      end
    end

    def edit
      @post = Kebapress::Post.find(params[:id])
    end

    def update
      @post = Kebapress::Post.find(params[:id])

      @post.commentable = false unless params[:commentable]
      @post.published = params[:post][:published] ? true : false
      @post.published_at ||= Time.now if @post.published

      @post.update(post_params)

      redirect_to '/blog/hq/dashboard'
    end

    def destroy
      @post = Kebapress::Post.find(params[:id])
      @post.destroy

      redirect_to '/blog/hq/dashboard'
    end

    private
      def post_params
        params.require(:post).permit(:title, :body, :published, :commentable, :tag_list)
      end
  end
end

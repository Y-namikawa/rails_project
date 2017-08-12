# coding utf-8

class BlogController < ApplicationController
	def index
		@blogs = Blog.all
		@new_blog = Blog.new
		@reply = Reply.group(:blog_id).count
		render 'blog/index'
	end

	def show
		@blog = Blog.find(params[:id])
		@new_reply = Reply.new
		@comments = Reply.where(blog_id: params[:id])
		render 'blog/show'
	end

	def like
		Blog.transaction do
		  Blog.where(id: params[:id]).update_all('like = like + 1')
		end
		redirect_back fallback_location: 'blog/index'

	end

	def create_blog
		Blog.transaction do
			Blog.create(param_blog)
		end
		redirect_back fallback_location: 'blog/index'
	end

	def create_reply
		Reply.transaction do
			Reply.create(comment: params[:reply][:comment], blog_id: params[:id])
		end
	end

	private

	def param_blog
		params.require(:blog).permit(:body, 0)
	end
end
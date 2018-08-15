module Articles
	class ArticlesController < BaseController
		before_action :set_resource, only: [:show, :edit, :update, :destroy, :editions, :show_edition, :restore]
		before_action :check_article_owner_rights!, only: [:show, :edit, :update, :destroy]
		before_action :decorate_resource, only: [:new, :show, :edit, :editions, :show_edition]

		def new
			@resource.article_editions << ArticleEdition.new(article: @resource, user: current_user)
			render "articles/new"
		end

		def create
			@resource.title = article_params[:title]
			@resource.key_words = article_params[:key_words]
			@resource.article_editions << ArticleEdition.new(article: @resource, user: current_user, content: article_params[:content], picture: article_params[:picture])

			if @resource.save
				flash[:notice] = "Artículo creado correctamente."
				redirect_to article_path(@resource)
			else
				set_errors_based_on_resource
				render "articles/new"
			end
		end

		def show
			render "articles/show"
		end

		def edit
			render "articles/edit"
		end

		def update
			if article_params[:title] || article_params[:key_words]
				if @has_current_user_article_owner_right
					unless @resource.update(title: article_params[:title], key_words: article_params[:key_words])
						set_errors_based_on_resource
						redirect_to edit_article_path(@resource)
					end
				else
					flash[:alert] = "Debes ser el creador del artículo o tener privilegios de webmaster para poder modificar el título o las palabras clave."
					redirect_to article_path(@resource)
				end
			end

			if article_params[:picture] || article_params[:content]
				unless @resource.article_editions << Articles::ArticleEdition.new(article: @resource, user: current_user, content: article_params[:content], picture: article_params[:picture])
					set_errors_based_on_resource
					redirect_to edit_article_path(@resource)
				end
			end

			flash[:notice] = "Artículo modificado correctamente."
			redirect_to article_path(@resource)
		end

		def destroy
			if @has_current_user_article_owner_right
				if @resource.destroy
					flash[:notice] = "Artículo eliminado correctamente."
					redirect_to root_path
				else
					set_errors_based_on_resource
					redirect_to article_path(@resource)
				end
			else
				flash[:alert] = "Debes ser el creador del artículo o tener privilegios de webmaster para poder eliminar este artículo."
				redirect_to root_path
			end
		end

		def editions
			render "articles/editions"
		end

		def show_edition
			render "articles/show_edition"
		end

		def restore

		end


		private

		def article_params
			params.require(:articles_article).permit(:title, :key_words, :content, :picture)
		end

		def check_article_owner_rights!
			user = current_user
			@has_current_user_article_owner_right = user.webmaster? || @resource.is_article_owner?(user)
		end

		def resource_type
			Article
		end

		def decorate_resource?
			true
		end

		def resource_not_found_msg
			"El artículo que intentas buscar no existe, intentelo de nuevo."
		end
	end
end
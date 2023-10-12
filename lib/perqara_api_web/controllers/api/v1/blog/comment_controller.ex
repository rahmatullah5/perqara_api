defmodule PerqaraApiWeb.BlogCommentController do
  use PerqaraApiWeb, :controller

  alias PerqaraApi.Blogs
  alias PerqaraApi.Blogs.BlogComment

  action_fallback(PerqaraApiWeb.FallbackController)

  def index(conn, %{"blog_id" => blog_id}) do
    blog_comments = Blogs.list_blog_comments(blog_id)

    render(conn, :index, blog_comments: blog_comments)
  end

  def create(conn, %{"blog_id" => blog_id, "comment" => blog_comment_params}) do
    with {:ok, %BlogComment{} = blog_comment} <-
           Blogs.create_blog_comment(blog_id, blog_comment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header(
        "location",
        ~p"/api/v1/blogs/#{blog_comment.blog}/comments/#{blog_comment}"
      )
      |> render(:show, blog_comment: blog_comment)
    end
  end

  def show(conn, %{"blog_id" => blog_id, "id" => id}) do
    Blogs.get_blog!(blog_id)

    blog_comment = Blogs.get_blog_comment!(id)

    render(conn, :show, blog_comment: blog_comment)
  end

  def update(conn, %{"blog_id" => blog_id, "id" => id, "comment" => blog_comment_params}) do
    Blogs.get_blog!(blog_id)

    blog_comment = Blogs.get_blog_comment!(id)

    with {:ok, %BlogComment{} = blog_comment} <-
           Blogs.update_blog_comment(blog_comment, blog_comment_params) do
      render(conn, :show, blog_comment: blog_comment)
    end
  end

  def delete(conn, %{"blog_id" => blog_id, "id" => id}) do
    Blogs.get_blog!(blog_id)

    blog_comment = Blogs.get_blog_comment!(id)

    with {:ok, %BlogComment{}} <- Blogs.delete_blog_comment(blog_comment) do
      send_resp(conn, :no_content, "")
    end
  end
end

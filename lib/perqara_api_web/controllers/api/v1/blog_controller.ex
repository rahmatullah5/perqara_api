defmodule PerqaraApiWeb.BlogController do
  use PerqaraApiWeb, :controller

  alias PerqaraApi.Blogs
  alias PerqaraApi.Blogs.Blog

  action_fallback(PerqaraApiWeb.FallbackController)

  def index(conn, _params) do
    blogs = Blogs.list_blogs()
    render(conn, :index, blogs: blogs)
  end

  def create(conn, %{"blog" => blog_params}) do
    with {:ok, %Blog{} = blog} <- Blogs.create_blog(blog_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/v1/blogs/#{blog}")
      |> render(:show, blog: blog)
    end
  end

  def show(conn, %{"id" => id}) do
    blog = Blogs.get_blog!(id)
    render(conn, :show, blog: blog)
  end

  def update(conn, %{"id" => id, "blog" => blog_params}) do
    blog = Blogs.get_blog!(id)

    with {:ok, %Blog{} = blog} <- Blogs.update_blog(blog, blog_params) do
      render(conn, :show, blog: blog)
    end
  end

  def delete(conn, %{"id" => id}) do
    blog = Blogs.get_blog!(id)

    with {:ok, %Blog{}} <- Blogs.delete_blog(blog) do
      send_resp(conn, :no_content, "")
    end
  end
end

defmodule PerqaraApiWeb.BlogJSON do
  alias PerqaraApi.Blogs.Blog

  @doc """
  Renders a list of blogs.
  """
  def index(%{blogs: blogs}) do
    %{data: for(blog <- blogs, do: data(blog))}
  end

  @doc """
  Renders a single blog.
  """
  def show(%{blog: blog}) do
    %{data: data(blog)}
  end

  defp data(%Blog{} = blog) do
    %{
      id: blog.id,
      author: blog.author,
      title: blog.title,
      content: blog.content
    }
  end
end

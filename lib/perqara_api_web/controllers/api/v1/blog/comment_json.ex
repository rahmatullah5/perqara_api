defmodule PerqaraApiWeb.BlogCommentJSON do
  alias PerqaraApi.Blogs.BlogComment

  @doc """
  Renders a list of blog_comments.
  """
  def index(%{blog_comments: blog_comments}) do
    %{data: for(blog_comment <- blog_comments, do: data(blog_comment))}
  end

  @doc """
  Renders a single blog_comment.
  """
  def show(%{blog_comment: blog_comment}) do
    %{data: data(blog_comment)}
  end

  defp data(%BlogComment{} = blog_comment) do
    %{
      id: blog_comment.id,
      content: blog_comment.content,
      author: blog_comment.author
    }
  end
end

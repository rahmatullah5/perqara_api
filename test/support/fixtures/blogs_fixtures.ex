defmodule PerqaraApi.BlogsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PerqaraApi.Blogs` context.
  """

  @doc """
  Generate a blog.
  """
  def blog_fixture(attrs \\ %{}) do
    {:ok, blog} =
      attrs
      |> Enum.into(%{
        author: "some author",
        content: "some content",
        title: "some title"
      })
      |> PerqaraApi.Blogs.create_blog()

    blog
  end

  @doc """
  Generate a blog_comment.
  """
  def blog_comment_fixture(attrs \\ %{}) do
    {:ok, blog_comment} =
      attrs
      |> Enum.into(%{
        author: "some author",
        blog_id: 42,
        content: "some content"
      })
      |> PerqaraApi.Blogs.create_blog_comment()

    blog_comment
  end
end

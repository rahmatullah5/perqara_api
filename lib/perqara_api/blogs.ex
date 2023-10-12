defmodule PerqaraApi.Blogs do
  @moduledoc """
  The Blogs context.
  """

  import Ecto.Query, warn: false
  alias PerqaraApi.Repo

  alias PerqaraApi.Blogs.Blog

  @doc """
  Returns the list of blogs.

  ## Examples

      iex> list_blogs()
      [%Blog{}, ...]

  """
  def list_blogs do
    Repo.all(Blog)
  end

  @doc """
  Gets a single blog.

  Raises `Ecto.NoResultsError` if the Blog does not exist.

  ## Examples

      iex> get_blog!(123)
      %Blog{}

      iex> get_blog!(456)
      ** (Ecto.NoResultsError)

  """
  def get_blog!(id), do: Repo.get!(Blog, id)

  @doc """
  Creates a blog.

  ## Examples

      iex> create_blog(%{field: value})
      {:ok, %Blog{}}

      iex> create_blog(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_blog(attrs \\ %{}) do
    %Blog{}
    |> Blog.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a blog.

  ## Examples

      iex> update_blog(blog, %{field: new_value})
      {:ok, %Blog{}}

      iex> update_blog(blog, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_blog(%Blog{} = blog, attrs) do
    blog
    |> Blog.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a blog.

  ## Examples

      iex> delete_blog(blog)
      {:ok, %Blog{}}

      iex> delete_blog(blog)
      {:error, %Ecto.Changeset{}}

  """
  def delete_blog(%Blog{} = blog) do
    Repo.delete(blog)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking blog changes.

  ## Examples

      iex> change_blog(blog)
      %Ecto.Changeset{data: %Blog{}}

  """
  def change_blog(%Blog{} = blog, attrs \\ %{}) do
    Blog.changeset(blog, attrs)
  end

  alias PerqaraApi.Blogs.BlogComment

  @doc """
  Returns the list of blog_comments.

  ## Examples

      iex> list_blog_comments()
      [%BlogComment{}, ...]

  """
  def list_blog_comments() do
    Repo.all(BlogComment)
  end

  def list_blog_comments(blog_id) do
    get_blog!(blog_id)
    |> Repo.preload(:comments)
    |> Map.get(:comments, [])
  end

  @doc """
  Gets a single blog_comment.

  Raises `Ecto.NoResultsError` if the Blog comment does not exist.

  ## Examples

      iex> get_blog_comment!(123)
      %BlogComment{}

      iex> get_blog_comment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_blog_comment!(id), do: Repo.get!(BlogComment, id)

  @doc """
  Creates a blog_comment.

  ## Examples

      iex> create_blog_comment(%{field: value})
      {:ok, %BlogComment{}}

      iex> create_blog_comment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_blog_comment(attrs \\ %{}) do
    %BlogComment{}
    |> BlogComment.changeset(attrs)
    |> Repo.insert()
  end

  def create_blog_comment(blog_id, attrs) do
    %BlogComment{}
    |> BlogComment.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:blog, get_blog!(blog_id))
    |> Repo.insert()
  end

  @doc """
  Updates a blog_comment.

  ## Examples

      iex> update_blog_comment(blog_comment, %{field: new_value})
      {:ok, %BlogComment{}}

      iex> update_blog_comment(blog_comment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_blog_comment(%BlogComment{} = blog_comment, attrs) do
    blog_comment
    |> BlogComment.changeset(attrs)
    |> Repo.update()
  end

  def update_blog_comment(blog_id, %BlogComment{} = blog_comment, attrs) do
    blog_comment
    |> BlogComment.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:blog, get_blog!(blog_id))
    |> Repo.update()
  end

  @doc """
  Deletes a blog_comment.

  ## Examples

      iex> delete_blog_comment(blog_comment)
      {:ok, %BlogComment{}}

      iex> delete_blog_comment(blog_comment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_blog_comment(%BlogComment{} = blog_comment) do
    Repo.delete(blog_comment)
  end

  def delete_blog_comment(blog_id, %BlogComment{} = blog_comment) do
    get_blog!(blog_id)

    Repo.delete(blog_comment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking blog_comment changes.

  ## Examples

      iex> change_blog_comment(blog_comment)
      %Ecto.Changeset{data: %BlogComment{}}

  """
  def change_blog_comment(%BlogComment{} = blog_comment, attrs \\ %{}) do
    BlogComment.changeset(blog_comment, attrs)
  end
end

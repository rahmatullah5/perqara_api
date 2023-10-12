defmodule PerqaraApi.Blogs.BlogComment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "blog_comments" do
    field(:author, :string)
    field(:content, :string)

    belongs_to(:blog, PerqaraApi.Blogs.Blog)

    timestamps()
  end

  @doc false
  def changeset(blog_comment, attrs) do
    blog_comment
    |> cast(attrs, [:content, :author])
    |> validate_required([:content, :author])
  end
end

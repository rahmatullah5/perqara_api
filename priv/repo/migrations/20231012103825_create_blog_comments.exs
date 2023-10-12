defmodule PerqaraApi.Repo.Migrations.CreateBlogComments do
  use Ecto.Migration

  def change do
    create table(:blog_comments) do
      add :content, :text
      add :blog_id, :integer
      add :author, :string

      timestamps()
    end
  end
end

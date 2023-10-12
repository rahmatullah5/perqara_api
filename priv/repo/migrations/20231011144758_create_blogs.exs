defmodule PerqaraApi.Repo.Migrations.CreateBlogs do
  use Ecto.Migration

  def change do
    create table(:blogs) do
      add :author, :string
      add :title, :string
      add :content, :text

      timestamps()
    end
  end
end

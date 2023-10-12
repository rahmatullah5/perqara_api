defmodule PerqaraApi.BlogsTest do
  use PerqaraApi.DataCase

  alias PerqaraApi.Blogs

  describe "blogs" do
    alias PerqaraApi.Blogs.Blog

    import PerqaraApi.BlogsFixtures

    @invalid_attrs %{content: nil, title: nil}

    test "list_blogs/0 returns all blogs" do
      blog = blog_fixture()
      assert Blogs.list_blogs() == [blog]
    end

    test "get_blog!/1 returns the blog with given id" do
      blog = blog_fixture()
      assert Blogs.get_blog!(blog.id) == blog
    end

    test "create_blog/1 with valid data creates a blog" do
      valid_attrs = %{content: "some content", author: "some author", title: "some title"}

      assert {:ok, %Blog{} = blog} = Blogs.create_blog(valid_attrs)
      assert blog.content == "some content"
      assert blog.author == "some author"
      assert blog.title == "some title"
    end

    test "create_blog/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blogs.create_blog(@invalid_attrs)
    end

    test "update_blog/2 with valid data updates the blog" do
      blog = blog_fixture()

      update_attrs = %{
        content: "some updated content",
        author: "some updated author",
        title: "some updated title"
      }

      assert {:ok, %Blog{} = blog} = Blogs.update_blog(blog, update_attrs)
      assert blog.content == "some updated content"
      assert blog.title == "some updated title"
    end

    test "update_blog/2 with invalid data returns error changeset" do
      blog = blog_fixture()
      assert {:error, %Ecto.Changeset{}} = Blogs.update_blog(blog, @invalid_attrs)
      assert blog == Blogs.get_blog!(blog.id)
    end

    test "delete_blog/1 deletes the blog" do
      blog = blog_fixture()
      assert {:ok, %Blog{}} = Blogs.delete_blog(blog)
      assert_raise Ecto.NoResultsError, fn -> Blogs.get_blog!(blog.id) end
    end

    test "change_blog/1 returns a blog changeset" do
      blog = blog_fixture()
      assert %Ecto.Changeset{} = Blogs.change_blog(blog)
    end
  end

  describe "blog_comments" do
    alias PerqaraApi.Blogs.BlogComment

    import PerqaraApi.BlogsFixtures

    @invalid_attrs %{author: nil, blog_id: nil, content: nil}

    test "list_blog_comments/0 returns all blog_comments" do
      blog_comment = blog_comment_fixture()
      assert Blogs.list_blog_comments() == [blog_comment]
    end

    test "get_blog_comment!/1 returns the blog_comment with given id" do
      blog_comment = blog_comment_fixture()
      assert Blogs.get_blog_comment!(blog_comment.id) == blog_comment
    end

    test "create_blog_comment/1 with valid data creates a blog_comment" do
      blog = blog_fixture()

      valid_attrs = %{
        author: "some author",
        blog_id: blog.id,
        content: "some content"
      }

      assert {:ok, %BlogComment{} = blog_comment} =
               Blogs.create_blog_comment(blog.id, valid_attrs)

      assert blog_comment.author == "some author"
      assert blog_comment.blog_id == blog.id
      assert blog_comment.content == "some content"
    end

    test "create_blog_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blogs.create_blog_comment(@invalid_attrs)
    end

    test "update_blog_comment/2 with valid data updates the blog_comment" do
      blog_comment = blog_comment_fixture()

      update_attrs = %{
        author: "some updated author",
        content: "some updated content"
      }

      assert {:ok, %BlogComment{} = blog_comment} =
               Blogs.update_blog_comment(blog_comment, update_attrs)

      assert blog_comment.author == "some updated author"
      assert blog_comment.content == "some updated content"
    end

    test "update_blog_comment/2 with invalid data returns error changeset" do
      blog = blog_fixture()
      blog_comment = blog_comment_fixture(%{blog_id: blog.id})

      assert {:error, %Ecto.Changeset{}} = Blogs.update_blog_comment(blog_comment, @invalid_attrs)

      assert blog_comment == Blogs.get_blog_comment!(blog_comment.id)
    end

    test "delete_blog_comment/1 deletes the blog_comment" do
      blog = blog_fixture()
      blog_comment = blog_comment_fixture(%{blog_id: blog.id})
      assert {:ok, %BlogComment{}} = Blogs.delete_blog_comment(blog_comment)
      assert_raise Ecto.NoResultsError, fn -> Blogs.get_blog_comment!(blog_comment.id) end
    end

    test "change_blog_comment/1 returns a blog_comment changeset" do
      blog_comment = blog_comment_fixture()
      assert %Ecto.Changeset{} = Blogs.change_blog_comment(blog_comment)
    end
  end
end

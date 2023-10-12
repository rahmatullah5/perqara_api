defmodule PerqaraApiWeb.BlogCommentControllerTest do
  use PerqaraApiWeb.ConnCase

  import PerqaraApi.BlogsFixtures

  alias PerqaraApi.Blogs.BlogComment

  @blog_attrs %{
    author: "some author",
    content: "some content",
    title: "some title"
  }
  @create_attrs %{
    author: "some author",
    content: "some content"
  }
  @update_attrs %{
    author: "some updated author",
    content: "some updated content"
  }
  @invalid_attrs %{author: nil, blog_id: nil, content: nil}

  setup %{conn: conn} do
    blog = blog_fixture(@blog_attrs)
    {:ok, conn: put_req_header(conn, "accept", "application/json"), blog: blog}
  end

  describe "index" do
    test "lists all blog_comments", %{conn: conn, blog: blog} do
      conn = get(conn, ~p"/api/v1/blogs/#{blog.id}/comments")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create blog_comment" do
    test "renders blog_comment when data is valid", %{conn: conn, blog: blog} do
      conn = post(conn, ~p"/api/v1/blogs/#{blog.id}/comments", comment: @create_attrs)

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/v1/blogs/#{blog.id}/comments/#{id}")

      assert %{
               "id" => ^id,
               "author" => "some author",
               "content" => "some content"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, blog: blog} do
      conn = post(conn, ~p"/api/v1/blogs/#{blog.id}/comments", comment: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update blog_comment" do
    setup [:create_blog_comment]

    test "renders blog_comment when data is valid", %{
      conn: conn,
      blog_comment: %BlogComment{id: id} = blog_comment,
      blog: blog
    } do
      conn =
        put(conn, ~p"/api/v1/blogs/#{blog.id}/comments/#{blog_comment}", comment: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/v1/blogs/#{blog.id}/comments/#{id}")

      assert %{
               "id" => ^id,
               "author" => "some updated author",
               "content" => "some updated content"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{
      conn: conn,
      blog_comment: blog_comment,
      blog: blog
    } do
      conn =
        put(conn, ~p"/api/v1/blogs/#{blog.id}/comments/#{blog_comment}", comment: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete blog_comment" do
    setup [:create_blog_comment]

    test "deletes chosen blog_comment", %{conn: conn, blog_comment: blog_comment, blog: blog} do
      conn = delete(conn, ~p"/api/v1/blogs/#{blog.id}/comments/#{blog_comment}")
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, ~p"/api/v1/blogs/#{blog.id}/comments/#{blog_comment}")
      end)
    end
  end

  defp create_blog_comment(_) do
    blog = blog_fixture(@blog_attrs)
    blog_comment = blog_comment_fixture(%{blog_id: blog.id})
    %{blog_comment: blog_comment, blog: blog}
  end
end

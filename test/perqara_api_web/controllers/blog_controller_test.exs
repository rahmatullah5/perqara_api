defmodule PerqaraApiWeb.BlogControllerTest do
  use PerqaraApiWeb.ConnCase

  import PerqaraApi.BlogsFixtures

  alias PerqaraApi.Blogs.Blog

  @create_attrs %{
    content: "some content",
    author: "some author",
    title: "some title"
  }
  @update_attrs %{
    content: "some updated content",
    author: "some updated author",
    title: "some updated title"
  }
  @invalid_attrs %{content: nil, title: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all blogs", %{conn: conn} do
      conn = get(conn, ~p"/api/v1/blogs")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create blog" do
    test "renders blog when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/v1/blogs", blog: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/v1/blogs/#{id}")

      assert %{
               "id" => ^id,
               "content" => "some content",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/v1/blogs", blog: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update blog" do
    setup [:create_blog]

    test "renders blog when data is valid", %{conn: conn, blog: %Blog{id: id} = blog} do
      conn = put(conn, ~p"/api/v1/blogs/#{blog}", blog: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/v1/blogs/#{id}")

      assert %{
               "id" => ^id,
               "content" => "some updated content",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, blog: blog} do
      conn = put(conn, ~p"/api/v1/blogs/#{blog}", blog: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete blog" do
    setup [:create_blog]

    test "deletes chosen blog", %{conn: conn, blog: blog} do
      conn = delete(conn, ~p"/api/v1/blogs/#{blog}")
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, ~p"/api/v1/blogs/#{blog}")
      end)
    end
  end

  defp create_blog(_) do
    blog = blog_fixture()
    %{blog: blog}
  end
end

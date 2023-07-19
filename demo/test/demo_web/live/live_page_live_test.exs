defmodule DemoWeb.LivePageLiveTest do
  use DemoWeb.ConnCase

  import Phoenix.LiveViewTest
  import Demo.PagesFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_live_page(_) do
    live_page = live_page_fixture()
    %{live_page: live_page}
  end

  describe "Index" do
    setup [:create_live_page]

    test "lists all pages", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.live_page_index_path(conn, :index))

      assert html =~ "Listing Pages"
    end

    test "saves new live_page", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.live_page_index_path(conn, :index))

      assert index_live |> element("a", "New Live page") |> render_click() =~
               "New Live page"

      assert_patch(index_live, Routes.live_page_index_path(conn, :new))

      assert index_live
             |> form("#live_page-form", live_page: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#live_page-form", live_page: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.live_page_index_path(conn, :index))

      assert html =~ "Live page created successfully"
    end

    test "updates live_page in listing", %{conn: conn, live_page: live_page} do
      {:ok, index_live, _html} = live(conn, Routes.live_page_index_path(conn, :index))

      assert index_live |> element("#live_page-#{live_page.id} a", "Edit") |> render_click() =~
               "Edit Live page"

      assert_patch(index_live, Routes.live_page_index_path(conn, :edit, live_page))

      assert index_live
             |> form("#live_page-form", live_page: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#live_page-form", live_page: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.live_page_index_path(conn, :index))

      assert html =~ "Live page updated successfully"
    end

    test "deletes live_page in listing", %{conn: conn, live_page: live_page} do
      {:ok, index_live, _html} = live(conn, Routes.live_page_index_path(conn, :index))

      assert index_live |> element("#live_page-#{live_page.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#live_page-#{live_page.id}")
    end
  end

  describe "Show" do
    setup [:create_live_page]

    test "displays live_page", %{conn: conn, live_page: live_page} do
      {:ok, _show_live, html} = live(conn, Routes.live_page_show_path(conn, :show, live_page))

      assert html =~ "Show Live page"
    end

    test "updates live_page within modal", %{conn: conn, live_page: live_page} do
      {:ok, show_live, _html} = live(conn, Routes.live_page_show_path(conn, :show, live_page))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Live page"

      assert_patch(show_live, Routes.live_page_show_path(conn, :edit, live_page))

      assert show_live
             |> form("#live_page-form", live_page: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#live_page-form", live_page: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.live_page_show_path(conn, :show, live_page))

      assert html =~ "Live page updated successfully"
    end
  end
end

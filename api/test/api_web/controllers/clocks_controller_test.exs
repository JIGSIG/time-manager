defmodule ApiWeb.ClocksControllerTest do
  use ApiWeb.ConnCase

  import Api.ClockDirectoryFixtures

  alias Api.ClockDirectory.Clocks

  @create_attrs %{
    status: true,
    time: ~N[2021-10-26 11:28:00]
  }
  @update_attrs %{
    status: false,
    time: ~N[2021-10-27 11:28:00]
  }
  @invalid_attrs %{status: nil, time: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all clock", %{conn: conn} do
      conn = get(conn, Routes.clocks_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create clocks" do
    test "renders clocks when data is valid", %{conn: conn} do
      conn = post(conn, Routes.clocks_path(conn, :create), clocks: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.clocks_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "status" => true,
               "time" => "2021-10-26T11:28:00"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.clocks_path(conn, :create), clocks: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update clocks" do
    setup [:create_clocks]

    test "renders clocks when data is valid", %{conn: conn, clocks: %Clocks{id: id} = clocks} do
      conn = put(conn, Routes.clocks_path(conn, :update, clocks), clocks: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.clocks_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "status" => false,
               "time" => "2021-10-27T11:28:00"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, clocks: clocks} do
      conn = put(conn, Routes.clocks_path(conn, :update, clocks), clocks: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete clocks" do
    setup [:create_clocks]

    test "deletes chosen clocks", %{conn: conn, clocks: clocks} do
      conn = delete(conn, Routes.clocks_path(conn, :delete, clocks))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.clocks_path(conn, :show, clocks))
      end
    end
  end

  defp create_clocks(_) do
    clocks = clocks_fixture()
    %{clocks: clocks}
  end
end

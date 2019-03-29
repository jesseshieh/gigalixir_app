defmodule GigalixirPhoenixWeb.RoomChannel do
  use GigalixirPhoenixWeb, :channel
  @greeting "Hello"

  def join(_, _params, socket) do
    send(self(), :counter)
    socket =
      socket
      |> assign(:greeting, @greeting)
      |> assign(:timer, 0)
    {:ok, socket}
  end

  def handle_info(:counter, %{assigns: %{timer: timer, greeting: greeting}} = socket) do
    Process.send_after(self(), :counter, 1000)
    timer = timer + 1
    push(socket, "count", %{timer: timer, greeting: greeting})
    {:noreply, assign(socket, :timer, timer)}
  end
end
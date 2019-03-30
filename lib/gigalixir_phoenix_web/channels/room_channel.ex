defmodule GigalixirPhoenixWeb.RoomChannel do
  use GigalixirPhoenixWeb, :channel
  import Logger

  defp greeting do 
    "Hey!"
  end

  def join(_, _params, socket) do
    Logger.debug "v2 join called"
    send(self(), :counter)
    socket =
      socket
      |> assign(:greeting, greeting())
      |> assign(:timer, 0)
    {:ok, socket}
  end

  def handle_info(:counter, %{assigns: %{timer: timer, greeting: greeting}} = socket) do
    Logger.debug "v2 counter called with #{timer} and #{greeting}"
    Process.send_after(self(), :counter, 1000)
    timer = timer + 1
    push(socket, "count", %{timer: timer, greeting: greeting})
    {:noreply, assign(socket, :timer, timer)}
  end

  def code_change(_old_vsn, socket, _extra) do
    Logger.debug "v2 code_change called"
    {:ok, assign(socket, :greeting, greeting())}
  end
end

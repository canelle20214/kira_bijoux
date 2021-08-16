defmodule KiraBijouxWeb.CreatePageView do
  use KiraBijouxWeb, :view

   def render(conn, "show.json", %{page: page}) do
     conn
     |> json(page_construction(page))
   end

   def render(conn, "index.json", %{pages: pages}) do
     pages = Enum.map(pages, & page_construction(&1))
     conn
     |> json(pages)
   end

   def page_construction(page) do
     Map.new(id: page.id)
     |> Map.put(:name, page.name)
     |> Map.put(:visibility, page.visibility)
     |> Map.put(:inserted_at, page.inserted_at)
     |> Map.put(:updated_at, page.updated_at)
   end
 end

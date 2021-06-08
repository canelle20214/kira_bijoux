defmodule KiraBijouxWeb.NewsletterView do
  use KiraBijouxWeb, :view

  def render(conn, "index.json", %{newsletter: newsletter}) do
    conn
    |> json(newsletter_construction(newsletter))
  end

  def render(conn, "index.json", %{newsletters: newsletters}) do
    newsletters = Enum.map(newsletters, & newsletter_construction(&1))
    conn
    |> json(newsletters)
  end

  def newsletter_construction(newsletter) do
    Map.new(id: newsletter.id)
    |> Map.put(:name, newsletter.name)
    |> Map.put(:object, newsletter.object)
    |> Map.put(:content, newsletter.content)
    |> Map.put(:inserted_at, newsletter.inserted_at)
    |> Map.put(:updated_at, newsletter.updated_at)
  end
end

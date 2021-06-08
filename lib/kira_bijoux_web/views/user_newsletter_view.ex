defmodule KiraBijouxWeb.UserNewsletterView do
  use KiraBijouxWeb, :view

  def render(conn, "index.json", %{user_newsletter: user_newsletter}) do
    conn
    |> json(user_newsletter_construction(user_newsletter))
  end

  def render(conn, "index.json", %{user_newsletters: user_newsletters}) do
    user_newsletters = Enum.map(user_newsletters, & user_newsletter_construction(&1))
    conn
    |> json(user_newsletters)
  end

  def user_newsletter_construction(user_newsletter) do
    Map.new(id: user_newsletter.id)
    |> Map.put(:user_id, user_newsletter.user_id)
    |> Map.put(:newsletter_id, user_newsletter.newsletter_id)
    |> Map.put(:item_id, user_newsletter.item_id)
    |> Map.put(:mail, user_newsletter.mail)
    |> Map.put(:inserted_at, user_newsletter.inserted_at)
    |> Map.put(:updated_at, user_newsletter.updated_at)
  end
end

defmodule KiraBijouxWeb.ArticleView do
  use KiraBijouxWeb, :view

  def render(conn, "index.json", %{article: article}) do
    conn
    |> json(article_construction(article))
  end

  def render(conn, "index.json", %{articles: articles}) do
    articles = Enum.map(articles, & article_construction(&1))
    conn
    |> json(articles)
  end

  def article_construction(article) do
    page = Repo.get!(Page, article.page_id)
    |> KiraBijouxWeb.CreatePageView.page_construction()
    Map.new(id: article.id)
    |> Map.put(:name, article.name)
    |> Map.put(:content, article.content)
    |> Map.put(:page, page)
    |> Map.put(:place, article.place)
    |> Map.put(:inserted_at, article.inserted_at)
    |> Map.put(:updated_at, article.updated_at)
  end
end

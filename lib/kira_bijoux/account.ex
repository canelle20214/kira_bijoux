defmodule KiraBijoux.Accounts do
  import Ecto.Query, warn: false
  alias KiraBijoux.Repo

  alias KiraBijoux.User

  def get_by_email(mail) when is_nil(mail) do
    nil
  end
  def get_by_email(mail) do
    Repo.get_by(User, mail: mail)
  end
end

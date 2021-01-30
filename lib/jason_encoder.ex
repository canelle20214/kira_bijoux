alias KiraBijoux.User
alias KiraBijoux.Item
alias KiraBijoux.Material.Item
alias KiraBijoux.Collection


defimpl Jason.Encoder, for: [User, User.Address, User.Role, Item, Item.Parent, 
  Item.Type, Collection, Material.Item] do
  def encode(%{__struct__: _} = struct, options) do
      map = struct
      |> Map.from_struct
      |> sanitize_map
      Jason.Encoder.Map.encode(map, options)
  end

  defp sanitize_map(map) do
      Map.drop(map, [:__meta__, :__struct__])
  end
end
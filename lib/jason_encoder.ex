alias KiraBijoux.User
alias KiraBijoux.User.Address
alias KiraBijoux.User.Role

alias KiraBijoux.Item
alias KiraBijoux.Material.Item
alias KiraBijoux.Item.Parent
alias KiraBijoux.Item.Type
alias KiraBijoux.Collection

### Jason Encoder for User

# Protocole Jason Encoder pour la structure User
defimpl Jason.Encoder, for: User do
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

# Protocole Jason Encoder pour la structure User.Address
defimpl Jason.Encoder, for: User.Address do
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

# Protocole Jason Encoder pour la structure User.Role
defimpl Jason.Encoder, for: User.Role do
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

### Jason Encoder for Items

# Protocole Jason Encoder pour la structure Item
defimpl Jason.Encoder, for: Item do
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



# Protocole Jason Encoder pour la structure Material.Item
defimpl Jason.Encoder, for: Material.Item do
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

# Protocole Jason Encoder pour la structure Item.Parent
defimpl Jason.Encoder, for: Item.Parent do
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

# Protocole Jason Encoder pour la structure Item.Type
defimpl Jason.Encoder, for: Item.Type do
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

# Protocole Jason Encoder pour la structure Collection
defimpl Jason.Encoder, for: Collection do
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
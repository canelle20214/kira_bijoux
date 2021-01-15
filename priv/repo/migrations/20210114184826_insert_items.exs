defmodule KiraBijoux.Repo.Migrations.InsertItems do
  use KiraBijouxWeb, :migration

  def change do
    Repo.insert(%Item{item_parent_id: 1, price: 37.00, stock: 5, visibility: true, description: "Ras le cou Pique \n35 cm + 5 cm extension"})
    Repo.insert(%Item{item_parent_id: 2, price: 68.00, stock: 0, visibility: true, description: "Collier perles \n37 cm + 5 cm extension"})
    Repo.insert(%Item{item_parent_id: 3, price: 38.00, stock: 10, visibility: true, description: "Collier pendentuf lune \n38 cm"})
    Repo.insert(%Item{item_parent_id: 4, price: 42.00, stock: 10, visibility: true, description: "Collier pendentif flèche \n38 cm"})
    Repo.insert(%Item{item_parent_id: 5, price: 45.00, stock: 10, visibility: true, description: "Collier pendentif pierre \n40 cm"})
    Repo.insert(%Item{item_parent_id: 6, price: 42.00, stock: 0, visibility: true, description: "Collier pendentif médaille ajourée \n40 cm"})
    Repo.insert(%Item{item_parent_id: 7, price: 39.00, stock: 1, visibility: true, description: "Collier pendentif médaille martelée \n45 cm"})
    Repo.insert(%Item{item_parent_id: 8, price: 45.00, stock: 4, visibility: true, description: "Collier pendentif pierre \n50cm"})
    Repo.insert(%Item{item_parent_id: 8, price: 45.00, stock: 6, visibility: true, description: "Collier pendentif pierre \n50cm"})
    Repo.insert(%Item{item_parent_id: 8, price: 45.00, stock: 6, visibility: true, description: "Collier pendentif pierre \n50cm"})
    Repo.insert(%Item{item_parent_id: 8, price: 45.00, stock: 0, visibility: true, description: "Collier pendentif pierre \n50cm"})
    Repo.insert(%Item{item_parent_id: 8, price: 45.00, stock: 0, visibility: true, description: "Collier pendentif pierre \n50cm"})
    Repo.insert(%Item{item_parent_id: 8, price: 45.00, stock: 1, visibility: true, description: "Collier pendentif pierre \n50cm"})
    Repo.insert(%Item{item_parent_id: 9, price: 24.00, stock: 5, visibility: true, description: "Médaille martelée \n17,5 cm"})
    Repo.insert(%Item{item_parent_id: 10, price: 26.00, stock: 2, visibility: true, description: "Pendants Œil de chat \n2 cm"})

  end
end

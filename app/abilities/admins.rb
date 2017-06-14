Canard::Abilities.for(:admin) do
  can [:create, :destroy], User
end

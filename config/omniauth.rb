use OmniAuth::Builder do
  provider :identity, :fields => [:email]
end

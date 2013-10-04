json.array!(@products) do |product|
  json.extract! product, :pro_name, :amount
  json.url product_url(product, format: :json)
end

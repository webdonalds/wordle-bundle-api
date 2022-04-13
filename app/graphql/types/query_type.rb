module Types
  class QueryType < Types::Base::Object
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :test_field, String

    def test_field
      "Hello, world!"
    end
  end
end

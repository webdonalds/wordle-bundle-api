module Types
  class QueryType < Types::Base::Object
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField
  end
end

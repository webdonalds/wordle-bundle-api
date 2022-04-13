module Mutations
  class CreateApiToken < GraphQL::Schema::Mutation
    argument :provider, Types::Enums::AuthenticationProvider
    argument :id_token, String

    field :access_key, String
    field :refresh_key, String
    field :expire_at, GraphQL::Types::ISO8601DateTime

    def resolve(provider:, id_token:)
      clazz          = "UserAuthentications::#{provider.to_s.classify}".constantize
      authentication = clazz.find_or_create_by_id_token!(id_token)
      token          = ApiToken.create_with_user!(authentication.user)
      {
        access_key:  token.access_key,
        refresh_key: token.refresh_key,
        expire_at:   token.expire_at,
      }
    end
  end
end

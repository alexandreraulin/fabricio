require 'fabricio/networking/version_request_model_factory'
require 'fabricio/networking/network_client'

module Fabricio
  module Service
    # Service responsible for fetching different Version information
    class VersionService

      # Initializes a new BuildService object.
      #
      # @param param_storage [Fabricio::Authorization::AbstractParamStorage]
      # @param network_client [Fabricio::Networking::NetworkClient]
      # @return [Fabricio::Service::BuildService]
      def initialize(param_storage, network_client)
        @request_model_factory = Fabricio::Networking::VersionRequestModelFactory.new(param_storage)
        @network_client = network_client
      end

      # Obtains an array of all versions for a given app
      #
      # @param app_id [String] Application identifier
      # @param page [Int]
      # @param per_page [Int]
      # @return [Array<String>]
      def all(options = {})
        request_model = @request_model_factory.all_versions_request_model(options)
        response = @network_client.perform_request(request_model)
        JSON.parse(response.body)
      end

      # Obtains an array of top versions for a given app
      #
      # @param organization_id [String] Organization identifier
      # @param app_id [String] Application identifier
      # @param start_time [String] Timestamp of the start date
      # @param end_time [String] Timestamp of the end date
      # @return [Array<String>]
      def top(options = {})
        request_model = @request_model_factory.top_versions_request_model(options)
        response = @network_client.perform_request(request_model)
        JSON.parse(response.body)['builds']
      end
    end
  end
end

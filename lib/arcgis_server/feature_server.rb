require 'open-uri'

module ArcgisServer
  class FeatureServer
    include Her::Model

    collection_path 'rest/services?f=json'
    resource_path 'rest/services/:name/FeatureServer?f=json'

    primary_key 'name'

    has_many :layers,
      class_name: "ArcgisServer::Layer",
      path: 'rest/services/:feature_service_name/FeatureServer/layers/:layer_id',
      data_key: nil

    class << self
      alias :_new_collection :new_collection

      def new_collection(parsed_data)
        # Un-nest the response object
        services = parsed_data[:data][:services]
         
        # Select only services of FeatureServer type
        feature_services = services.select{|item| item[:type] == "FeatureServer"}

        # Iterate through services and hit the FeatureServer endpoint
        parsed_data[:data] = feature_services.map{|item|
          self.find(URI::encode(item[:name])).attributes
        }

        # Generate a collection of FeatureServers.
        _new_collection(parsed_data)
      end
    end
  end
end

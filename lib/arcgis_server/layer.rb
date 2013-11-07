module ArcgisServer
  class Layer
    include Her::Model

    collection_path 'rest/services/:feature_server_name/FeatureServer/layers?f=json'
    resource_path 'rest/services/:feature_server_name/FeatureServer/layers/:id?f=json'

    parse_root_in_json true, :format => :active_model_serializers

    class << self
      alias :_parse :parse

      def parse(data)
        _parse(self.name => data.first)
      end
    end
  end
end

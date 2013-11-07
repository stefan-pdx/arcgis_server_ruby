module ArcgisServer
  class Catalog
    attr_accessor :api

    def initialize(host, instance_name)
      @api = Her::API.new

      uri = URI::join(host, instance_name)

      @api.setup url: uri do |connection|
        connection.use Faraday::Request::UrlEncoded
        connection.use Her::Middleware::DefaultParseJSON
        connection.use Faraday::Adapter::NetHttp
      end

      [[:feature_server, "ArcgisServer::FeatureServer"],
       [:layer, "ArcgisServer::Layer"]].each do |attr_name, classname|

        # Create an anonymous class that inherits from our model
        klass = classname.constantize
        instance_variable_set("@#{attr_name}", Class.new(klass))

        # Attach api context to this anonymous class
        attr = instance_variable_get("@#{attr_name}")
        self.class.send(:attr_accessor, attr_name)
        attr.use_api(@api)
        attr.collection_path klass.collection_path
        attr.resource_path klass.resource_path
        self.class.const_set("#{classname.split(":").last}#{attr.hash.abs}", attr)
      end
    end
  end
end

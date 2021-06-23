# OpenTelemetry Ruby Example

## HTTP

This is a simple example that demonstrates tracing an HTTP request from client to server. The example shows several aspects of tracing, such as:

* Using the `TracerProvider`
* Span Attributes
* Using the console exporter

### Running the example

1. Install gems
  * `bundle install`
1. Start the server from the `examples/http` directory
	* `./server.rb`
1. In a separate terminal window, run the client to make a single request:
	* `./client.rb`
1. You should see console exporter output for both the client and server sessions.



#running the tests for xtray(might not have needed the GEM_HOME):
GEM_HOME=/Users/scar/workspace/repos/3rdparty/opentelemetry-ruby/propagator/xray/vendor/bundle/ bundle exec rake


EXAMPLE FROM AWS:
1-5960082b-ab52431b496add878434aa25
1-594aed87-ad72e26896b3f9d3a27054bb
EXAMPLE GENERATED:
1-70b1b44d-b3bffd2bbc0c70323d231355
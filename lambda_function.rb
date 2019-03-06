require 'json'
require 'aws-sdk-s3'

def lambda_handler(event:, context:)
  zip = event["pathParameters"]["zipCode"]
  subZip = zip[0, 3]

  client = Aws::S3::Client.new

  s = client.get_object(:bucket => 'zipcode-jp',
		:key => "#{subZip}/#{zip}.json").body.read
  { statusCode: 200, body: s }
end

if __FILE__ == $0
  event = {"method" => 'GET', "pathParameters" => {"zipCode" => '0010000'}}
  lambda_handler(:event => event, :context => {})
end

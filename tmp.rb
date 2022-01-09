require 'aws-sdk-s3'
require 'tmpdir'

Dir.mktmpdir{ |dir| 
    s3_client = Aws::S3::Client.new(region: "ap-northeast-1")
    objects = s3_client.list_objects_v2(
        bucket: "bucket",
        prefix: ""
    ).contents

    objects.each do |object|
        if object.key.end_with?(".jpg")
            s3_client.get_object(
                response_target: "#{dir}/#{object.key}", 
                bucket: "bucket",
                key: object.key
            )
        end
    end

    Dir.glob("*.jpg").each do |image|
        p image
    end
}
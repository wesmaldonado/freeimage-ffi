require 'test_helper'

img = FreeImage::FFI.FreeImage_Load( FreeImage::Format::JPEG, '../test/data/test-jpg.jpg', FreeImage::Flags::JPEG_DEFAULT)

1 == FreeImage::FFI.FreeImage_FIFSupportsICCProfiles(FreeImage::Format::JPEG)

profile_pointer =  FreeImage::FFI.FreeImage_GetICCProfile(img)
icc_profile = FreeImage::FFI::ICCProfile.new(profile)
# >> p[:size]
# => 0
# >> p[:flags]
# => 0
# >> p[:data]
# >> p[:data].null?
# => true
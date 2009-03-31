require 'test_helper'

BYTES_TO_READ = 0  # 0 is a default for all types

fif = FreeImage::FFI.FreeImage_GetFileType('data/test-jpg.jpg', BYTES_TO_READ)
1 == FreeImage::FFI.FreeImage_FIFSupportsReading(fif)
1 == FreeImage::FFI.FreeImage_FIFSupportsWriting(fif)
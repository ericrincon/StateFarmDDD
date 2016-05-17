require 'xlua'
require 'lfs'
require 'image'

local publicClass={}

function publicClass.get_files(path)
  local files = {}

  local i = 1

  for file in lfs.dir(path) do
    -- Make sure to filter away Max OSX dir files
    if not (file == ('.' or  '..' or '.DS_STORE')) then
      files[i] = path .. '/' .. file
    end
  end

  return files
end


function publicClass.get_images(path)
  local folders = get_files(path)
  local classes = {}
  local class_i = 1

  for folder in folders do
    local image_files = get_files(folder)
    local class = {}
    local image_file_i

    for image_file in image_files do
      class[image_file_i] = image.load(image_file)
      image_file_i += 1
    end

    class[class_i] = class
    class_i += 1
  end

  return classes

end

return publicClass

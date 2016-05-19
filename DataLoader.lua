require 'xlua'
require 'lfs'
require 'image'
require 'table'
pl = require 'pl.utils'

local publicClass={}

function publicClass.get_dir_items(path)
  local files = {}

  local i = 1

  for file in lfs.dir(path) do
    -- Make sure to filter away Max OSX dir files
    if not (file == '.' or file == '..' or file == '.DS_Store') then
      files[i] = path .. '/' .. file
      i = i + 1
    end
  end

  return files
end


function publicClass.get_image_paths_labels(path)
  local folders = publicClass.get_dir_items(path)

  local images = {}
  local class_dict = {}
  local image_i = 1
  local class_i = 1

  for folder_i = 1, table.getn(folders) do
    local folder = folders[folder_i]

    local image_files = publicClass.get_dir_items(folder)
    local split_class = folder:split('/')
    local last_index = table.getn(split_class)
    local class = split_class[last_index]

    for image_file_i = 1, table.getn(image_files) do
      image_file = image_files[image_file_i]
      images[image_i] = image_file
      class_dict[image_i] = class
      image_i = image_i + 1
    end

    class_dict[class_i] = class
    class_i = class_i + 1
  end

  return images, class_dict
end

function publicClass.load_images(image_paths, class_dict)
  local images = {}
  local labels = {}

  for i = 1, table.getn(image_paths) do
    local image_path = image_paths[i]

    images[i] = image.load(image_path)
    labels[i] = class_dict[image_path]
  end

  return images, labels
end

return publicClass

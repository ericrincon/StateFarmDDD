require 'xlua'
require 'lfs'

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

  for folder in folders do

end

return publicClass

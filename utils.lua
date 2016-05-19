require 'table'

local publicClass={}

function publicClass.get_from_table(indices, _table)
  local sampled_table = {}

  for i = 1, indices:size()[1] do
    local index = indices[i]

    sampled_table[i] = _table[index]
  end

  return sampled_table
end

return publicClass

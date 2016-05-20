require 'class'
require 'torch'
require 'table'

data_loader = require 'DataLoader'
utils = require 'utils'

mbgenerator = class(function(a, image_paths, class_dict, mb_size)
   a.n_examples = table.getn(image_paths)
   a.permuted_table = torch.randperm(a.n_examples)
   a.image_paths = image_paths
   a.class_dict = class_dict
   a.last_index = 1
   a.mb_size = mb_size

end)

function mbgenerator:next()
  local end_of_batch = self.last_index + self.mb_size - 1

  if self.last_index + self.mb_size - 1 > self.n_examples then
    end_of_batch = self.n_examples
  end


  local indices = self.permuted_table[{{self.last_index, end_of_batch}}]


  local batch_image_paths = utils.get_from_table(indices, self.image_paths)

  self.last_index = self.last_index + self.mb_size

  local images, labels = data_loader.load_images(batch_image_paths,
                                                      self.class_dict)
  local size = images[1]:size()
  local image_batch = torch.Tensor(self.mb_size, size[1], size[2], size[3])
  local label_batch = torch.zeros(self.mb_size)

  for i = 1, self.mb_size do
    local label = labels[i]

    image_batch[{{i}, {}, {}, {}}] = images[i]
    label_batch[{i}] = label
  end

  if end_of_data then
    return nil, nil
  else
    return image_batch, label_batch
  end
end

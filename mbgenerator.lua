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
  local indices = self.permuted_table[{{self.last_index,
                                        self.last_index + self.mb_size - 1}}]
  local batch_image_paths = utils.get_from_table(indices, self.image_paths)
  local batch_label_paths = utils.get_from_table(indices, self.class_dict)

  self.last_index = self.last_index + self.mb_size

  local images, labels = data_loader.load_images(batch_image_paths,
                                                      batch_label_paths)

  return images, labels
end

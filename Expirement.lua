require 'torch'
require 'image'
require 'cnn'
require 'mbgenerator'

local data_loader = require 'DataLoader'
-- Used for parsing arguements from the command line
-- See https://github.com/torch/torch7/blob/master/doc/cmdline.md for more info
cmd = torch.CmdLine()
cmd:option('-learning_rate', .001, 'learning rate')

params = cmd:parse(arg)

train_images, class_dict = data_loader.get_image_paths_labels('imgs/train')

mb_generator = mbgenerator(train_images, class_dict, 32)

cnn = cnn()

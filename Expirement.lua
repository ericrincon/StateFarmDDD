require 'torch'
local data_loader = require 'DataLoader'

-- Used for parsing arguements from the command line
-- See https://github.com/torch/torch7/blob/master/doc/cmdline.md for more info
cmd = torch.CmdLine()
cmd:option('-learning_rate', .001, 'learning rate')

params = cmd:parse(arg)

train_images = data_loader.get_files("imgs/train/")

print(train_images)

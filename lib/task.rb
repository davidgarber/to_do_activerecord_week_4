class Task < ActiveRecord::Base
  scope(:not_done, -> do
    where({:done => false})
  end)
end

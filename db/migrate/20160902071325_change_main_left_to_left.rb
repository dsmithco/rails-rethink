class ChangeMainLeftToLeft < ActiveRecord::Migration[5.0]
  def change
    Block.where(location: 'main_left').update_all(location: 'left')
    Block.where(location: 'main_right').update_all(location: 'right')
    Block.where(location: 'main_top').update_all(location: 'top')
    Block.where(location: 'main_bottom').update_all(location: 'bottom')
  end
end

class TimesheetsDataset < Dataset::Base
  uses :users
  
  def load
    create_record :ben1, :start_date => Date.new(2009,4,6), :user_id => users(:ben).id
    create_record :zack1, :start_date => Date.new(2009,4,13), :user_id => users(:zack).id
  end
end
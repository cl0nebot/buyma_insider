require_relative '../setup'

describe IndexPageWorker do
  it 'should create index pages' do
    IndexPageWorker.new.perform(:slf)
  end
end
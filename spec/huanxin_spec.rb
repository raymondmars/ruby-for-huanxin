require 'spec_helper'

describe Huanxin do 
  before do 
    @cache ||= ActiveSupport::Cache::MemoryStore.new size: 10.megabytes
    @client = Huanxin::Client.new(@cache, 'reyinapp', 'reyinapp')
  end 

  it 'has a version number' do
    expect(Huanxin::VERSION).not_to be nil
  end

  it 'can register user to huanxin' do
    #expect(false).to eq(true)
    #@client.get_user('9CCt0vLn11')

  end 
  it 'can get a existed user' do 
    rt = @client.get_user('9CCt0vLn11')
    puts rt.class 
    puts rt 

    expect(rt).not_to be nil 
    expect(rt["username"]).to eq('9CCt0vLn11')
  end
end

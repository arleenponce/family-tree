require 'active_record'
require 'rspec'

require_relative '../app/models/person'

database_configuration = YAML::load(File.open('../config/database.yml'))
configuration = database_configuration['test']
ActiveRecord::Base.establish_connection(configuration)

describe Person do

  it 'has a given name' do
      aPerson=Person.new
      aPerson.given_name = 'Alex'
      aPerson.save
      expect(aPerson.given_name).to eq 'Alex'
  end

  it 'has a family name' do
    aPerson=Person.new
    aPerson.family_name = 'Keaton'
    aPerson.save
    expect(aPerson.family_name).to eq 'Keaton'
  end

  it 'has a mother' do
    aMother=Person.new
    aMother.given_name='Elyse'
    aMother.save
    aSon=Person.new
    aSon.given_name='Alex'
    aSon.mother=aMother
    aSon.save

    expect(aSon.mother).to eq aMother
    expect(aSon.mother).to eq nil
  end
  #
  # it 'has a father' do
  #
  # end
  #
  # it 'has grandparents' do
  #
  # end



end

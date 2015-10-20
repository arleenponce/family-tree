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

  it 'has a mother (or not)' do
    aMother=Person.new
    aMother.given_name='Elyse'
    aMother.save
    aSon=Person.new
    aSon.given_name='Alex'
    aSon.mother=aMother
    aSon.save

    expect(aSon.mother).to eq aMother
    expect(aMother.mother).to eq nil
  end

  it 'has a father (or a deadbeat)' do
    aFather=Person.new
    aFather.given_name='Steven'
    aFather.save
    aSon=Person.new
    aSon.given_name='Alex'
    aSon.father=aFather
    aSon.save

    expect(aSon.father).to eq aFather
    expect(aFather.father).to eq nil

  end

  it 'has grandparents' do

    aGma=Person.new
    aGma.given_name='Ruth'
    aGma.save

    aGpa=Person.new
    aGpa.given_name='Bill'
    aGpa.save

    aMother=Person.new
    aMother.given_name="Kathy"
    aMother.save

    aFather=Person.new
    aFather.given_name="Jim"
    aFather.save

    aSon=Person.new
    aSon.given_name="Alex"
    aSon.save

    expect(aSon.mother.mother).to be_a Array
    expect(aSon.mother.mother).to match_array [aGma]
  end



end

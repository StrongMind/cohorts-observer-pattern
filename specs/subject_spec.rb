require_relative '../main'
require "faker"

RSpec.describe Assessment do
  it 'has a score' do
    score = rand(100)
    subject.score = score
    expect(subject.score).to eq score
  end
  it 'is observable' do
    class Observer
      def update
      end
    end
    subject.add_observer(Observer.new)
  end
end

RSpec.describe Student do
  it 'has a name' do
    name = Faker::Name.name
    subject.name = name
    expect(subject.name).to eq name
  end

  it 'tells the user when their assessment score changes' do
    subject.name = Faker::Name.name
    assessment = Assessment.new
    assessment.add_observer(subject)
    new_score = rand(100)
    expect do
      assessment.score = new_score
    end.to output("Hi #{subject.name}, your assessment score is now #{new_score}\n").to_stdout
  end
end

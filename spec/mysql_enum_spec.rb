require 'spec_helper'

class Enumeration < ActiveRecord::Base
  # validates_columns :color, :severity, :string_field, :int_field
end

describe 'The ENUM type' do
  describe 'schema dump' do

  end

  describe 'schema loading' do
    before { load_schema }
    context 'with t.column type: :enum declaration' do
      subject { column_props(:enumerations, :color) }

      it 'loads native format' do
        expect(subject[:type]).to eq("enum('red','blue','green','yellow')")
      end

      it "loads default option" do
        expect(subject[:default]).to eq('green')
      end

      it "loads null option" do
        expect(subject[:null]).to be(false)
      end
    end

    context 'with t.enum declaration' do
      subject { column_props(:enumerations, :severity) }

      it 'loads native format' do
        expect(subject[:type]).to eq("enum('low','medium','high','critical')")
      end

      it "loads default option" do
        expect(subject[:default]).to eq('medium')
      end

      it "loads null option" do
        expect(subject[:null]).to be(true)
      end
    end
  end

  describe 'model instance' do
    subject { Enumeration.new }
    context 'for string default value' do
      it 'sets proper default value as symbol' do
        expect(subject.color).to eq(:green)
      end
    end
    context 'for symbol default value' do
      it 'sets proper default value as symbol' do
        expect(subject.severity).to eq(:medium)
      end
    end
  end
end

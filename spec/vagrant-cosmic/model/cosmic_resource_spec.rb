require 'spec_helper'
require 'vagrant-cosmic/model/cosmic_resource'

include VagrantPlugins::Cosmic::Model

describe CosmicResource do
  context 'when all attribtues are defined' do
    let(:resource) { CosmicResource.new('id', 'name', 'kind') }

    describe '#to_s' do
      it 'prints the resource with all attributes' do
        expect(resource.to_s).to be_eql 'kind - id:name'
      end
    end

    describe '#is_undefined?' do
      it { expect(resource.is_undefined?).to be_eql false }
    end

    describe '#is_id_undefined?' do
      it { expect(resource.is_id_undefined?).to be_eql false }
    end

    describe '#is_name_undefined?' do
      it { expect(resource.is_name_undefined?).to be_eql false }
    end
  end

  context 'when kind is not defined' do
    describe '#new' do
      it 'raises an error when kind is nil' do
        expect { CosmicResource.new('id', 'name', nil) }.to raise_error('Resource must have a kind')
      end

      it 'raises an error when kind is empty' do
        expect { CosmicResource.new('id', 'name', '') }.to raise_error('Resource must have a kind')
      end
    end
  end

  describe '#is_undefined?' do
    it { expect(CosmicResource.new('', '', 'kind').is_undefined?).to be_eql true }
    it { expect(CosmicResource.new(nil, '', 'kind').is_undefined?).to be_eql true }
    it { expect(CosmicResource.new('', nil, 'kind').is_undefined?).to be_eql true }
    it { expect(CosmicResource.new(nil, nil, 'kind').is_undefined?).to be_eql true }
    it { expect(CosmicResource.new('id', nil, 'kind').is_undefined?).to be_eql false }
    it { expect(CosmicResource.new(nil, 'name', 'kind').is_undefined?).to be_eql false }
    it { expect(CosmicResource.new('id', '', 'kind').is_undefined?).to be_eql false }
    it { expect(CosmicResource.new('', 'name', 'kind').is_undefined?).to be_eql false }
  end

  describe '#is_id_undefined?' do
    it { expect(CosmicResource.new('', 'name', 'kind').is_id_undefined?).to be_eql true }
    it { expect(CosmicResource.new(nil, 'name', 'kind').is_id_undefined?).to be_eql true }
    it { expect(CosmicResource.new('', '', 'kind').is_id_undefined?).to be_eql true }
    it { expect(CosmicResource.new(nil, '', 'kind').is_id_undefined?).to be_eql true }
    it { expect(CosmicResource.new('', nil, 'kind').is_id_undefined?).to be_eql true }
    it { expect(CosmicResource.new(nil, nil, 'kind').is_id_undefined?).to be_eql true }
    it { expect(CosmicResource.new('id', nil, 'kind').is_id_undefined?).to be_eql false }
    it { expect(CosmicResource.new('id', '', 'kind').is_id_undefined?).to be_eql false }
  end

  describe '#is_name_undefined?' do
    it { expect(CosmicResource.new('id', '', 'kind').is_name_undefined?).to be_eql true }
    it { expect(CosmicResource.new('id', nil, 'kind').is_name_undefined?).to be_eql true }
    it { expect(CosmicResource.new('', '', 'kind').is_name_undefined?).to be_eql true }
    it { expect(CosmicResource.new(nil, '', 'kind').is_name_undefined?).to be_eql true }
    it { expect(CosmicResource.new('', nil, 'kind').is_name_undefined?).to be_eql true }
    it { expect(CosmicResource.new(nil, nil, 'kind').is_name_undefined?).to be_eql true }
    it { expect(CosmicResource.new(nil, 'name', 'kind').is_name_undefined?).to be_eql false }
    it { expect(CosmicResource.new('', 'name', 'kind').is_name_undefined?).to be_eql false }
  end

  describe '#create_id_list' do
    subject { CosmicResource.create_id_list(ids, kind) }

    let(:kind) { 'network' }
    let(:ids)  { %w(id1 id2) }

    its(:count) { should eq 2 }
    its([0])    { should be_a_resource('id1', nil, kind) }
    its([1])    { should be_a_resource('id2', nil, kind) }
  end

  describe '#create_name_list' do
    subject { CosmicResource.create_name_list(names, kind) }

    let(:kind)  { 'network' }
    let(:names) { %w(name1 name2) }

    its(:count) { should eq 2 }
    its([0])    { should be_a_resource(nil, 'name1', kind) }
    its([1])    { should be_a_resource(nil, 'name2', kind) }
  end
end

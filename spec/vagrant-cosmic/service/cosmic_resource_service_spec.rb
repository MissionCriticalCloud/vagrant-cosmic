require 'spec_helper'
require 'vagrant-cosmic/model/cosmic_resource'
require 'vagrant-cosmic/service/cosmic_resource_service'

include VagrantPlugins::Cosmic::Model
include VagrantPlugins::Cosmic::Service

describe CosmicResourceService do
  let(:cosmic_compute) { double('Fog::Compute::Cosmic') }
  let(:ui) { double('Vagrant::UI') }
  let(:service) { CosmicResourceService.new(cosmic_compute, ui) }

  before do
    response = {
      'listkindsresponse' => {
        'kind' => [{ 'id' => 'resource id', 'name' => 'resource name' }]
      }
    }
    allow(cosmic_compute).to receive(:send).with(:list_kinds, { 'id' => 'resource id' }).and_return(response)
    allow(cosmic_compute).to receive(:send).with(:list_kinds, {}).and_return(response)

    allow(ui).to receive(:detail)
    allow(ui).to receive(:info)
  end

  describe '#sync_resource' do
    it 'retrives the missing name' do
      resource = CosmicResource.new('resource id', nil, 'kind')
      service.sync_resource(resource)

      expect(resource.name).to be_eql 'resource name'
      expect(resource.id).to be_eql 'resource id'
    end

    it 'retrives the missing id' do
      resource = CosmicResource.new(nil, 'resource name', 'kind')
      service.sync_resource(resource)

      expect(resource.id).to be_eql 'resource id'
      expect(resource.name).to be_eql 'resource name'
    end
  end
end

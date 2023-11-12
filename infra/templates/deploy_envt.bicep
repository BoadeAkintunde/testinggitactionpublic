
param storageNamePrefix string
param acr_name string = 'dareschoolacr'
param asb_name string = 'dareschoolasb'
param app_name string = 'dareschoolapp'

param location string = resourceGroup().location

var asp_name = 'ASP-${app_name}'
var stgacc_name = '${storageNamePrefix}${uniqueString(resourceGroup().id)}'

resource storage_account 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: stgacc_name
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}


resource container_registry 'Microsoft.ContainerRegistry/registries@2023-08-01-preview' = {
  name: acr_name
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
  }
}


resource asb 'Microsoft.ServiceBus/namespaces@2022-10-01-preview' = {
  name: asb_name
  location: location
}

resource asp 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: asp_name
  location: location
  kind: 'linux'
  sku: {
    tier: 'Basic'
    name: 'B1'
    size: 'B1'
    family: 'B'
    capacity: 1
  }
  dependsOn: []
}

resource webapp 'Microsoft.Web/sites@2018-11-01' = {
  name: app_name
  location: location
  tags: null
  properties: {
    serverFarmId: asp.id
    clientAffinityEnabled: false
    httpsOnly: true
  }
  dependsOn: []
}


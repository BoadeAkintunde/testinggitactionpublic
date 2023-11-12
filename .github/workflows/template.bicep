param subscriptionId string
param resourceGroupName string
param name string
param location string
param hostingPlanName string
param serverFarmResourceGroup string
param alwaysOn bool
param ftpsState string
param sku string
param skuCode string
param workerSize string
param workerSizeId string
param numberOfWorkers string
param linuxFxVersion string

resource name_resource 'Microsoft.Web/sites@2018-11-01' = {
  name: name
  location: location
  tags: null
  properties: {
    name: name
    siteConfig: {
      appSettings: []
      linuxFxVersion: linuxFxVersion
      alwaysOn: alwaysOn
      ftpsState: ftpsState
    }
    serverFarmId: '/subscriptions/${subscriptionId}/resourcegroups/${serverFarmResourceGroup}/providers/Microsoft.Web/serverfarms/${hostingPlanName}'
    clientAffinityEnabled: false
    virtualNetworkSubnetId: null
    httpsOnly: true
    publicNetworkAccess: 'Enabled'
  }
  dependsOn: [
    hostingPlan
  ]
}

resource hostingPlan 'Microsoft.Web/serverfarms@2018-11-01' = {
  name: hostingPlanName
  location: location
  kind: 'linux'
  tags: null
  properties: {
    name: hostingPlanName
    workerSize: workerSize
    workerSizeId: workerSizeId
    numberOfWorkers: numberOfWorkers
    reserved: true
    zoneRedundant: false
  }
  sku: {
    tier: sku
    name: skuCode
  }
  dependsOn: []
}
param vnetName string
param location string
param vnetPrefix string
param appSubnetName string
param appSubnetPrefix string
param dataSubnetName string
param dataSubnetPrefix string

resource appNSG 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  location: location
  name: 'appNSG'
  tags: {}
  properties: {
    securityRules: []
  }
}

resource dataNSG 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  location: location
  name: 'dataNSG'
  tags: {}
  properties: {
    securityRules: []
  }
}

resource appRT 'Microsoft.Network/routeTables@2023-04-01' = {
  name: 'appRT'
  location: location
  tags: {}
  properties: {
    disableBgpRoutePropagation: true
    routes: []
  }
}

resource dataRT 'Microsoft.Network/routeTables@2023-04-01' = {
  name: 'dataRT'
  location: location
  tags: {}
  properties: {
    disableBgpRoutePropagation: true
    routes: []
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: vnetName
  location: location
  tags: {}
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetPrefix
      ]
    }
    subnets: [
      {
        name: appSubnetName
        properties: {
          addressPrefix: appSubnetPrefix
          delegations: [
            {
              name: 'appServiceDelegation'
              properties: {
                serviceName: 'Microsoft.Web/serverfarms'
              }
            }
          ]
          networkSecurityGroup: {
            id: appNSG.id
          }
          privateEndpointNetworkPolicies: 'string'
          privateLinkServiceNetworkPolicies: 'string'
          routeTable: {
            id: appRT.id
          }
        }
      }
      {
        name: dataSubnetName
        properties: {
          addressPrefix: dataSubnetPrefix
          delegations: [
            {
              name: 'azureSQLDelegation'
              properties: {
                serviceName: 'Microsoft.SQL/ManagedInstance'
              }
            }
          ]
          networkSecurityGroup: {
            id: dataNSG.id
          }
          privateEndpointNetworkPolicies: 'string'
          privateLinkServiceNetworkPolicies: 'string'
          routeTable: {
            id: dataRT.id
          }
        }
      }
    ]
  }
}


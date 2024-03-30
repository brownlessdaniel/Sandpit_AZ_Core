param vnetName string
param location string
param vnetPrefix string
param appSubnetName string
param appSubnetPrefix string
param appNSGName string
param appRTName string
// param dataSubnetName string
// param dataSubnetPrefix string
// param dataNSGName string
// param dataRTName string

resource appNSG 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  location: location
  name: appNSGName
  tags: {
    tagName1: 'tagValue1'
    tagName2: 'tagValue2'
  }
  properties: {
    securityRules: []
  }
}

resource appRT 'Microsoft.Network/routeTables@2023-04-01' = {
  name: appRTName
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
                serviceName: 'string'
              }
              type: 'string'
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
    ]
  }
}


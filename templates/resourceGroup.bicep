param location string = 'uk-south'
param coreRGName string = ''

targetScope = 'subscription'

resource coreRG 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: coreRGName
  location: location
}

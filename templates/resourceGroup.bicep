targetScope = 'subscription'

param location string = 'uk-south'

resource coreRG 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: coreRGName
  location: location
}

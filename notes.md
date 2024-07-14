# ADO/Azure Manual Config
- Library group 'Sandpit-Global' Configured
- Service connection created - https://learn.microsoft.com/en-us/azure/devops/pipelines/library/connect-to-azure?view=azure-devops#create-an-azure-resource-manager-service-connection-that-uses-an-existing-service-principal


  - Creating an app registration, to be used by ADO.
  - Create a secret.
- Then create a role assignment for the principle at the subscription level - 'Contributor' (priviledged administrator) role.
- Update the 'serviceconnectionName' Library group variable with the name of the newly-created service connection.
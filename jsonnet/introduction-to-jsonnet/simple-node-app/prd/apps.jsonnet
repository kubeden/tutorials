local applications = import '../../libs/applications.libsonnet';
local params = import 'parameters.libsonnet';

{
  application: applications.productionApplication(params),
}
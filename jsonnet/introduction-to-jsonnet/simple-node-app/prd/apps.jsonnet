local applications = import '../../libs/applications.libsonnet';
local params = import 'parameters.libsonnet';
local kube = import '../../libs/kube.libsonnet';

// applications.productionApplication(params)

kube.List() {
  items_:
    applications.productionApplication(params)
}
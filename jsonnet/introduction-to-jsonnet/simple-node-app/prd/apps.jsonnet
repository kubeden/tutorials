local applications = import '../../libs/applications.libsonnet';
local params = import 'parameters.libsonnet';
local kube = import '../../libs/kube.libsonnet';

kube.List() {
  items_:
    applications.productionApplication(params)
}
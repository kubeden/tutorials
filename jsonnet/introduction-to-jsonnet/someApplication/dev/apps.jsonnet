local deployment = import '../../libs/deployment.libsonnet';
local service = import '../../libs/service.libsonnet';
local ingress = import '../../libs/ingress.libsonnet';
local params = import 'parameters.libsonnet';

{
  app1: {
    deployment: deployment.basicDeployment(params),
    service: service.LoadBalancer(params),
  },
}
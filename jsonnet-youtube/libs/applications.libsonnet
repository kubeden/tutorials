local deployment = import './deployment.libsonnet';
local service = import './service.libsonnet';
local ingress = import './ingress.libsonnet';

{
    basicApplication(p):: {
        [p.appName + '-deployment']: deployment.basicDeployment(p),
        [p.appName + '-service']: service.LoadBalancer(p),
    },

    productionApplication(p):: {
        [p.appName + '-deployment']: deployment.productionDeployment(p),
        [p.appName + '-service']: service.ClusterIP(p),
        [p.appName + '-ingress']: ingress.basicIngress(p),
    }
}
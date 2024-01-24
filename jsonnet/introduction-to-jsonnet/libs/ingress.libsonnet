{
  basicIngress(p):: {
    apiVersion: 'networking.k8s.io/v1',
    kind: 'Ingress',
    metadata: {
      name: p.appName + '-ingress',
      annotations: {
        'nginx.ingress.kubernetes.io/rewrite-target': '/'
      },
    },
    spec: {
      rules: [
        {
          host: p.appName + p.environment + '.example.com',
          http: {
            paths: [
              {
                pathType: 'Prefix',
                path: '/',
                backend: {
                  service: {
                    name: p.appName + '-service',
                    port: {
                      number: p.port
                    }
                  }
                }
              }
            ]
          }
        }
      ]
    }
  },
}
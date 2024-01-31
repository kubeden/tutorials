{
  basicIngress(p):: {
    apiVersion: 'networking.k8s.io/v1',
    kind: 'Ingress',
    metadata: {
      name: p.appName + '-ingress',
      annotations: {
        'nginx.ingress.kubernetes.io/rewrite-target': '/',
        'cert-manager.io/cluster-issuer': 'letsencrypt-prod',
      },
    },
    spec: {
      ingressClassName: "nginx",
      rules: [
        {
          host: p.appName + '.denctl.com',
          http: {
            paths: [
              {
                pathType: 'Prefix',
                path: '/',
                backend: {
                  service: {
                    name: p.appName + '-service',
                    port: {
                      number: p.ingressPort
                    }
                  }
                }
              }
            ]
          }
        }
      ],
      tls: [
        {
          hosts: [
            p.appName + '.denctl.com'
          ],
          secretName: p.appName + '-tls'
        }
      ]
    }
  },
}
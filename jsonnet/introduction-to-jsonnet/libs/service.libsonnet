{
  ClusterIP(p):: {
    apiVersion: 'v1',
    kind: 'Service',
    metadata: {
      name: p.appName + '-service',
      labels: {
        app: p.appName
      } + if std.objectHas(p, 'env') then
          std.map(
            function(key) { name: key, value: std.toString(p.env[key]) },
            std.objectFields(p.env)
          ) 
      else [],
    },
    spec: {
      type: 'ClusterIP',
      ports: [
        {
          port: 80,
          targetPort: p.port
        }
      ],
      selector: {
        app: p.appName
      }
    }
  },

  LoadBalancer(p):: {
    apiVersion: 'v1',
    kind: 'Service',
    metadata: {
      name: p.appName + '-service',
      labels: {
        app: p.appName
      }
    },
    spec: {
      type: 'LoadBalancer',
      ports: [
        {
          port: 80,
          targetPort: p.port
        }
      ],
      selector: {
        app: p.appName
      }
    }
  },
}
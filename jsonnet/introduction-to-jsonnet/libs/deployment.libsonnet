{
  basicDeployment(p):: {
    apiVersion: 'apps/v1',
    kind: 'Deployment',
    metadata: {
      name: p.appName + '-deployment-',
      labels: {
        app: p.appName
      }
    },
    spec: {
      replicas: p.replicas,
      selector: {
        matchLabels: {
          app: p.appName
        }
      },
      template: {
        metadata: {
          labels: {
            app: p.appName
          }
        },
        spec: {
          containers: [
            {
              name: p.appName,
              image: 'somContainerRegistry/' + p.appName + ':' + p.imageTag,
              ports: [
                {
                  containerPort: p.port
                }
              ],
            }
          ]
        }
      }
    }
  },

  productionDeployment(p):: {
    apiVersion: 'apps/v1',
    kind: 'Deployment',
    metadata: {
      name: p.appName + '-deployment',
      labels: {
        app: p.appName
      }
    },
    spec: {
      replicas: p.replicas,
      selector: {
        matchLabels: {
          app: p.appName
        }
      },
      template: {
        metadata: {
          labels: {
            app: p.appName
          }
        },
        spec: {
          containers: [
            {
              name: p.appName,
              image: 'docker.io/hello-world' + ':' + p.imageTag,
              ports: [
                {
                  containerPort: p.port
                }
              ],
              env: if std.objectHas(p, 'env') then
                std.map(
                  function(key) { name: key, value: std.toString(p.env[key]) },
                  std.objectFields(p.env)
                ) 
                else [],
            }
          ],
        }
      }
    }
  },
}
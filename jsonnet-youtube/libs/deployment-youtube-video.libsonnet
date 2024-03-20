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
              image: 'docker.io/kuberdenis/' + p.appName + ':' + p.imageTag,
              ports: [
                {
                  containerPort: p.port
                }
              ],
              // I have the following p.env:
              // env: {
              //   'NODE_ENV': 'development',
              //   'PORT': '8080',
              // },
              // write a jsonnet function to convert so that env is an array of objects
              env: if(p.env) then std.map(function(k) { {name: k, value: p.env[k]} }, std.objectFields(p.env)) else []
            }
          ]
        }
      }
    }
  }
}
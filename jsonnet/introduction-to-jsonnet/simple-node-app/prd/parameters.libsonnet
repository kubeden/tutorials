{
  appName: 'simple-node-app',
  environment: 'prd',
  replicas: 2,
  port: 8080,
  ingressPort: 80,
  imageTag: 'v1',

  env: {
    YOUR_NAME: "Kuberdenis (who just updated the environment variable)"
  },

  labels: {
    env: 'prd',
    exampleLabel: 'exampleValue'
  },
}
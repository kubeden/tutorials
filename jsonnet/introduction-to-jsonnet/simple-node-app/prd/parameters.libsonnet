{
  appName: 'simple-node-app',
  environment: 'prd',
  replicas: 2,
  port: 8080,
  imageTag: 'v1',

  env: {
    NODE_ENV: 'production',
    PORT: 8080,
  },
}
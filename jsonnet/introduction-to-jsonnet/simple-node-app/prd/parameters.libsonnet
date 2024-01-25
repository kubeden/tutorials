{
  appName: 'simple-node-app',
  environment: 'prd',
  replicas: 3,
  port: 8080,
  imageTag: 'latest',

  env: {
    NODE_ENV: 'production',
    PORT: 8080,
  },
}
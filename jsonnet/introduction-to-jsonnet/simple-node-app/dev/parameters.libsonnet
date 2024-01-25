{
  appName: 'simple-node-app',
  environment: 'dev',
  replicas: 3,
  port: 8080,
  imageTag: 'latest',

  env: {
    NODE_ENV: 'development',
    PORT: 8080,
  },
}
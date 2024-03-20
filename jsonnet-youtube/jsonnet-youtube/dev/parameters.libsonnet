{
  appName: 'app1',
  environment: 'dev',
  replicas: 3,
  port: 8080,
  ingressPort: 80,
  imageTag: 'latest',

  env: {
    'NODE_ENV': 'development',
    'PORT': '8080',
  },
}
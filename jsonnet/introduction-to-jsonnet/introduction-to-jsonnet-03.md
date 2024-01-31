## Jsonnet Adventures: Deploying our application to ArgoCD!

Hello fellow Kubernetes enthusiasts! In my previous blog posts we explored the basics of Jsonnet and how to use it to generate Kubernetes manifests. Now, I'm thrilled to finally get to the deployment of our production-ready, Jsonnet-templated application to ArgoCD.

## Prerequisites

> I am expecting you to have a basic understanding of ArgoCD and Kubernetes for this one. If you need a refresher, check out some resources online (before I create my own tutorials on these topics):
> - [ArgoCD](https://argo-cd.readthedocs.io/en/stable/getting_started/)
> - [Nginx Ingress Controller & Cert Manager](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nginx-ingress-with-cert-manager-on-digitalocean-kubernetes)

Before diving in, here's a quick overview of what you need to follow along:

- Read through [Jsonnet Introduction](https://dev.to/kubeden/introduction-to-jsonnet-the-yamljson-templating-language-n5g)
- Read through [Jsonnet Adventures: Functions, Conditionals, and Advanced Templates](https://dev.to/kubeden/jsonnet-adventures-functions-conditionals-and-advanced-templates-4cd3)
- Jsonnet Templates Repository: All the Jsonnet templates in those tutorials are stored in [kubeden/tutorials](https://github.com/kubeden/tutorials) and you can use it as reference.
- Application Repository: The source code for the Simple Node App is in [kubeden/simple-nod-app](https://github.com/kubeden/simple-nod-app). Yes, that is a typo lol
- Docker Repository: The application's Docker image is available at [kuberdenis/simple-node-app](https://hub.docker.com/repository/docker/kuberdenis/simple-node-app/general).


## Enhanced productionDeployment

As you are already familiar with the productionDeployment from the previous blog posts in the series, it is only important to mention we have now included dynamic label handling:

```
productionDeployment(p):: {
    // ... Other configurations ...
    metadata: {
      // ... Other metadata ...
      labels: {
        app: p.appName
      } + if std.objectHas(p, 'labels') then p.labels else {},
    },
    // ... Remaining deployment spec ...
}
```

This enhancement allows for the dynamic addition of labels defined in the parameters.libsonnet.

Another addition is within the *parameters.libsonnet* file which now holds:

```
{
  appName: 'simple-node-app',
  // ... Other parameters ...
  env: {
    YOUR_NAME: "Kuberdenis"
  },
  labels: {
    env: 'prd',
    exampleLabel: 'exampleValue'
  },
}
```

These parameters are crucial for customizing the deployment, including the environment variable YOUR_NAME, which the Node app uses to greet users.

## The Deployment Process

- Jsonnet Templates: Using Jsonnet, I generated Kubernetes manifests that are both dynamic and maintainable.
- ArgoCD Application: I created an application in ArgoCD pointing to the simple-node-app repository with a path to my *prd* directory. With a simple sync of the application, ArgoCD deployed the application to my Kubernetes cluster.

## The Result

The application, now live, dynamically greets users with the name provided in the YOUR_NAME environment variable.

Here is how the application looks like in ArgoCD:

This small, yet powerful demonstration shows the flexibility and power of combining Jsonnet for templating Kubernetes for ArgoCD.

## Conclusion

If you made it this far, thank you for reading! I hope you enjoyed this series and learned something new. I am planning to continue writing about Jsonnet and other Kubernetes-related topics, so stay tuned!

This time the closing GIF is of our working application!
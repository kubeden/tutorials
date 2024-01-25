# Jsonnet Adventures: Functions, Conditionals, and Advanced Templates

Welcome back to Jsonnet series! After covering the basics in [my previous post](https://dev.to/kubeden/introduction-to-jsonnet-the-yamljson-templating-language-n5g), it is time to delve into Jsonnet's more advanced features: functions, conditionals, advanced templating, and leveraging external libraries. 

I'll showcase these through an update to our Kubernetes deployment setup, gearing it towards a production-ready (well... almost) application.

## Prerequisites

- kubectl cli: [link](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- jsonnet cli: [link](https://github.com/google/jsonnet)
- clone the Github repo: [link](https://github.com/kubeden/tutorials)
- understand the Jsonnet basics: [first post](https://dev.to/kubeden/introduction-to-jsonnet-the-yamljson-templating-language-n5g)

## Updated Files Overview

Before diving into the specifics, let's take a look at the updated files in our project:

- */libs/applications.libsonnet*: A new addition that orchestrates different application setups.
- */libs/deployment.libsonnet*: Enhanced to include environment variables in our production deployment.
- */libs/kube.libsonnet*: An external library from Bitnami, facilitating Kubernetes deployments (we'll focus on the List() function).
- */simple-node-app/prd/apps.jsonnet*: Our main deployment file, now integrating the new kube.libsonnet and applications.libsonnet libraries.
- */simple-node-app/prd/parameters.libsonnet*: Updated parameters, including environmental variables for our production deployment.

## The New applications.libsonnet

We have added **applications.libsonnet** to allow us to easily manage our code, and create different types of applications. Here's how it looks like:

```
local deployment = import './deployment.libsonnet';
local service = import './service.libsonnet';
local ingress = import './ingress.libsonnet';

{
    basicApplication(p):: {
        [p.appName + '-deployment']: deployment.basicDeployment(p),
        [p.appName + '-service']: service.LoadBalancer(p),
    },

    productionApplication(p):: {
        [p.appName + '-deployment']: deployment.productionDeployment(p),
        [p.appName + '-service']: service.ClusterIP(p),
        [p.appName + '-ingress']: ingress.basicIngress(p),
    }
}
```

We define the application type we want, and set up the resources we want to deploy. This is a great way to organize our code and make it more maintainable. We also moved the imports to the top of this file rather than having them in each application-specific *apps.jsonnet* file.

## Enhanced productionDeployment in libs/deployment.libsonnet

Jsonnet contains powerful pre-defined functions and libraries that we can leverage to enhance our code. In our updated **libs/deployment.libsonnet**, the productionDeployment function utilizes the std.map() function to generate environment variables for our production deployment:

```
productionDeployment(p):: {
  // ... Other deployment details ...
  spec: {
    template: {
      spec: {
        containers: [
          {
            // ... Other container configurations ...
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
}
```

This addition dynamically generates the necessary environment variables for the container from the parameters file, and uses a conditional "if" to check if the parameters file contains an "env" object. If it does, it will generate the environment variables, otherwise it will generate an empty array.

std.objectHas and std.map are only two of the many functions available in Jsonnet. You can find the full list [here](https://jsonnet.org/ref/stdlib.html).

## The kube.libsonnet - List() Function

I've also brought in **kube.libsonnet** from the Bitnami kube-libsonnet library to further empower our Jsonnet scripts.

In this tutorial, we are only using its List() function, which helps us bundle the resources we want to deploy into our (future) ArgoCD cluster.

More about the kube.libsonnet library later in future posts.

## Integrating Everything in /simple-node-app/prd/apps.jsonnet

In */simple-node-app/prd/apps.jsonnet*, we now have a simplified deployment file:

```
local applications = import '../../libs/applications.libsonnet';
local params = import 'parameters.libsonnet';
local kube = import '../../libs/kube.libsonnet';

kube.List() {
  items_: applications.productionApplication(params)
}
```

Notice how we now import only the **applications** rather than all the individual libraries. This way the deployment process becomes more readable and manageable using the kube.List() function. This will generate an ArgoCD-ready application manifest which we can deploy to our cluster.

## Updated parameters.libsonnet

Finally, the parameters.libsonnet has been updated to include environmental variables:

```
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
```

It doesn't matter if we want one, two, or 15 environment variables. Because of the std.map() function, our productionDeployment function will generate the necessary environment variables for our container.

This is just how powerful Jsonnet really is.

## Conclusion

In this post, we updated our codebase using Jsonnet's more advanced feature and hopefully started feeling more creative! We also added an external library, and are getting ready to soon start deploying our applications to our Kubernetes cluster.

In the next post, we will take a look at how ArgoCD handles Jsonnet, and how a simple ArgoCD application built with Jsonnet looks like.


I hope you learned something and if you feel like chatting, connect with me on [X](https://x.com/kubeden) or hit me up with a comment below!

Closing GIF time!

![gif](https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExaXNkc2Q1MDFycnlkN3RqYm5kdDVnZjBlNDlxY3hhMTBqbnVmbnFuMSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/xTiTnoBiCVGKGOrbCo/giphy.gif)
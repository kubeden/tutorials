In this short introductory blog post I share a short story of the time I started working with Helm and why it felt horrifying. After that, I jump in drawing the parallels between Helm and APT. I found this way to be quite easy for me to understand how Helm works so I hope it helps you too. Happy reading.

## The horrors of Helm

When I first started working with Kubernetes I was overwhelmed by the "quietness" I felt working with the technology. Hare are the reasons why I felt this way:

- No GUI, everything in the terminal
- A lot of resource types
- Long commands
- Having to `kubectl` for every single little thing I want to check
- Nodes, Load Balancers, Networking... AGAIN IN THE TERMINAL!

Generally I felt as if I was diving in *the deepest of waters* without the correct equipement and that was horrifying. Unfortunately to me, I had to dive even deeper before getting equiped with tools like [ArgoCD](https://argo-cd.readthedocs.io/en/stable/), and [k8slens](https://k8slens.dev/). I had to start working with... [**HELM**](https://helm.sh/).

*Imagine having to run HELM commands. 😂*

*Installing tens of resources in a namespace. And all those are... CUSTOM... RESOURCE... TYPES (I never heard of).*

Anyway. Let's try to mitigate this potential situation from your life by going over the basics.

## What is Helm?

Helm is a package manager for Kubernetes. This means you can install and uninstall software on your cluster with a few commands. Just like in Linux with `apt get` with HELM the equivalent is `helm install`

## When to use Helm?

Well, you can either go with or without Helm. One thing is for certain though - once you start using it there is a high chance you will stick around.

I personally use Helm for two purposes:

1. Installing common software on new clusters. For example Nginx Ingress Controller and Certbot.
2. Templating Kubernetes packages on a base level for multi-cluster deployments.

Generally, I look at it as a good foundation material for my Kubernetes house. 😉

With this, let's jump right into the technicalities and see how to actually use Helm.

## How to use Helm?

What I noticed with tool lately is that the learning curve is not that frightening. I usually find myself learning the basics and a few more advanced tricks and I feel comfortable working / playing around with the software. Same thing goes for Helm.

First you need to install it - [intallation guide](https://helm.sh/docs/intro/install/)

After you install Helm, there are basics commands you need to know and for that I am going to draw parallels between those basic Helm commands and how they compare to APT.

- `helm repo add <software-name> <repository-url>`: This command in Helm adds a new repository to your local Helm configuration. The equivalent APT command is `sudo add-apt-repository 'deb [arch=architecture] <repository-url> distribution component`. In APT, this command adds a new repository to the list of sources APT will use to fetch packages.

- `helm search repo <software-name>`: This Helm command searches for charts in a repository. The APT equivalent is `apt-cache search <package-name>`. This command searches the package metadata in APT's repositories for a specific package.

- `helm repo update`: This command updates the local Helm chart repository cache. The equivalent in APT is `sudo apt-get update`, which updates the list of packages available from the repositories defined in */etc/apt/sources.list* and */etc/apt/sources.list.d/*.

- `helm install <software-name>/<package-name>`: This Helm command is used to install a chart. The APT equivalent is `sudo apt-get install <package-name>`. This installs a new package from the repositories.

- `helm list`: This command lists all the Helm releases in the cluster. The APT equivalent could be `dpkg --get-selections`, which lists all the installed packages. However, it's important to note that APT doesn't manage deployments in the same way Helm does, so this is only a rough equivalent.

- `helm uninstall <package-name>`: This removes a Helm release. The APT equivalent is `sudo apt-get remove <package-name>`. This command removes a package installed via APT.

## Conclusion

Stepping into the world of Kubernetes and Helm can feel like a daunting journey, especially when compared to the more familiar territory of traditional Linux package management with APT. But as we've seen, the basic concepts between Helm and APT aren't worlds apart. Helm, like APT, simplifies the process of managing software, but it does so in the context of Kubernetes - a much more dynamic and distributed environment.

By understanding the parallels between these two tools, you can demystify the process of working with Kubernetes and begin to appreciate the power and flexibility that Helm offers. Whether you're managing a handful of microservices or orchestrating a large-scale, multi-cluster environment, Helm provides the tools you need to deploy, manage, and scale your applications with ease.

Happy Helming! 🚀🛠️

P.S.

Thanks for reading, friend! I write about DevOps, Programming, and share my thoughts about the tech industry. Oh, and sometimes I share stories of how tech helps me in some life situations (e.g. [I hacked my neighbour's Wi-Fi because he was blasting loud music](https://kubeden.io/blog/i-stopped-my-neighbor-s-wi-fi-access-here-is-why-and-how))

Follow me on [X/Kubeden](https://x.com/kubeden) if you feel like chatting sometime.

Closing GIF time *wink*

![GIF](https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExZzFsbjF2NWJtcTV0Y2s2emw2c2hhdm0xb2oxeTI3dWozODVyYmE4YiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/LUIvcbR6yytz2/giphy.gif)
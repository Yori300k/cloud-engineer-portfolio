# Project 08 - Jenkins: Self-Hosted CI/CD

## Business problem this solves
Government and regulated-industry contracts — often six and seven figures — are won or lost on compliance, and their code cannot leave the building. A self-hosted pipeline keeps the whole delivery process inside the security boundary, which protects the contracts that pay everyone's salary.

## What I built
A self-hosted Jenkins server running in Docker, with a working pipeline 
that runs the four core stages of CI/CD: Checkout, Build, Test, Deploy.

## Why Jenkins (and why it matters for this role)
I already built a CI/CD pipeline with GitHub Actions in Project 04. 
Jenkins is the other side of the CI/CD world:

- **GitHub Actions** is cloud-hosted and managed by GitHub
- **Jenkins** is self-hosted — you run it on your own infrastructure

Enterprises and government agencies often require self-hosted CI/CD 
for security and compliance reasons — they can't or won't send their 
code and build process to a third-party cloud. That's why Jenkins has 
been an industry standard for 15+ years and appears in a large share 
of enterprise and government contract job postings.

Having built pipelines in both, I understand the tradeoff: Jenkins is 
more flexible and gives full control but requires more setup and 
ongoing maintenance; GitHub Actions is more opinionated but works out 
of the box.

## What I did
- Ran Jenkins in a Docker container (isolated, clean, easy to tear down)
- Used a persistent Docker volume so Jenkins config survives restarts
- Completed first-time setup: unlocked with the initial admin password, 
  installed suggested plugins, created an admin user
- Built a Pipeline job defined as code (the modern, version-controllable 
  approach over click-through Freestyle jobs)
- Ran the pipeline through all four stages successfully

## The pipeline stages (and why order matters)
- **Checkout** — pull the latest code from the repository
- **Build** — package the application into something runnable
- **Test** — run automated tests to catch problems
- **Deploy** — push the tested application to where it runs

Test comes before Deploy on purpose. If you deployed first and tested 
after, broken code would already be live and affecting users before 
you caught the problem. Testing first means the pipeline fails safely 
in the test stage instead of dangerously in production.

## Real problems I hit
- Port conflict: my Docker app from Project 06 was already using port 
  8080, so I mapped Jenkins to 8081 instead to avoid the collision
- Learned that Jenkins is minimal by default and extended through 
  plugins, unlike GitHub Actions which comes with most features built in

## What's next
- Connect the pipeline to my actual GitHub repo so it pulls real code
- Add real build/test/deploy commands instead of placeholder steps

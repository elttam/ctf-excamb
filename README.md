# Overview

**Title:** excamb  
**Category:** Crypto  
**Flag:** libctf{3d3ee28f-35c2-4ace-a2e3-d1c4d7122ba8}  
**Difficulty:** easy to moderate  

# Usage

The following will pull the latest 'elttam/ctf-excamb' image from DockerHub, run a new container named 'libctfso-excamb', and publish the vulnerable service on port 80:

```sh
docker run --rm \
  --publish 80:80 \
  --name libctfso-excamb \
  elttam/ctf-excamb:latest
```

# Build (Optional)

If you prefer to build the 'elttam/ctf-excamb' image yourself you can do so first with:

```sh
docker build ${PWD} \
  --tag elttam/ctf-excamb:latest
```

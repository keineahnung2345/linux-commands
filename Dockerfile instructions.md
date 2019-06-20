# Dockerfile instructions
Some point to be noticed when writing a Dockerfile

## Update an environment variable
```
ENV PATH="$HOME/miniconda/bin:${PATH}"
```

[In a Dockerfile, How to update PATH environment variable?](https://stackoverflow.com/questions/27093612/in-a-dockerfile-how-to-update-path-environment-variable)

## COPY v.s. ADD
COPY is the recommended instruction.

[Dockerfile COPY vs ADD: key differences and best practices](https://medium.freecodecamp.org/dockerfile-copy-vs-add-key-differences-and-best-practices-9570c4592e9e)

## To reuse the value of ARG
[[Feature Request] Support any number of `ARG` being declared before `FROM` and available during build](https://github.com/moby/moby/issues/37622#issuecomment-412101935)
```
ARG MY_ARG1
# consume this argument

# need to re-declare it so the value of MY_ARG1 can be reused
ARG MY_ARG1
```

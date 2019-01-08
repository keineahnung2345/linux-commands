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

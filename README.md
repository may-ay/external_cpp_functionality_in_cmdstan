# Introduction

The aim of this walk-through is to provide [CmdStan](https://mc-stan.org/users/interfaces/cmdstan) 
users with the knowledge needed to incorporate external C++ code into their existing 
[Stan](https://mc-stan.org/) models. 
The primary advantage of doing so is the ability to create and use custom C++ functions 
within your Stan model. 

The first example of this functionality will use the Bernoulli example code provided 
by the Stan developers. The code for this example is found in the 
"/cmdstan/examples/bernoulli" directory of the 
[CmdStan installation](https://github.com/stan-dev/cmdstan/tree/develop/examples/bernoulli). 
The second example will be a binomial model using data from 
[Linear Models with R](https://julianfaraway.github.io/faraway/LMR/).
The code for this section will be provided below. 

There are other Stan interfaces that offer external C++ functionality. 
A notable example is [RStan](http://mc-stan.org/rstan/). However, the 
challenge of using external C++ code is relatively similar in both CmdStan and 
RStan. The key factors to consider when choosing a Stan interface in this case 
include:

- Your comfort level with each of the interfaces.
- Data input and hyperparameter setup are more straightforward in RStan.
- Power users may find CmdStan more convenient since data input and hyperparameter configuration are done through the terminal.
- CmdStan is typically more up-to-date with respect to the Stan back-end.

With any Stan interface, the user will be required to [template](https://cplusplus.com/doc/oldtutorial/templates/)
their C++ code to match the templating found in [Stan's math library](https://mc-stan.org/math/). 
Further details regarding the process of templating C++ code to match Stan's math 
library will be provided below. This requirement constitutes the most 
time-intensive aspect of this process.

For additional information on using external C++ code within RStan, you can refer 
to this [vinette](https://mc-stan.org/rstan/articles/external.html).
The use of external C++ code within RStan will not be explored in this walkthrough.

## Installation

The first step is download the version of CmdStan appropriate for your system. 
The available versions of CmdStan are listed under releases in the 
[stan-dev/cmdstan](https://github.com/stan-dev/cmdstan/releases) 
repository. For example: The release that was used for this walk-through is 
[cmdstan-2.29.2.tar.gz](https://github.com/stan-dev/cmdstan/releases/download/v2.29.2/cmdstan-2.29.2.tar.gz). 

Once the tar.gz is downloaded and unzipped into a directory of your choosing 
(the system's home directory was used for this example), you can open a terminal 
window and cd into the unzipped folder (e.g. `cd ~/cmdstan-2.29.2/`). Inside your 
terminal window, run `make build` to complete the CmdStan installation process. 
If you wanted to delete CmdStan from your system, you can run `make clean-all` 
from the same directory as you called `make build`. 

More recent versions of CmdStan can be used; however, the external C++ 
functionality may differ in future releases of CmdStan.

The details of the system used for this walkthrough: 

- Operating System: Ubuntu 20.04 amd64
- CmdStan Version: v2.29.2
- Compiler/Toolkit: g++ 9.4.0 and make 4.2.1

## Repository

For detailed terminal output and what you should expect to see after running the 
`make`, `sample`, and `stansummary` commands, refer to the "terminal_output" 
directories within the "bernoulli" and "binomial_glm" directories. These directories 
can be found in the same github repository associated with this documentation: 
"/external_cpp_functionality_in_cmdstan". This repository also contains all of the 
code referred to within this walkthrough, as well as examples of CmdStan 
makefiles that can be used for each set of code. 

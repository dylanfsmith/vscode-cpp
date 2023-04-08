# vscode-cpp
Template and tutorial for setting up vscode with C++.

VSCode docs [here](https://code.visualstudio.com/docs).

## Install vscode

Docs found [here](https://code.visualstudio.com/docs/setup/linux).

For Linux via snap package manager:
```bash
sudo snap install code
```

## Launch vscode

Unlike some other IDEs, VSCode takes the approach of "one project per instance". This means that you will typically have one vscode instance running per project or repo. This approach, along with an alternative "multi-root workspace" option, is described [here](https://code.visualstudio.com/docs/editor/workspaces).

Normally you launch VSCode from the command line by providing it with the project directory as an argument like this:
```bash
code <project-path>
```
However, we have yet to create our project, so we have no directory to point at yet. We will launch VSCode and then create our project directory by cloning the git repository:

* Run `code` on the command line (from any directory).
* Enter `Git: Clone` in the Command Palette (Ctrl+Shift+P) and provide the repository url, `git@github.com:dylanfsmith/vscode-cpp.git`. 
* Chose the path `~/git` as the project destination when prompted.
* Finally, chose `Open` to open the new project in the workspace.

## Install vscode extensions

Skim through the following guides:
* [Tips and Tricks](https://code.visualstudio.com/docs/getstarted/tips-and-tricks)
* [User Interface](https://code.visualstudio.com/docs/getstarted/userinterface)

Install the following extensions. Copy the provided command snippets then Quick Open (Ctrl+P), paste, and install:
* C/C++ Extension Pack: `ext install ms-vscode.cpptools-extension-pack`
* 

## VSCode settings

## References

* [https://www.pragmaticlinux.com/2021/07/import-a-cmake-project-into-visual-studio-code/]

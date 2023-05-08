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

First, some terminology. The concept of a *project* found in other IDEs (such as Eclipse) is similar to what VSCode calls a **workspace**. For those using source control, each repo will have its own workspace. Unlike other IDEs, VSCode takes the approach of "one workspace per instance". This means that you will typically have one vscode instance running per repo. This approach, along with a "multi-root workspace" option, is described [here](https://code.visualstudio.com/docs/editor/workspaces). The `Project Manager` extension (installed below as part of the Git Extension Pack) allows workspaces to be packaged as **project**s, providing an approach closer to what you would get in other IDEs.

Normally you would launch VSCode from the command line by providing it with the project directory as an argument like this:

```bash
code <project-path>
```

However, we have yet to create our project and so have no directory at which to point. So we will launch VSCode `code` from the command line in any directory:
```bash
code
```

Now take a look at the guide to the VSCode [user interface](https://code.visualstudio.com/docs/getstarted/userinterface). Before going any further make sure you know where to find the following areas, as we will make use of these terms in the rest of the tutorial:
* **activity bar**
* **side bar**
* **status bar**
* **editor groups** or **editors** (holds multiple **editor** components)
* **panel**
* **menu bar** (not shown in the guide, but its the top bar with File, Edit, etc... )

Additionally, get acquainted with the [Command Palette](https://code.visualstudio.com/docs/getstarted/userinterface#_command-palette), accessible through the Ctrl+Shift+P shortcut. All VSCode functionality (including that of extensions) is available by typing in the Command Palette. 

Note that the widgets found in the side bar are called **views**, and are accessed by clicking on the associated icon in the activity bar. For example, clicking on the `Explorer` icon (at top) in the activity bar opens the `Explorer` view in the side bar. While many views are placed in the side bar, some are placed in the panel or editors areas.

## Install vscode extensions

Before we setup our `vscode-cpp` workspace (and project) we will need to install some plugins. VSCode is a flexible platform that allows development in many languages, but supports very few out of the box. Support for most languages is provided plugins called **extensions**. Extensions also provide a path to customizing views and tooling. 

Install the following extensions. Copy the provided command snippets then Quick Open (Ctrl+P), paste, and install:
* C/C++ Extension Pack: `ext install ms-vscode.cpptools-extension-pack`
* Git Extension Pack (optional): `ext install donjayamanne.git-extension-pack`

Click `Extensions` in the 

## Clone the repository

Now we are ready to clone the `vscode-cpp` repository and create our first workspace:

* Enter `Git: Clone` in the Command Palette (Ctrl+Shift+P) and provide the repository url in the edit box: `git@github.com:dylanfsmith/vscode-cpp.git`
* Chose the path `~/git` as the project destination when prompted.
* Chose `Open` to open the new project in the workspace.
   * Now we have a *workspace* open for the `vscode-cpp` repo.
* Click the `Project Manager` tab in the `Activity Bar` and ...
   * Now we have a *project* available for the `vscode-cpp` workspace.

## Open the README.md

Activate the `Explorer` view (by clicking `Explorer` icon in the activity bar). Click on the `README.md` file to open it in an editor in the editors area. Now you can continue the tutorial from VSCode itself instead of your internet browser. 

To view the rendered markdown we use the `Open Preview` action. This action can be accessed from the set of buttons at the top right of every editor, called the **editor toolbar**. This toolbar is context-dependent and changes based on the content of the editor. With `README.md` active you will find a button with the tooltip `Open Preview to the Side`. Clicking on this shows the rendered markdown. To close the preview editor hover over the name of the file in the tab at the top of the editor area. An 'x' will appear, and clicking it will close the window. Alternatively you can use Ctrl+W.

## CMake Extension

One of the C/C++ Tools extensions is the CMake Tools extension. This extension is activated anytime a workspace is opened with a `CMakeLists.txt` file in the root directory.

When the CMake configuration step is performed, the CMake extension adds the [appropriate flag](https://cmake.org/cmake/help/v3.5/variable/CMAKE_EXPORT_COMPILE_COMMANDS.html) to generate the `compiler_commands.json` file in a directory that can be specified in the settings (as we do). This file is then used by the VSCode C/C++ Extension to facilitate intellisense (contrary to what is stated [here](https://github.com/microsoft/vscode-cpptools/issues/6592), which suggests that CMake extension bypasses `compile_commands.json`).

Our problem is that we do not have a single build directory and therefore we do not have a single `compile_commands.json` file. In practice, with this configuration, I have had to manually set the `compileCommands` path in `c_cpp_properties.json` to a *particular* build type since the C/C++ Extension (which owns `c_cpp_properties.json`) does not know the CMake-specific `${buildType}` variable. 

```json
{
    "configurations": [
        {
            "name": "Linux",
            "includePath": [
                "${workspaceFolder}/**"
            ],
            "defines": [],
            "cStandard": "c17",
            "cppStandard": "c++20",
            "intelliSenseMode": "linux-clang-x64",
            "compileCommands": "${workspaceFolder}/build/Debug/compile_commands.json"
        }
    ],
    "version": 4
}
```

[This](https://vector-of-bool.github.io/docs/vscode-cmake-tools/configuring.html#a-clean-configure) suggests that CMake Tools does sufficient cleaning when switching variant that it is ok to put reuse the build dir (not breaking out by variant/build type).

## VSCode settings

To ensure that the settings are applied to all workspaces created by the user, choose `User` instead of `Workspace` under `Preferences`:
* File -> Preferences
   * `Editor: Insert Spaces` -> disable [don't force spaces]
   * `Editor: Tab Size` -> 3
   * `CMake: Build Directory` -> `${workspaceFolder}/build/${buildType}` [create separate directories for each build type]

### add vertical rulers

To add vertical ruler at column 80, modify `settings.json`:
```json
    "editor.rulers": [80]
```

## Building


## Defining build types

As described [here](https://github.com/microsoft/vscode-cmake-tools/blob/main/docs/variants.md), the CMake extension does not automatically determine the set of build types from `CMAKE_CONFIGURATION_TYPES` variable. To support our set of build types (called **build variants** by the extension) we provide it explicitly in a configuration file.

Create `.vscode/cmake-variants.yaml` and populate as follows:
```yaml
buildType:
  default: debug
  choices:
    debug:
      short: Debug
      long: Emit debug information
      buildType: Debug
    release:
      short: Release
      long: Optimize generated code
      buildType: Release
    asan:
      short: ASan
      long: Instrument with Address Sanitizer
      buildType: ASan
    tsan:
      short: TSan
      long: Instrument with Thread Sanitizer
      buildType: TSan
```

We prefer to keep the compiler flags for the build types in the source code, using the approach described [here](https://gitlab.kitware.com/cmake/community/-/wikis/FAQ#how-can-i-extend-the-build-modes-with-a-custom-made-one-). The `cmake-variants.yaml` then simply makes the VSCode CMake extension aware of the custom types.

## Useful shortcuts

| shortcut | name | description|
|----------|------|------------|
| Ctrl+P   | Quick Open | open any file in workspace |
| Ctrl+T   | 

## Other extensions

### disassembly view

The standard C/C++ extension set comes with a disassembly view, but, at the time of this writing, it has several limitations:
1. only accessible while debugging
2. does not include debugging labels (such as function names)
3. does not link highlighted code between C++ and assembly editors

Instead, try this extension:
```
ext install harikrishnan94.cxx-compiler-explorer
```
Once installed, we need to tell it where to find the `compiler_commands.json` by setting the `Compilation Directory` to 
```
${workspaceFolder}/build/Debug
```
Note that this extension does not observe the CMake Extension settings variables, and so does not know about `${buildType}`. For this reason we must point it at the directory of a particular CMake build type, `Debug` in this case.

At this point the disassembly view can be accessed by giving focus to a C/C++ Editor and then choosing `C++ Compiler Explorer: Disassemble file` from the Command Palette. I recommend giving this command a shortcut such as Ctrl+D.

Missing from the disassembly view (and all others in VSCode) is the machine code.

### web search

This extension makes it easier to look up documentation on syntax, keywords, and libraries, from within your code editor:
```
ext install TwoUnderscorez.vscode-websearch
```

## Snippets

Intellisense provides shortcuts for commonly used text, called `snippets`. For example, if we type the word `for` in a C++ file intellisense will pop up a list of suggestions, with `for` next to an open square at the top of the list. The square indicates that a suggest is a snippet. Pressing enter will activate the snippet, and the following code will be inserted, with the cursor moving between the various sections when tab is pressed:
```cpp
	for (size_t i = 0; i < count; i++)
	{
		/* code */
	}
```

You can create custom snippets, either globally or for a particular workspace, with the option of targetting a particular language. For example, I want a decorative "header" to distinguish sections in my `CMakeLists.txt` files. I'll call it `header1` and I want it to look like this:
```cmake
##################################################
## <section name>
##################################################
<cursor>
```
The "Configure User Snippets" from command palette, choose cmake from the drop-down list of languages, and then fill in the file with the following:
```
{
	"header1": {
		"prefix": "header1",
		"body": [
			"##################################################",
			"## ${1:sectionName}",
			"##################################################",
			"${2}"
		],
		"description": "level 1 header"
	}
}
```

## GitHub Copilot

### Refactoring

Here's an example. I have updated `Catch2` and `Approx` is no longer supported. So this line
```cpp
  CHECK(x == Approx(y));
```
needs to be changed to this line
```cpp
  CHECK_THAT(x, WithinAbs(y, tolerance));
```
Once I make the change in one place, in the next such change
```cpp
  CHECK(a == Approx(b*b));
```
I can just type this before the target statement
```cpp
  CHECK_THAT
```
and Copilot will generate the correct statement with the correct variables, apparently using the context to determine those variables
```cpp
  CHECK_THAT(a, WithinAbs(b*b, tolerance));
```

Here's another example of moving to `almost always auto`. Given any variable declaration of template type such as
```cpp
vector<int> numbers = {1,2,3};
```
we can type `auto` (in some cases need `auto numbers`) on an empty line before and find the following suggestion:
```cpp
auto numbers = vector<int>{1,2,3};
```

## References

* https://www.pragmaticlinux.com/2021/07/import-a-cmake-project-into-visual-studio-code/


## Migrating from Eclipse CDT

* C++ Intellisense
   * Handles C++20 constructs (concepts, etc...) perfectly.
* Source control
   * You will generally have to switch between `Explorer` and `Source Control` views to do your git work.
   * You cannot just right-click on a folder to add it to `.gitignore` as this will add all of the files individually. Instead you must manually add folder to `.gitignore`.

   ## Comparisons to CLion

   | feature | Eclipse | CLion | VSCode | 
   |---------|---------|-------|--------|
   | launch control | easy via run and debug configs | easy and allows sudo |yes | not 
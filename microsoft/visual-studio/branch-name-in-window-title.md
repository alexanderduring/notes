
Branch name in window title in Visual Studio
============================================

To see the branch name of the solution you have currently open in Visual Studio you need to follow this steps:

Install the Visual Studio Window Title Changer
----------------------------------------------

Open "TOOLS" -> "Extensions and Updates" -> "Online"  and search for "Window Title".
Install the Visual Studio Window Title Changer.
Restart the IDE

Define your window title string
-------------------------------

Let us assume, that your repository is named "My Repository" and you have checked out a working copy in the folder "Development".

Open "TOOLS" -> "Options" -> "VS Window Tilte Changer" -> "Settings" -> "Window Title Setup" -> "..."
Replace the window title expression by this and hit save:

if (sln_path=~"^.*Development/My Repository/(?<branch>.*)/(?<solution_folder>.*)/(?<solution_name>.*)\.sln$") {
    $solution_name + " (" + $branch + ")"
} else {
    orig_title
}

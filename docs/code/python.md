# Python
## Reference
=== "Documentation"
    - [Python Docs](https://docs.python.org/)
    - [Python StyleGuide](https://google.github.io/styleguide/pyguide.html)
    - [W3Schools](https://www.w3schools.com/python/default.asp)
=== "Books"
    - [Python Crash Course, 2nd edition](https://nostarch.com/pythoncrashcourse2e)
    - [Learn Python 3 the Hard Way](https://dl.acm.org/doi/book/10.5555/3164654)
    - [Learn More Python 3 the Hard Way](https://dl.acm.org/doi/book/10.5555/3176168)
    - [Automate the Boring Stuff with Python, 2nd Edition](https://nostarch.com/automatestuff2)
=== "Learning"
    - [Geeks for Geeks: Python](https://www.geeksforgeeks.org/python-programming-language)
    - [Learn Python 3: Absolute Begginers](https://www.tutorialspoint.com/python3/index.htm)
=== "Git Repositories"
    - [Easy-Python](https://easy-python.readthedocs.io)
    - [Tools of the Trade](https://github.com/cjbarber/ToolsOfTheTrade)
    - [Awesome Python](https://github.com/vinta/awesome-python)


## Pip
!!! tip "Pip"
    Install Pip
    ```
    $> curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    $> python3 get-pip.py --user
    ```
    Upgrade Pip
    ```
    $> python3 -m pip install --upgrade pip
    ```
    Update Pip Package
    ```
    $> pip3 install --upgrade --force-reinstall
    ```
    Freeze Pip packages
    ```
    $> pip3 freeze > requisites.txt
    ```

### Reference
=== "Documentation"
    - [MkDocs Documentation](https://www.mkdocs.org/)
    - [Python Markdown Extensions](https://python-markdown.github.io/extensions)


## VirtualEnv
!!! tip "VirtualEnv"
    Install VirtualEnv with Pip
    ```
    $> pip3 install virtualenv
    ```
    Create a VirtualEnv project in the repo, take care that the path must be in the .gitignore file.
    ```
    $> virtualenv -p python3.9 venv
    $> source venv/bin/activate
    $> pip install -r requeriments.txt
    ```

### Reference
=== "Documentation"
    - [MkDocs Documentation](https://www.mkdocs.org/)
    - [Python Markdown Extensions](https://python-markdown.github.io/extensions)

## MkDocs
!!! tip "MkDocs"
    Install mkdocs with Pip
    ```
    $> pip3 install mkdocs
    ```
    Create a MkDocs project
    ```
    $> python3 -m mkdocs new .
    ```
    Run the project and go to http://localhost:8000
    ```
    $> python3 -m mkdocs serve
    ```

### Reference
=== "Documentation"
    - [MkDocs Documentation](https://www.mkdocs.org/)
    - [Python Markdown Extensions](https://python-markdown.github.io/extensions)
=== "Themes"
    - [Material for MkDocs](https://squidfunk.github.io/mkdocs-material)

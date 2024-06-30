# Shell scripting
## Reference
=== "Documentation"
    - [Shell StyleGuide](https://google.github.io/styleguide/shellguide.html)
    - [Gnu Bash](https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html)
    - [SS64: Bash](https://ss64.com/bash/)

=== "Books"
    - [Bash Cookbook, 2nd Edtion](https://www.oreilly.com/library/view/bash-cookbook-2nd/9781491975329)

=== "Git Repositories"
    - [Awesome Shell](https://github.com/alebcay/awesome-shell)

## Variables

!!! info

    The action taken by the shell will be different on each value here are some samples:
    ```
    FILE    = "$PATH/this_is_a_file"
    PATH    = "/home/user/"
    STRING  = 'Hello World'
    COMMAND = $( ls -l )
    ```
### Shell Built-In
Built-in variables are automatically set by the shell and are typically used inside shell scripts

!!! info
    | Variable | Description                           |
    | -------- | --------------------------------------|
    | `$#`     | Number of command-line arguments      |
    | `$_`     | Options currently effect              |
    | `$?`     | Exit value of the last exec command   |
    | `$$`     | Process number of current process     |
    | `$!`     | Process number of the last bg command |
    | `$0`     | First word, that is the command name  |
    | `$1-9`   | Individual arguments (positional)     |
    | `$*`     | Location of the user’s mail spool     |
    | `"$@"`   | Location of the user’s mail spool     |

### Substitution
!!! info
    | Variable            | Description                                                     |
    | ------------------- | --------------------------------------------------------------- |
    | `var = value`       | Set each variable `var` to a value                              |
    | `${ var }`          | Use value of `var`                                              |
    | `${ var :- value }` | Use `var` if set; otherwise, use value                          |
    | `${ var := value }` | YUse `var` if set; otherwise, use value and assign value to var |
    | `${ var :? value }` | Use `var` if set; otherwise, print value and exit               |
    | `${ var :+ value }` | Use value if `var` is set; otherwise, use nothing               |

### Variables
These variables are typically used in your ".profile" file, and can be shown running "echo $VAR".
!!! info "Variables"
    | Variable     | Description                                 |
    | ------------ | ----------------------------------          |
    | `USER`       | Your current username                       |
    | `HOSTNAME`   | Hostname of the computer                    |
    | `SHELL`      | Path to the current command shell           |
    | `PWD`        | Current working directory                   |
    | `HOME`       | Home directory                              |
    | `MAIL`       | Location of the user’s mail spool           |
    | `LANG`       | Current language                            |
    | `TZ`         | Time zone                                   |
    | `PS1`        | Default prompt in bash                      |
    | `TERM`       | Current terminal type                       |
    | `DISPLAY`    | Display used by X                           |
    | `EDITOR`     | Text editor                                 |
    | `MANPATH`    | Path for Man pages                          |
    | `OSTYPE`     | Type of operating system                    |
    | `SECONDS`    | Seconds since the script was started        |
    | `RANDOM`     | Returns a different random number each time |

### Getopts
With a "getops" case you can add more logic to your scripts, making them more complex. It will take the command line arguments to but  they have to be added before a "parameter"

??? example
    ```bash
    #!/bin/bash
    while getopts :a:b:c: opt ; do
      case ${opt} in
      a)
        arg1="${OPTARG}"
        ;;
      b)
        arg2="${OPTARG}"
        ;;
      c)
        arg3="${OPTARG}"
        ;;
      \?)
        echo "Invalid option: -$OPTARG" >&2
        ;;
      esac
    done
    echo $arg1 $arg2 $arg3
    ```

### Split strings

Capture values from an output and use them in your script. Imagine that you want to parse a "free -m" command and get some values to work     with. If you run this command it will show you a "table" with all the metrics so let's manipulate this output.

The standard output for free is this:

!!! example
    ```bash
    free -m
                  total        used        free      shared  buff/cache   available
    Mem:          15896        1300       12360         359        2236       13906
    Swap:          2047         998        1049
    ```

As you know, to calculate avilable memory on a linux you must calculate with this expresion:
!!! tip
    Free Memory = ( Total - Used + Buffer + Cache )

We must parse the command and get the 2nd, 3rd and 6th values. Here, we should use "set --   $FREE_MEM" to parse this output, check this  out:

??? example
    ```bash
    #!/bin/bash

    FREE_CMD=$(free -m | grep 'Mem:' )
    echo $FREE_CMD                            # DEBUG COMMAND OUTPUT
    echo ""
    set -- $FREE_CMD                          # HERE WE PARSE ARGUMENTS FROM "$FREE_CMD" OUTPUT

    # NOW I TAKE ARG VALUES AND SUBSTITUTE THEM AS INTEGERS
    # WITH ": '\([0-9]\+\)'" AFTER THE EXPR VALUE TAKEN.
    TOTAL_MEM=$(expr "${2}" : '\([0-9]\+\)')  # ARG2 is TOTAL_MEM.
    USED_MEM=$(expr "${3}" : '\([0-9]\+\)')   # ARG3 is USED_MEM.
    FREE_MEM=$(expr "${4}" : '\([0-9]\+\)')   # ARG4 is FREE_MEM.
    CACHE_MEM=$(expr "${6}" : '\([0-9]\+\)')  # ARG4 is CACHE_MEM.

    # PRINT VARIABLES
    echo "Total: $TOTAL_MEM"
    echo "Used: $USED_MEM"
    echo "Buff/Cache: $CACHE_MEM"
    echo "Free: $FREE_MEM"

    # CALCULATE MEMORY
    MEM_USED=$(($USED_MEM + $CACHE_MEM))      # CALCULATE $USED_MEM + $CACHE_MEM
    AVAIL_MEM=$(($TOTAL_MEM - $MEM_USED))     # CALCULATE $TOTAL_MEM - $MEM_USED
    echo "Available: $AVAIL_MEM"              # PRINT AVAIL_MEM VALUE
    echo ""

    # TEST SCRIPT
    if [ $AVAIL_MEM -eq $FREE_MEM ]; then
       echo "Script is done"
    else
       echo "Something was wrong"
    fi
    ```

### Substitution
??? example
    ```bash
    #!/bin/bash

    while getopts :a:b:c: opt ; do
      case ${opt} in
        a)
          ANIMAL="${OPTARG}"
          ;;
        b)
          CITY="${OPTARG}"
          ;;
        c)
          OWNER="${OPTARG}"
          ;;
        \?)
          echo "Invalid option: -$OPTARG" >&2
          ;;
        esac
      done

    ANIMAL=${ANIMAL:-"dog"}
    OWNER=${OWNER:-"John"}
    CITY=${CITY:-"Madrid"}

    echo "$OWNER has a $ANIMAL and lives in $CITY"
    ```

## Redirects

!!! info

    Unix / Linux standard I/O streams with numbers:

    | Handle | Name   | Description                          |
    | ------ | ------ | ------------------------------------ |
    | 0      | stdin  | Get input from keyboard or program   |
    | 1      | stdout | Write information on screen or file  |
    | 2      | stderr | Show error message on screen or file |

??? example

    ```
    command >   filename	    Redirect stdout to file “filename.”
    command >>  filename	    Redirect and append stdout to file “filename.”

    command 2>  filename	    Redirect stderr to file “filename.”
    command 2>> filename	    Redirect and append stderr to file “filename.”

    command &>  filename
    command >   filename 2>&1	Redirect both stdout and stderr to file “filename.”

    command &>> filename
    command >>  filename 2>&1	Redirect both stdout and stderr append to file “filename.”
    ```

## Operators


### Arithmetic
!!! info
    ```bash
    +  -- echo `expr 3 + 4`        # 7
    += -- n=3;echo $((n += 4))     # 7
    -  -- echo `expr 10 - 3`       # 7
    -= -- n=10;echo $((n -= 3))    # 7
    *  -- echo $((7 * 3))          # 21
    *= -- n=7;echo $((n * 11))     # 77
    ** -- echo $((7 ** 3))         # 343
    /  -- let n=21/3;echo $n       # 7
    /= -- n=21;let n=n/3;echo $n   # 7
    %  -- echo `expr 21 % 4`       # 1 (reminder)
    %= -- n=21; expr `expr $n % 4` # 1 (reminder)
    ```

### String
!!! info
    ```bash
    >,< -- String length compare
    -z  -- Zero length
    -n  -- Non-zero length
    ```

### Compare
!!! info
    ```bash
    -eq,== -- Equal
    -ne,!= -- Not equal
    -gt,>  -- Greater than
    -ge,>= -- Greater than or equal
    -lt,<= -- Less than
    -le,<  -- Less than or equal
    ```

### File
!!! info
    ```bash
    -e    -- File or folder exists
    -f    -- File exists
    -d    -- Folder exists
    -s    -- File size is more than zero
    -b    -- File is a block special
    -c    -- File is a character special
    -p    -- File is a pipe
    -h,-L -- File is a symbolic link
    -S    -- File is a Socket
    -t    -- File is associated with a terminal
    -r    -- File has read permission
    -w    -- File has write permission
    -x    -- File has execute permission
    -g    -- File has SGID associated
    -u    -- File has SUID associated
    -k    -- File has Sticky bit
    -O    -- File has Owner ID
    -G    -- File has Group ID
    -N    -- File has been modified
    -nt   -- File is "Newer than" other
    -ot   -- File is "Older than" other
    -ef   -- File has two or more hardling pointing at same file
    ```

### Increment / Decrement
!!! example
    ```bash
    ++ -- i=1;echo $((++i+7)) # 9 (PRE)
    ++ -- i=1;echo $((i++))   # 1 (POST)
    -- -- i=7;echo $((--i-1)) # 5 (PRE)
    -- -- i=7;echo $((--i))   # 6 (POST)
    ```

### Logical
!!! example
    ```bash
    && -- if [[ $INT = 7 && $STRING = "Lucky" ]]; then echo "Lucky Strike"; fi # AND
    -a -- if [ 7 -gt 1 -a 7 -lt 8 ]; then echo "OK"; fi                        # AND
    || -- if [[ $INT = 7 || $STRING = "Lucky" ]]; then echo "Lucky Strike"; fi # OR
    -o -- if [ 7 -gt 1 -a 8 -gt 7 ]; then echo "OK"; fi                        # OR
    !  -- if [[ !$STRING ]]; then echo "Not so lucky"; fi                      # NOT
    ```
### Ternary
‘?:’ operator can be used as an alternative of if statement. The logical condition is defined before ‘?’  and if the condition returns true then it will execute the statement that is defined before ‘:’ otherwise it will execute the statement that is defined after ‘:’. The following script shows the use of this operator.
!!! example
    ```bash
    #!/bin/bash

    n=20
    a=100
    b=200
    echo $(( n>=101 ? a : b )) # if n is "great or equal" to 101 then "echo" a, else "echo" b
    ```

### Bitwise
!!! info
    ```bash
    &
    &=
    |
    |=
    >>
    >>=
    ```
### comma 'operators'

‘,’ operator is used to execute multiple statements in a line. The following command shows the use of this operator. The value of $n is assigned to 10, 30 is added with $n and the value of $n is printed.
!!! example
    ```bash
    #!/bin/bash

    echo "$(( n=10, n=n+30 ))"
    ```

## Functions
Think of a function as a small script within a script. It's a small chunk of code which you may call multiple times within your script. They are particularly useful if you have certain tasks which need to be performed several times.
!!! tip
    ``` bash
    function_name () {
      commands
    }

    function_name () { commands; }
    ```
!!! tip
    ```
    function function_name {
      commands
    }

    function function_name { commands; }
    ```
??? example "Hello World"
    ```bash
    #!/bin/bash

    hello_world () {
       echo 'hello, world'
    }

    hello_world
    ```
    OUTPUT:
    ```
    Hello, world
    ```

??? example "Variable Scope #1"

    ```bash
    #!/bin/bash

    var1='A'
    var2='B'

    my_function () {
      local var1='C'
      var2='D'
      echo "Inside function: var1: $var1, var2: $var2"
    }

    echo "Before executing function: var1: $var1, var2: $var2"

    my_function

    echo "After executing function: var1: $var1, var2: $var2"
    ```
    OUTPUT:
    ```
    Before executing function: var1: A, var2: B
    Inside function: var1: C, var2: D
    After executing function: var1: A, var2: D
    ```

??? example "Variable Scope #2"
    ```bash
    #!/bin/bash

    die(){
      local m="$1"  # the first arg
    	local e=$2    # the second arg
    	echo "$m"
      exit $e
    }

    # if not enough args displayed, display an error and die
    [ $# -eq 0 ] && die "Usage: $0 filename" 1

    # Rest of script goes here
    echo "We can start working the script..."
    ```
    OUTPUT:

    if a parameter is added:
    ```
    We can start working the script...
    ```
    if not then:
    ```
    Usage: <script_filename> filename
    ```

## Shell Expansions
- [GNU reference](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html)
!!! info
    ```bash
    touch {file1,file2}.md
    mkdir -p $HOME/{dir1,dir2}
    ```
### Patterns
!!! info
    | Pattern      | Description                                                     |
    | -----------  | --------------------------------------------------------------- |
    |`*`	       | Match zero or more characters                                   |
    |`?`	       | Match any single character                                      |
    |`[...]`       | Match any of the characters in a set                            |
    |`?(patterns)` | Match zero or one occurrences of the patterns (extglob)         |
    |`*(patterns)` | Match zero or more occurrences of the patterns (extglob)        |
    |`+(patterns)` | Match one or more occurrences of the patterns (extglob)         |
    |`@(patterns)` | Match one occurrence of the patterns (extglob)                  |
    |`!(patterns)` | Match anything that doesn't match one of the patterns (extglob) |

### Glob Regex
!!! info
    | Glob          | Regular Expression Equivalent | Description                                |
    | ------------- | ----------------------------- | ------------------------------------------ |
    | `?(patterns)` | `(regex)?`                    | Match an optional regex                    |
    | `*(patterns)` | `(regex)*`                    | Match zero or more occurrences of a regex  |
    | `+(patterns)` | `(regex)+`                    | Match one or more occurrences of a regex   |
    | `@(patterns)` | `(regex)`	                    | Match the regex (one occurrence)           |

## Statements


### For
Run a command in between "$(command)" to iterate:
!!! example "command"
    ```bash
    #!/bin/bash

    for i in $( ls -1 ); do
      echo $i
    done
    ```
!!! example "sequence"
    Run a sequence in between "seq 1 10" to iterate:
    ```bash
    #!/bin/bash

    for i in `seq 1 10`; do
      echo $i
    done
    ```
### While
!!! example
    ```bash
    #!/bin/bash

    COUNTER=0
    while [  $COUNTER -lt 10 ]; do
        echo The counter is $COUNTER
        let COUNTER=COUNTER+1
    done
    ```
### Until
!!! example
    ```bash
    #!/bin/bash

    COUNTER=20
    until [  $COUNTER -lt 10 ]; do
        echo COUNTER $COUNTER
        let COUNTER-=1
    done
    ```

## Arithmetic

### let expression"
        Make a variable equal to an expression.
!!! info
        ```
        Operator	    Operation
        +, -, \*, /	  Addition, subtraction, multiply, divide
        var++	        Increase the variable var by 1
        var--	        Decrease the variable var by 1
        %	            Modulus (Return the remainder after division)
        ```
!!! example
    ```bash
    #!/bin/bash
    let a=5+4
    echo $a # 9

    let "a = 5 + 4"
    echo $a # 9

    let a++
    echo $a # 10

    let "a = 4 * 5"
    echo $a # 20

    let "a = $1 + 30"
    echo $a # 30 + first command line argument
    ```

### expr expression
Print out the result of the expression.
!!! example
    ```bash
    #!/bin/bash

    # Basic arithmetic using expr
    expr 5 + 4
    expr "5 + 4"
    expr 5+4
    expr 5 \* $1
    expr 11 % 2
    a=$( expr 10 - 3 )
    echo $a # 7
    ```
### $(( expression ))
Return the result of the expression.
!!! example
    ```bash
    #!/bin/bash

    # Basic arithmetic using double parentheses
    a=$(( 4 + 5 ))
    echo $a # 9
    a=$((3+5))
    echo $a # 8
    b=$(( a + 3 ))
    echo $b # 11
    b=$(( $a + 4 ))
    echo $b # 12
    (( b++ ))
    echo $b # 13
    (( b += 3 ))
    echo $b # 16
    a=$(( 4 * 5 ))
    echo $a # 20
    ```

### ${#var} expression
Return the length of the variable var.
    ```bash
    #!/bin/bash

    # Show the length of a variable.
    a='Hello World'
    echo ${#a} # 11
    b=4953
    echo ${#b} # 4
    ```

## + More Scripts
???- tip "Scripts"
    === "colors"
        ```bash
        #!/bin/bash

        for x in {0..8}; do
          for i in {30..37}; do
            for a in {40..47}; do
              echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m ";
            done;
          echo;
          done;
        done
        ```

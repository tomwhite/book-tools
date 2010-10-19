: == uname_command
: == date_command
echo "Ignored"
: vv uname_command
uname
: ^^ uname_command
: vv date_command
date
: ^^ date_command
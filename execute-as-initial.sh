# This function will execute a command as the original account
# that a user logged in with. This is useful in conjunction with
# su and sudo.
#
# e.g.
# If you su to root ${HOME} will be /root rather than the home
# of the account you initially logged in with.
#
# execute-as-login COMMAND [VARIABLE]
#
# Results can be passed back via a variable similar to how
# read works or simply through command substituion.
#
# execute-as-initial 'echo ${HOME}' MY_REAL_HOME
# or
# MY_REAL_HOME=$(execute-as-initial 'echo ${HOME}')

function execute-as-initial {

# Gracefully handle calls with a users original UID.
if [[ $(whoami) == $(logname) ]]; then
  RESULT=$($1)
  EXIT=$?
else
  RESULT=$(su $(logname) -c "$1")
  EXIT=$?
fi

if [[ "$2" ]]; then
  eval $2="'$RESULT'"
else
  echo "$RESULT"
fi
  return $EXIT
}

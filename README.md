emacs-shell-config
==================

first off - install git. Just do it even if you're not using right now.

new to bash on osx? copy [[https://github.com/patarleth/emacs-shell-config/blob/master/bash/.profile]] to ~/.profile
and 

editing your bash_profile etc?  The only thing interesting in my profile is my git integration and even that is very copied from god knows where ;)

So copy the git_prompt() function, and call it in your PS1 var chech the file above to see how I do it.

My PS1 has
    
    1.  who and where you are logge into
    2.  time and date
    3.  git branch and commit status 2 ahead, 1 behind etc
    4.  dir path
    5.  number of files and sum of their size.
    6.  color!

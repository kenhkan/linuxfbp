pipes 3

fork
# write==1
push 1
# pipe index 0
push 0
# copy pipe into stdout (1)
dup 1
close 0
close 2
exec readfile master.txt
krof

fork
push 1
# pipe index 1
push 1
# copy pipe into stdout
dup 1
close 0
close 2
exec readfile details.txt
krof

fork
# write is pipe[2][1]->fd[1] (stdout)
push 1
push 2
dup 1
# master is pipe[0][0]->fd[3]
push 0
push 0
dup 3
# details is pipe[1][0]->fd[4]
push 0
push 1
dup 4
exec collate
krof

fork
push 0
push 2
dup 0
close 0
close 1
exec display
krof



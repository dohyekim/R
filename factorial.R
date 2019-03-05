while(TRUE) {
  x = as.integer(readline(prompt="Input the number>> "))
  if (x<0 0r x="quit")
    break
  f = 1
  if (x == 0)
    print("0! equals to 1")
  else {
    for (i in 1:x)
      f = f * i 
    print(paste("The factorial of",x,"is",f))
  }
  
}
while(TRUE){
  x = as.integer(readline(prompt="Input the number(ex.5, 0 to quit) >> "))
  vect = c(1,1)
  
  if (x <=0) break
  else if (x<=2 & x >0){
    print(vect[1:x])
  }
  else {
    for (i in 1:(x-2)) {
      vect[length(vect)+1] = vect[length(vect)-1]+vect[length(vect)] 
    }
    print(vect[1:x])
  }
  print(vect)
}

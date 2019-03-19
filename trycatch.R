# drv = dbDriver("MySQL")
# conn = dbConnect(drv, host='127.0.0.1', port=3307, dbname='melondb', user='dooo', password='1234')
# dbSendQuery(conn, 'set character set utf8')
# rm(x)
x = stringi::stri_enc_toutf8 ("선물")
# options(encoding='UTF-8')
tryCatch({
  dbBegin(conn)
  dbGetQuery(conn, paste0("update MS_Song set title= '", x, "' where song_no = '30514366'"))
  dbCommit(conn)
},
error = function(e) { 
  dbRollback(conn)
  print(paste("Error!!", e)) 
},
warning = function(w) {
  print(paste("Warining!!", w))
},
finally = {print('Done!!!!!!!!')}
)
  
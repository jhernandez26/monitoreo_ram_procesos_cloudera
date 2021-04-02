#!/usr/bin/env bash

delete_bk(){
    for i in $(ls| grep -v .sh);do
        cd $i && rm -f $i.csv.bkp ;  rm *_all.csv && cd ..
    done
}
create_bk(){
    for i in $(ls| grep -v .sh);do
        cd $i && cp -p $i.csv "$i.csv.bkp" && cd ..
    done
}
#carga 
carga(){
    for i in $(ls| grep -v .sh);do
	    cd $i && file1=$(ls | grep ".*csv-.*"); file2=$(ls | grep ".*.csv$" | grep -v "all") ;echo "cat $file1 >> $file2"   && cd ..
    done
    #delete
}

run_python(){
    for i in $(ls /home/jhernandez/Documentos/RAM/files | grep -v .sh);do
        cd /home/jhernandez/Documentos/RAM/files/$i && ./analasis.py "$i.csv"  && cd ..
    done
}

main(){
    delete_bk
    create_bk
    carga
    run_python
}

main 

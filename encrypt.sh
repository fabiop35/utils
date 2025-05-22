	tar czf - /some-dir-or-file | openssl enc -e -aes-256-cbc -out archive.enc -pass env:PASS

openssl enc -d -aes-256-cbc -in outsrv.enc -pass env:PASS | tar zxf -

---
tar czf - lc | openssl enc -e -aes-256-cbc -out lc.enc
tar czf - tk | openssl enc -e -aes-256-cbc -out tk.enc
tar czf - czic | openssl enc -e -aes-256-cbc -out czic.enc
tar czf - mts | openssl enc -e -aes-256-cbc -out mts.enc

openssl enc -d -aes-256-cbc -in lc.enc | tar zxf -



--131, Sola

tar czf - tk | openssl enc -e -aes-256-cbc -out tk.enc

openssl enc -d -aes-256-cbc -in outsrv.enc  | tar zxf -

1. tar -cvf tk.tar tk

2. openssl enc -e -aes-256-cbc -out mts.enc -in mts.tar

#Octu
scp -i id_rsa_fco_131 czic-lc.tar.enc frontco@150.250.233.131:/export/home/frontco

openssl enc -d -aes-256-cbc -in lc.enc -out filename



scp -i id_rsa_fco_131 czic-lc.tar.enc frontco@150.250.233.131:/export/home/frontco

#
gpg --output fiel.enc --symmetric --cipher-algo AES256 fiel.txt
gpg --output soap.xml --decrypt soap.enc
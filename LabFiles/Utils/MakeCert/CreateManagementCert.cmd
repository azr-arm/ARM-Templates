makecert -r -pe -a sha1 -n "CN=Windows Azure Management Certificate" -ss my -len 2048 -sp "Microsoft Enhanced RSA and AES Cryptographic Provider" -sy 24 -sv AzureMgmtCert.pvk AzureMgmtCert.cer

del AzureMgmtCert.pfx

pvk2pfx -pvk AzureMgmtCert.pvk -spc AzureMgmtCert.cer -pfx AzureMgmtCert.pfx -po Passw0rd!

del AzureMgmtCert.pvk
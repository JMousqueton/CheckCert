
# 🔒 Check Certificat 

Script to check x.509 certificat of website using openssl 

## Badges

[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](LICENSE)

[![Twitter: JMousqueton](https://img.shields.io/twitter/follow/JMousqueton.svg?style=social)](https://twitter.com/JMousqueton)

## Documentation

### Script options 
```Shell
-d <domain>     Domain name (Mandatory).
-h              Print this Help.
-D <99>         Number of days (by default 7 days).
-p <443>        Port (by default 443).
-v              Verbose error message on stderr
```
### return error code 
| Error Code | Description |
|---|---|
| 0 | Not expired |
| 1 | Expired or will expired within 7 days by default |
| 3 | Openssl not installed  |
| 22 | No domain specified or invalid options |
| 101 | Domain doesn't respond   |

## Usage/Examples

```Shell
$ ./checkcert.sh -d www.julien.io -p 443 -D 15 -v
✔ www.julien.io won't expired within 15 days.

$ ./checkcert.sh -d expired.badssl.com -p 443 -D 90 -v
❌ expired.badssl.com has been expired or will expire within 90 days.
```

## Roadmap

| Status | Description |
|---|---|
| ✅ |~~Add "Standard" Linux error code~~|
| ✅ |~~Disable SSL check on curl for website testing~~|

#### Légende

| Status | Description |
|---|---|
| ✅ | Done |
| 🛠 | In progress  |
| 🟢 | Low priority | 
| 🟡 | Medium priority |
| 🔴 | High Priority |


## Authors

👤 **Julien Mousqueton**

* Website: <https://julien.io>
* LinkedIn: [Julien Mousqueton](https://linkedin.com/in/julienmousqueton)
* Twitter: [@JMousqueton](https://twitter.com/JMousqueton)
* Github: [@JMousqueton](https://github.com/JMousqueton)


## License

[GNU 3.0](LICENSE)


## Acknowledgements

 - Ecole 2600 students for the support while coding a sunday evening :) 

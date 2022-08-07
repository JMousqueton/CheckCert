
# Check Certificat 

Script to check x.509 certificat of website using openssl 

## Badges

[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](LICENSE)

[![Twitter: JMousqueton](https://img.shields.io/twitter/follow/JMousqueton.svg?style=social)](https://twitter.com/JMousqueton)

## Documentation

```Shell
options:
-d <domain>     Domain name (Mandatory).
-h              Print this Help.
-D <99>         Number of days (by default 7 days).
-p <443>        Port (by default 443).
-v              Verbose error message on stderr
```

## Roadmap

| Status | Tâche |
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


## Usage/Examples

```Shell
$ ./checkcert.sh -d www.julien.io -p 443 -D 90 -v
✔ www.julien.io won't expired within 7 days.

$ ./checkcert.sh -d expired.badssl.com -p 443 -D 90 -v
❌ expired.badssl.com has been expired or will expire within 7 days.
```


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

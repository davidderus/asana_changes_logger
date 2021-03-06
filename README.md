# Asana Changes Logger

Output your **Asana** changes for a given time to an external file.

## Disclaimer

⚠️ This app is not maintained anymore ⚠️

## Usage

```
usage: asana_changes_logger [options]
    -d, --days            Number of days to get including today (default: 5)
    -s, --start           Number of days in the past to start from (default: 0 for today)
    -p, --project         Project ID
    -o, --output          The output file. Allowed formats: html, md, txt
    -a, --api             Store the given API key and start using it from now
    -lr, --log-remaining  Log remainins tasks too
    -ha, --hide-author    Hide task assignee from changelog
    --sections            Show sections in changelog
    -v, --version         Print the current version
    -h, --help            Print help
```

## Installation

• Clone the repository

``git clone https://github.com/davidderus/asana_changes_logger.git``

• Go in the *asana_changes_logger* directory and build the gem with :

``cd asana_changes_logger && gem build asana_changes_logger.gemspec``

• Install the gem

``gem install asana_changes_logger-1.0.1.gem``

• Register your Asana's API Key (*needed once*) :

``asana_changes_logger -a TheKey``

• Now you can use asana_changes_logger :

``asana_changes_logger -p XXXXXXXXXXXXXX``


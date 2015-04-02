# Asana Changes Logger

Output your **Asana** changes for a given time in an external file.

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
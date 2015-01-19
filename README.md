The gem is used for scanning github accounts and check for certain keywords in there.

It takes a list of username from a CSV file.
Goes and fetches the public repos for those users.
Gets the tree for each of those public repos.
Checks the filenames against the list of keywords.
For repos that match keywords, it writes them down in an output file.

Usage: gh_bb_audit.rb -u <path_to_user_csv_file> -k <path_tpkeywords_csv_file> -o <path_to_output_file>
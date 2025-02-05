# RUM_counter
Script for figuring the total number of resources in Terraform state files.


For TF Community Edition 

Because there is no “cloud platform API” involved with the Community edition of Terraform, each .tfstate file needs to be identified and run against the below script. Multiple State files can be kept in a single directory which is passed to the script as an argument.


Input: You pass the directory containing your .tfstate files as the first argument.

Loop: The script iterates over each .tfstate file in that directory.

jq Command:
- It filters only “managed” resources (ignoring data sources).
- It excludes terraform_data and null_resource.
- It flattens any counted or for_each resources under .instances.
- Finally it returns the number of matching resources (length).

Summation: Each file’s count is accumulated in the TOTAL variable.

Result: After processing all files, the script prints a single total.

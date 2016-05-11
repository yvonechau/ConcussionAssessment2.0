git filter-branch -f --commit-filter '
	if [ "$GIT_AUTHOR_EMAIL" = "seannavien@Seannas-Mac.local" ];
        then
            GIT_AUTHOR_EMAIL="smvien@ucdavis.edu";
            git commit-tree "$@";
        else
            git commit-tree "$@";
        fi' HEAD


#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
pr_branches=`curl https://api.github.com/repos/initcron-abhijit/test/pulls?base=master --user "initcron-abhijit:AbhI#9403" | grep '"ref"': | awk '{print $2}' | sed '/master/d'`
pr_num=`curl https://api.github.com/repos/initcron-abhijit/test/pulls?base=master --user "initcron-abhijit:AbhI#9403" | grep 'issue_url' -A 1 | grep 'number' | awk '{print $2}'`
for i in $pr_num; do echo $i | cut -d',' -f 1 >> pr_ids  ; done
for i in $pr_branches; do echo "$i" | cut -d',' -f1 | sed -e 's/^"//g' -e 's/"$//g' >> pr_branches ; done
count=`cat pr_ids | wc -l`
for ((i=1;i<=$count;i++)
id=`sed -n "{i}p" pr_ids`
branch=`sed -n "{i}p" pr_branches`
grep -P "$id\t$branch" database
if [[ $? != 0 ]]
then
echo -e ""$id\t$branch" >> database
curl --user "user:password" -X POST  "http://192.168.130.205:8080/job/jobname/build" --data token=token --data delay=0sec  --data-urlencode json='{"parameter": {{ "name" : "branch", "value" : "'"$branch"'" }, { "name" : "pr_id", "value" : "'"$id"'" }}}'
fi
done

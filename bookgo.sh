#!/bin/sh
# 记录一下开始时间
echo `date` >> /Users/easter/Documents/bookgolog/log &&
# 进入bookgo.sh 所在目录
cd /Users/easter/Workspace/blingbling &&
# 执行命令
git add . && git commit -m 'Auot-update' && git pull origin master --rebase && git push origin master &&
# 运行完成
echo 'finish' >> /Users/easterfan/Documents/bookgolog/log

TELEGRAM_BOT_TOKEN=${{ secrets.BOT_TOKEN }}

TELEGRAM_USER_ID=${{ secrets.USER_ID }}

URL="https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage"
TEXT="$1 $CI_PROJECT_NAME%0AJOB_STAGE:$CI_JOB_STAGE%0ASTATUS:$CI_JOB_STATUS"

curl -s -d "chat_id=$TELEGRAM_USER_ID&disable_web_page_preview=1&text=$TEXT" $URL > /dev/null

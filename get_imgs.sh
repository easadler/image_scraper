





URL="http://www.stevecarter.com/albumcovers.htm"


DOMAIN=$(echo "$URL" | awk -F/ '{print $3}')
FOLDER="imgs"
mkdir -p "$FOLDER"

HTML=`curl $URL | grep 'src='`


IMG=$(echo "$HTML" | sed '/<img/s/.*src="\([^"]*\)".*/\1/p')

while read pic; do
NAME=$(echo "$pic" | grep -Eo '[^/]+$')
if echo "$pic" | grep -q 'http\|https'; 
then
	 curl -o $FOLDER/$NAME "$pic"
else
	 curl -o $FOLDER/$NAME "http://${DOMAIN}/${pic}"
fi
done <<< "$IMG"
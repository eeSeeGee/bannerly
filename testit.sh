#!/bin/bash

tmpfile=$(mktemp /tmp/bannerly.result.$$)

checkResult() {
  if [ $? -eq 0 ]; then
    echo "OK"
  else
    echo "FAIL"
  fi
}

echo "stg test"
./bannerly.rb --width 3 --height 3 --text aaa --bg stg hello >$tmpfile
diff $tmpfile stgtest.txt
checkResult

echo "stg test no border"
./bannerly.rb --width 3 --height 3 --text aaa --bg stg --noborder hello >$tmpfile
diff $tmpfile stgtestnoborder.txt
checkResult

echo "cash test"
./bannerly.rb --text aaa --bg cash hello >$tmpfile
diff $tmpfile cashtest.txt
checkResult

echo "default test"
./bannerly.rb hello >$tmpfile
diff $tmpfile defaulttest.txt
checkResult

echo "grid test"
./bannerly.rb --text kiss --bg white_square --grid black_square kiss >$tmpfile
diff $tmpfile gridtest.txt
checkResult

rm $tmpfile


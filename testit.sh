#!/bin/bash

tmpfile=$(mktemp /tmp/bannerly.result.$$)

checkResult() {
  if [ $? -eq 0 ]; then
    echo "OK"
  else
    echo "FAIL"
  fi
}

echo "default test"
./bannerly.rb hello >$tmpfile
diff $tmpfile defaulttest.txt
checkResult

echo "stg test"
./bannerly.rb --text aaa --bg stg:3:3 hello >$tmpfile
diff $tmpfile stgtest.txt
checkResult

echo "stg text test"
./bannerly.rb --text stg:3:3 --bg moneybag kiss >$tmpfile
diff $tmpfile stgtexttest.txt
checkResult

echo "stg test no border"
./bannerly.rb --text aaa --bg stg:3:3 --noborder hello >$tmpfile
diff $tmpfile stgtestnoborder.txt
checkResult

echo "kash test"
./bannerly.rb --text aaa --bg kash hello >$tmpfile
diff $tmpfile kashtest.txt
checkResult

echo "grid test"
./bannerly.rb --text kiss --bg black_square --bg white_square kiss >$tmpfile
diff $tmpfile gridtest.txt
checkResult

echo "triple grid test"
./bannerly.rb --text kiss --bg black_square --bg white_square --bg square kiss >$tmpfile
diff $tmpfile triplegridtest.txt
checkResult

echo "big grid test"
./bannerly.rb --text kiss --bg stg:3:3 --bg big-thinking-:4:4 kiss >$tmpfile
diff $tmpfile biggridtest.txt
checkResult

echo "text grid test"
./bannerly.rb --text white_square --text black_square hello >$tmpfile
diff $tmpfile gridtexttest.txt
checkResult

echo "offset background test"
./bannerly.rb --text parrot --bg parrot-wave:7 --bgoffset 1 hello >$tmpfile
diff $tmpfile offsetbgtest.txt
checkResult

rm $tmpfile


find . -name *.bed -xtype f -exec sh -c "cat {} | grep -v ^# | md5sum" \;
find . -name *.bedpe -xtype f -exec sh -c "cat {} | grep -v ^# |md5sum" \;
ls | sed 's/.*\.//' | sort | uniq -c

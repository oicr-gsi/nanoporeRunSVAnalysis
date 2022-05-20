find ./analysis/structural_variants -name *.bed -xtype f -exec sh -c "cat {} | grep -v ^# | md5sum" \;
find ./analysis/structural_variants -name *.bedpe -xtype f -exec sh -c "cat {} | grep -v ^# |md5sum" \;
ls ./analysis/structural_variants | sed 's/.*\.//' | sort | uniq -c

```shell
pip download \
--only-binary :all: \
--platform manylinux1_x86_64 \
--python-version 37 \
--implementation cp \
--abi cp27m -r requirements.txt -d deps

zip -r format-phone-number.zip format-phone-number -x */test/*
mv name-of-file.zip /tmp/
```


```shell
pip download \
--only-binary :all: \
--platform manylinux1_x86_64 \
--python-version 37 -r requirements.txt -d deps

pip download --only-binary :all: -r requirements.txt -d deps
zip -r format-phone-number.zip format-phone-number -x */test/*
mv name-of-file.zip /tmp/
```
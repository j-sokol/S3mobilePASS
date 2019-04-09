S3mobilePASS
============

Wrapper of MobilePASSER that saves config to AWS S3. MobilePASSER is a reimplementation of the MobilePASS client in Python.

A fork from [datr](https://github.com/datr/MobilePASSER), with added backend mode in S3 bucket. This way you can just specify S3 bucket and have configuration synchronized on all your devices.

Also added support for Python 3 (3.6+).

Installation
------------

```
python setup.py install
```

Usage
-----

```
usage: mobilepasser [-h] [-k ACTIVATION_KEY] [-x INDEX] [-p POLICY]
                    [-l OTP_LENGTH] [-a]

optional arguments:
  -h, --help            show this help message and exit
  -k ACTIVATION_KEY, --activation-key ACTIVATION_KEY
                        The string the MobilePass client generated.
  -x INDEX, --index INDEX
                        The index of the token to generate.
  -p POLICY, --policy POLICY
                        Policy for the token.
  -l OTP_LENGTH, --otp-length OTP_LENGTH
                        Length of the returned OTP.
  -a, --auto-update-index
                        Automatically bump the index by 1 and save to config
                        file.
```

Configuration
-------------
The configuration file is read form `~/.mobilepasser.cfg`. An example config file can be found in the examples folder.
```
[MobilePASS]
activation_key = *key*
policy =
index = 1
otp_length = 6
auto_update_index = True
s3_bucket_name = *bucket name in your AWS account*
load_from_s3 = True
awscli_profile = default
```

If you use S3 bucket as your backup, you need to have your AWS-cli credentials set up in `~/.aws/`. This can be set up by installing `awscli`:

```
python3 -m pip install awscli

aws configure
```

Also S3 bucket needs to be already created in your AWS account.


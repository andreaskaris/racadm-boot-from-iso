# Instructions

First, run:
~~~
rm -f hosts
make hosts SERVERS=<ip of ocp idrac> OPENSHIFT_PASS='<idrac password>'
~~~

Verify hosts and group_vars/all.yml. All should be set other than image_location.

Then, run get_discovery_image with the image location that the assisted installer gave you:
~~~
make image_location IMAGE_LOCATION="http://<url>/<iso name>.iso"
~~~

Now, deploy the image to your servers:
~~~
make deploy_openshift
~~~

# Credit where credit is due

The original version of this playbook is from larsks and can be found under
https://gist.github.com/larsks/afd6cb2a3c88447c726d66fc86141184

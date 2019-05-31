[![CircleCI](https://circleci.com/gh/3scale/apicast-example-policy.svg?style=svg)](https://circleci.com/gh/3scale/apicast-example-policy)

# APIcast Example Policy

This policy is an example how to make custom policies for APIcast.


## OpenShift




## Install 3scale

oc new-project anugraha-ssl

oc new-app -f https://raw.githubusercontent.com/3scale/3scale-amp-openshift-templates/2.5.0.GA/amp/amp.yml -p MASTER_PASSWORD=master -p ADMIN_PASSWORD=admin -p WILDCARD_DOMAIN=anugraha-ssl.apps.rhpds311.openshift.opentlc.com 
oc set resources dc/apicast-production --requests=cpu=100m,memory=64Mi --limits=cpu=200m,memory=128Mi
oc set resources dc/apicast-wildcard-router --requests=cpu=120m,memory=32Mi --limits=cpu=300m,memory=64Mi
oc set resources dc/backend-listener --requests=cpu=300m,memory=400Mi --limits=cpu=400m,memory=600Mi
oc set resources dc/backend-worker --requests=cpu=100m,memory=50Mi --limits=cpu=200m,memory=200Mi
oc set resources dc/system-sidekiq  --requests=cpu=100m,memory=200Mi --limits=cpu=300m,memory=300Mi
oc set resources dc/system-sphinx --requests=cpu=80m,memory=200Mi --limits=cpu=200m,memory=300Mi
oc set resources dc/zync --requests=cpu=150m,memory=100Mi --limits=cpu=300m,memory=250Mi

oc set resources dc/system-redis --requests=cpu=50m,memory=32Mi --limits=cpu=200m,memory=128Mi
oc set resources dc/backend-redis --requests=cpu=50m,memory=32Mi --limits=cpu=200m,memory=128Mi
oc set resources dc/zync-database --requests=cpu=50m,memory=200Mi --limits=cpu=250m,memory=250Mi
oc set resources dc/system-mysql --requests=cpu=200m,memory=512Mi --limits=cpu=300m,memory=600Mi
oc set resources dc/system-app -c system-master --requests=cpu=50m,memory=600Mi --limits=cpu=250m,memory=800Mi
oc set resources dc/system-app -c system-provider --requests=cpu=50m,memory=600Mi --limits=cpu=250m,memory=800Mi
oc set resources dc/system-app -c system-developer --requests=cpu=50m,memory=600Mi --limits=cpu=250m,memory=800Mi


## Install sample ssl application

oc new-app java:8~https://github.com/pajikos/java-examples.git --context-dir=spring-rest-api-client-auth --name=sample-ssl-api


## Uninstall project

oc delete project anugraha-ssl


## Create custom apicast build

oc new-app -f https://raw.githubusercontent.com/adithaha/apicast-ssl-passthrough-policy/master/openshift.yml --param AMP_RELEASE=2.5.0

## Build custom apicast

oc start-build apicast-ssl-passthrough-policy --follow
oc start-build apicast-custom-policies --follow



To install this on OpenShift you can use provided template:

```shell
oc new-app -f openshift.yml --param AMP_RELEASE=2.2.0
```


b6be8a061af41fd3d5de41da7bbb98a0bcf91c9edb6213048c8293d9023b892d

oc create secret generic apicast-configuration-url-secret --from-literal=password=https://b6be8a061af41fd3d5de41da7bbb98a0bcf91c9edb6213048c8293d9023b892d@anugraha-admin.3scale.net  --type=kubernetes.io/basic-auth

oc new-app -f https://raw.githubusercontent.com/3scale/3scale-amp-openshift-templates/2.5.0.GA/apicast-gateway/apicast.yml

oc new-app -f openshift.yml --param AMP_RELEASE=2.5.0
oc start-build apicast-ssl-passthrough-policy
oc start-build apicast-custom-policies

The template creates new ImageStream for images containing this policy.
Then it creates two BuildConfigs: one for building an image to apicast-policy ImageStream
and second one for creating new APIcast image copying just necessary code from that previous image.


# License

MIT



oc delete bc apicast-production apicast-staging apicast-wildcard-router backend-cron backend-listener zync-database  zync  system-sphinx  system-sidekiq backend-redis backend-worker system-app system-memcache system-mysql system-redis 
oc delete pvc backend-redis-storage mysql-storage system-redis-storage system-storage 
oc delete configmap apicast-environment backend-environment mysql-extra-conf mysql-main-conf redis-config smtp system system-environment
oc delete secret backend-internal-api backend-listener backend-redis system-app system-database  system-events-hook system-master-apicast system-memcache system-recaptcha system-redis system-seed zync  
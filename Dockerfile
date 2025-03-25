# FROM docker.io/bitnami/kubectl:1.28.15
FROM registry.cn-hangzhou.aliyuncs.com/bocloud/kubectl:1.28.15
ADD static /static
CMD ["proxy", "--www=/static", "--accept-hosts=^.*$", "--address=[::]", "--api-prefix=/k8s/", "--www-prefix="]


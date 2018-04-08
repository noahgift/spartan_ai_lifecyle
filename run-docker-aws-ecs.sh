#To integrate this with the AWS container registry, you would need to login:
AWS_PROFILE=metamachine
AWS_DEFAULT_REGION=us-east-1
export AWS_PROFILE
export AWS_DEFAULT_REGION

aws ecr get-login --no-include-email --region us-east

#Then build this image locally:
docker build -t metamachine/lambda-tester .

#Next, it gets tagged
docker tag metamachine/lambda-tester:latest 907136348507.dkr.ecr.us-east-1.amazonaws.com/metamachine/myorg/name:latest

#Then it gets pushed to the AWS registry
docker push 907136348507.dkr.ecr.us-east-1.amazonaws.com/metamachine/lambda-tester:latest

#At this point, other members of the organization can run this image by pulling it down locally:
docker pull 907136348507.dkr.ecr.us-east-1.amazonaws.com/metamachine/lambda-tester:latest

#Next, running the image is pretty straightforward, so here is example of you run the image and mount your local filesystem as well:
docker run -i -t -v `pwd`:/project 907136348507.dkr.ecr.us-east-1.amazonaws.com/ metamachine/lambda-tester /bin/bash

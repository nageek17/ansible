FROM python:3.8

# install pip for Python 2. this image already has Python 2 itself
RUN apt-get update && apt-get -y install python-pip git git-crypt vim 

# install ansible and boto libraries for Python 2 and Python 3
# boto is the Python library to interface with AWS
RUN pip2 install ansible==2.9 boto boto3
RUN pip3 install ansible==2.9 boto boto3

COPY .bashrc /root/.bashrc

CMD ["tail", "-f", "/dev/null"]


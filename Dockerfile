FROM octopusdeploy/tentacle:6.0.390
ARG DEBIAN_FRONTEND=noninteractive

RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl
RUN kubectl version --client

RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
RUN helm version

RUN apt-get update
RUN apt-get install --no-install-recommends apt-utils -y
RUN apt-get install --no-install-recommends unzip -y
RUN curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip
RUN unzip awscliv2.zip
RUN ./aws/install
RUN aws --version

RUN curl https://amazon-eks.s3.us-west-2.amazonaws.com/1.18.9/2020-11-02/bin/linux/amd64/aws-iam-authenticator -o aws-iam-authenticator
RUN chmod +x ./aws-iam-authenticator
RUN mv ./aws-iam-authenticator /usr/local/bin/aws-iam-authenticator
RUN aws-iam-authenticator help

RUN apt-get install --no-install-recommends apt-transport-https lsb-release gnupg -y
RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/microsoft.gpg
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" > /etc/apt/sources.list.d/azure-cli.list
RUN apt-get update
RUN apt-get install azure-cli=2.7.0-1~buster -y
RUN az version

RUN apt-get install python3 -y
RUN python3 --version
RUN apt-get install python3-pip -y
RUN python3 -m pip --version

RUN curl https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb -o packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-get update
RUN apt-get install powershell -y
RUN pwsh -v

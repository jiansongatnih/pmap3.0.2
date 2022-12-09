# Use the Ubuntu 20.04 LTS as the base image
FROM ubuntu:20.04

# Setup a sudo account
RUN apt-get update && apt-get -y install sudo

# Create a virtual environment in Ubuntu 20.04
RUN apt-get -y upgrade
RUN apt-get -y install python3-venv
RUN python3.8 -m venv /opt/venv
RUN . /opt/venv/bin/activate
    
# Below ENV variables required to install dependencies non-interactively
ENV TZ=America/Los_Angeles
ENV DEBIAN_FRONTEND noninteractive
ENV QT_DEBUG_PLUGINS=1 
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
    
# Install dependencies
RUN sudo apt-get install gcc libpq-dev -y
RUN sudo apt-get install python3-dev python3-pip python3-venv python3-wheel -y
RUN sudo apt-get install -y libdbus-1-3 libxkbcommon-x11-0 libxcb-icccm4 \
    libxcb-image0 libxcb-keysyms1 libxcb-randr0 libxcb-render-util0 \
    libxcb-xinerama0 libxcb-xinput0 libxcb-xfixes0
RUN apt-get install -y libqt5gui5
RUN sudo apt-get install -yq libgl1-mesa-glx
RUN sudo apt-get install -yq libgtk2.0-dev
RUN sudo pip uninstall opencv-python
RUN sudo pip install opencv-python-headless
RUN sudo apt install libxcb-xinerama0
RUN sudo apt install -yq libxcb-shape0-dev

# Install RAPID
RUN pip install pmap3.0.2
RUN export QT_DEBUG_PLUGINS=1
RUN export PATH=$PATH:~/Qt/Tools/QtCreator/bin
RUN export LIBGL_ALWAYS_INDIRECT=1

# Open RAPIDG application
CMD ["RAPIDG"]

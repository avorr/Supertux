common_packages:
  pkg.installed:
    - pkgs:
      - gettext
      - autoconf
      - codeblocks
      - subversion 
      - automake 
      - jam
      - g++
      - libfreetype6-dev
      - libharfbuzz-dev
      - libfribidi-dev 
      - gtk-doc-tools 
      - libjpeg-dev 
      - libwebp-dev
      - libtiff5-dev 
      - libsdl2-image-dev
      - libsdl2-image-2.0-0
      - libsdl2-dev 
      - cmake 
      - build-essential
      - liballegro-physfs5-dev
      - vorbis-tools
      - freeglut3-dev
      - libglu1-mesa-dev
      - mesa-common-dev
      - libopenal1
      - libopenal-dev 
      - libalut0 
      - libalut-dev
      - libcurl4-openssl-dev
      - libboost-dev
      - libboost-all-dev
      - libglew-dev
    
clone supertux from github:
  git.latest:
    - name: https://github.com/SuperTux/supertux.git
    - target: /opt/supertux
    - submodules:
      - True
      - opts='--init'
      - opts='--recursive'

clone libraqm from github:
  git.latest:
    - name: https://github.com/HOST-Oman/libraqm.git
    - target: /opt/libraqm
    - submodules:
      - True
      - opts='--init'
      - opts='--recursive'

run autogen libraqm:
  cmd.run:
    - name: ./autogen.sh 
    - cwd: /opt/libraqm/

run configure libraqm:
  cmd.run:
    - name: ./configure
    - cwd: /opt/libraqm/

run make libraqm:
  cmd.run:
    - name: make
    - cwd: /opt/libraqm/

run make insatll libraqm:
  cmd.run:
    - name: make install
    - cwd: /opt/libraqm/

check Build dir:
{% if not salt['file.directory_exists' ]('/opt/supertux/build') %}
  file.directory:
    - user:  root
    - name:  /opt/supertux/build/
    - group:  root
    - mode:  755
{% else %}
  cmd.run:
    - name: echo "Dir Buid exists"
{% endif %}

run cmake supertux:
  cmd.run:
    - name: cmake ..
    - cwd: /opt/supertux/build/

run make supertux:
  cmd.run:
    - name: make
    - cwd: /opt/supertux/build/

run make insatll supertux:
  cmd.run:
    - name: make install
    - cwd: /opt/supertux/build/

# run supertux:
#   cmd.run:
#     - name: ./supertux2
#     - cwd: /opt/supertux/build/
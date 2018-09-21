# colorful translations

Using ruby-processing to take midi notes as input and translate into
the corresponding color on the frequency scale.

Midi notes are capture via external microphone piped through GxTuner.

# setup

* for debian 9

* download oracle jdk and extract into /opt
/opt/jdk-10.0.2/bin/java


* link the java binary to /opt/new java
`sudo update-alternatives --install /usr/bin/java /opt/jdk-10.0.2/bin/java`

* ensure that alternatives is using desired version
`sudo update-alternatives --config java`
  * select number to jdk10

* create ~/.jruby_art/config.yml

* install jruby_art

  `rvm gemset use global
  gem install jruby_art
  k9 --install`

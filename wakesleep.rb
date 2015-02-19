# ##################################################################### #
#                                                                       #
#   wakesleep.rb                                                        #
#   Written by Wells Riley on Feb 19, 2015                              #
#   Envoy                                                               #
#                                                                       #
#   This script creates a local Sinatra app that listens for a POST to  #
#   either /turn-on or /turn-off. It then passes an AppleScript to the  #
#   osascript command in OS X. These AppleScripts tell various apps     #
#   to turn on, off, sleep, pause, etc. depending on the state.         #
#                                                                       #
# ##################################################################### #

require 'rubygems'
require 'sinatra'

def osascript(script)
  system 'osascript', *script.split(/\n/).map { |line| ['-e', line] }.flatten
end

post '/turn-on' do
  osascript <<-END
   tell application "System Events"
     stop current screen saver
     keystroke "p" using control down
   end tell

   tell application "PandoraJam" to activate

   tell application "pandora" to activate
  END
end

post '/turn-off' do
  osascript <<-END
   tell application "System Events"
     start current screen saver
     keystroke "p" using control down
   end tell

   tell application "PandoraJam" to quit

   tell application "pandora" to quit
  END
end
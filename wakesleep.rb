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
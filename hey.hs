module Main where

import Control.Monad.Trans.Class
import Control.Monad.Trans.Maybe
import Network.Rereddit.Happy

snapshot = Snapshot "https://web.archive.org/web/20050725010627/http://reddit.com/"

main = do
  woah <- runMaybeT (threadsOfSnapshot snapshot)
  print woah

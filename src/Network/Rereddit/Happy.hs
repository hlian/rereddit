module Network.Rereddit.Happy where

import           Network.Rereddit.FileCache

import           BasePrelude
import           Control.Lens
import           Control.Monad.IO.Class
import           Control.Monad.Trans.Class
import           Control.Monad.Trans.Maybe
import           Data.Text
import           Network.Wreq

import           Data.ByteString.Lazy (ByteString)
import           Data.Text.Lazy (toStrict)
import           Data.Text.Lazy.Encoding (decodeUtf8)

import qualified System.FilePath.Posix as Path

data Snapshot = Snapshot String
                deriving (Show)

data Thread = Thread Text
              deriving (Show)

bodyOfSnapshot :: Snapshot -> MaybeT IO ByteString
bodyOfSnapshot (Snapshot url) = do
  response <- liftIO (get url)
  MaybeT (return (response ^? responseBody))

threadsOfSnapshot :: Snapshot -> MaybeT IO Thread
threadsOfSnapshot snapshot@(Snapshot url) =
  (Thread . toStrict . decodeUtf8) <$> (cached bodyOfSnapshot "butts" snapshot)

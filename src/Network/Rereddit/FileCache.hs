module Network.Rereddit.FileCache where

import           BasePrelude
import           Control.Monad.IO.Class
import           System.Directory

import           Data.ByteString.Lazy (ByteString)

import qualified Data.Text as Text
import qualified Data.ByteString.Lazy as IOX

cached :: (MonadIO m) => (a -> m ByteString) -> FilePath -> a -> m ByteString
cached a2b subpath a =
  liftIO (doesFileExist filename) >>= \existence ->
  case existence of
    True -> do
      liftIO (IOX.readFile filename)
    False -> do
      b <- a2b a
      liftIO (IOX.writeFile filename b)
      return b
  where
    filename = "/Users/hao/.rereddit/" <> subpath

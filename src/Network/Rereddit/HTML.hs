module Network.Rereddit.HTML where

import           Control.Lens
import           Data.Text (Text)

import qualified Data.Text as Text
import qualified Network.Wreq as Wreq

data Snapshot = Snapshot Text

htmlOfSnapshot :: Snapshot -> MaybeT IO Text
htmlOfSnapshot =

module Grenade.Examples.MNIST.Parser
    ( imageFileParser
    , labelFileParser
    ) where

import Import

import Grenade (S)

import Grenade.Examples.MNIST.DataSet
import Grenade.Examples.MNIST.Parser.Internal
import Utils.Parser

imageFileParser :: Parser [S Image]
imageFileParser = do
    void word32Parser
    size <- fromIntegral <$> word32Parser
    nRows <- word32Parser
    when (nRows /= fromIntegral nOfRows) $
        fail "The number of rows isn't correct"
    nCols <- word32Parser
    when (nCols /= fromIntegral nOfCols) $
        fail "The number of rows isn't correct"
    replicateM size imageParser

labelFileParser :: Parser [S Label]
labelFileParser = do
    void word32Parser
    size <- fromIntegral <$> word32Parser
    replicateM size labelParser

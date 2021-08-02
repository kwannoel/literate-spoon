-- | Seeing compilation results of PlutusTx

{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE DataKinds                  #-}

module Main where

-- import qualified Language.PlutusTx as Compiled
-- import qualified Language.PlutusCore.Pretty as Pretty
import           Plutus.Contracts.Game               as Game
import qualified PlutusTx
import qualified PlutusCore.Pretty as Pretty
-- import PlutusCore

validateGuessCompiled = $$(PlutusTx.compile [|| Game.validateGuess ||])
-- plcWrappedValidateCompiled =
-- prettyWrappedValidator = Pretty.prettyBy CorePretty.defPrettyConfigPlcOptions wrappedGuessCompiled


wrapCompiled = $$(PlutusTx.compile [|| wrap ||])

wrappedGuessCompiled = PlutusTx.applyCode wrapCompiled validateGuessCompiled

plcWrappedValidator = PlutusTx.getPlc wrappedGuessCompiled
-- prettyWrappedValidator = CorePretty.prettyBy CorePretty.defPrettyConfigPlcOptions plcWrappedValidator
prettyWrappedValidator = Pretty.prettyPlcClassicDef plcWrappedValidator
plcText = show prettyWrappedValidator

main :: IO ()
main = putStrLn plcText

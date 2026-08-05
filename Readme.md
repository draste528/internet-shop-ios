# InternetShop
 
A SwiftUI iOS app for a minimalist furniture store. The app opens on a welcome screen and, after tapping **START SHOP**, presents a tab-based interface with four sections: Catalog, Favorites, Cart, and Settings.
 
## Overview
 
The project with MVVM setup with a reusable design layer. The two central reusable pieces are a configurable primary button and a generic single-selection menu that powers the bottom tab bar and is meant to be reused for any "row of icons where one can be selected" element from the Figma design (horizontal or vertical).
 
## Requirements
 
- iOS 18.6

## Architecture
 
The app follows **MVVM**, with files organized **by feature** rather than by type. Each screen keeps its `View`, `ViewModel`, and local components together, so working on one screen touches one folder instead of jumping between separate `Views/` and `ViewModels/` trees. Reusable UI lives in a dedicated design layer, and the model layer sits in `Core`.
 
MVVM here is about *roles*, not folders: a `View` never fetches or computes state directly — it asks its `ViewModel`. That separation holds regardless of how the files are grouped on disk.

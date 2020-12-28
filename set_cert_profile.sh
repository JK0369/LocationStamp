#!/bin/sh

bundle install
bundle exec fastlane sync_codesign_debug
bundle exec fastlane sync_codesign_alpha
bundle exec fastlane sync_codesign_release
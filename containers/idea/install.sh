#!/bin/sh
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.jetbrains.IntelliJ-IDEA-Community

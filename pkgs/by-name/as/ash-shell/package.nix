{
  lib,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  pname = "ash-shell";
  version = "unstable-2026-06-01";

  src = fetchFromGitHub {
    owner = "VAISHAKH-GK";
    repo = "ash";
    rev = "main";
    hash = "sha256-/S48NWXxkDqsIopF1+tGf3pmJFmFl9DFYpC0w5mvFzo=";
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    make PREFIX=$out
    cp ash $out/bin/
    runHook postInstall
  '';

  meta = {
    description = "A simple Unix-like shell written in C";
    homepage = "https://github.com/VAISHAKH-GK/ash";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.unix;
    mainProgram = "ash";
  };
}

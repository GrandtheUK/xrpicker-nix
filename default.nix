{ pkgs ? import <nixpkgs> { }}:
pkgs.rustPlatform.buildRustPackage rec {
  pname = "xrpicker";
  version = "2.2.1";

  nativeBuildInputs = with pkgs; [
    pkg-config
  ];
  buildInputs = with pkgs; [
    glib.dev
    atkmm
    gtk3
  ];

  srcs = pkgs.fetchFromGitHub {
    owner = "rpavlik";
    repo = "xr-picker";
    rev = version;
    hash = "sha256-XEj1DV0Tc+I4KuA4lNKqT6/QxyTj/Q0/qI4KpKm2WSI=";
  };
  useFetchCargoVendor = true;
  cargoHash = "sha256-C9ePoIHmIWlLl4wksinNaFj3Jrl+DgYGDGo3QQpWGNI=";

  meta = with pkgs.lib; {
    description = "A cross-platform tool to allow you to easily change your active OpenXR runtime";
    homepage = "https://github.com/rpavlik/xr-picker";
    license = licenses.mit;
    mainProgram = "xrpicker-gui";
  };
}
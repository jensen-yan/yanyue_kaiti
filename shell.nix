{pkgs ? import <nixpkgs> {}}:
let
  name = "ucasproposal";
  myTexlive = pkgs.texlive.combine {
    inherit (pkgs.texlive)
    scheme-basic

    xetex
    ctex
    checkcites

    # sty
    newtx
    xstring
    realscripts
    jknapltx
    mathalpha
    caption
    placeins
    enumitem
    listings
    algpseudocodex
    algorithms
    algorithmicx
    chemfig
    mhchem
    float
    # for pandoc converting markdown to latex
    fancyvrb
    pdfcrop

    # tex
    simplekv

    rsfs
    ;
  };
  myPython = pkgs.python3.withPackages (p: with p; [
    ipython
    matplotlib
    pandas
    numpy
    openpyxl
    scipy
    jinja2
  ]);
in
pkgs.mkShell {
  inherit name;
  packages = with pkgs; [
    myTexlive
    myPython
    librsvg
    pandoc
  ];
  shellHook = ''
    # env
    export PYTHONPATH=${myPython}/${myPython.sitePackages}
    export debian_chroot=${name}
  '';
}

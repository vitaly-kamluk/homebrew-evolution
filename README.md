# Evolution repository
This is a repository with important patches to some homebrew packages for macOS.

# rdesktop-mit
This is a rdesktop build linked with MIT Kerberos GSSAPI library instead of Heimdal Kerberos (default on macOS). MIT Kerberos alows to leverage pk-init linked to pkcs11 to get the KRBTGT. This way you can connect to NLA-protected RDP service using smartcard alone.

## How do I install these formulae?

`brew install vitaly-kamluk/evolution/<formula>`

Or `brew tap vitaly-kamluk/evolution` and then `brew install <formula>`.

Example: `brew tap vitaly-kamluk/evolution && brew install rdesktop-mit`

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).

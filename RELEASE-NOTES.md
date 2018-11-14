linux-installer version [18.12](https://github.com/open-eid/linux-installer/releases/tag/v18.12) release notes
--------------------------------------
- Include IDEMIA drivers

linux-installer version [18.06](https://github.com/open-eid/linux-installer/releases/tag/v18.06) release notes
--------------------------------------
- DigiDoc3 and ID-card utility (qdigidoc, qesteidutil) replaced with new dependency DigiDoc4 Client (qdigidoc4)

linux-installer version [17.12](https://github.com/open-eid/linux-installer/releases/tag/v17.12) release notes
--------------------------------------
- Add firefox-pkcs11-loader dependency

[Full Changelog](https://github.com/open-eid/linux-installer/compare/v17.11...v17.12)

linux-installer version [17.11](https://github.com/open-eid/linux-installer/releases/tag/v17.11) release notes
--------------------------------------
- Configure Chrome PKCS11 on Ubuntu 17.10

[Full Changelog](https://github.com/open-eid/linux-installer/compare/v17.10...v17.11)

linux-installer version [17.10](https://github.com/open-eid/linux-installer/releases/tag/v17.10) release notes
--------------------------------------
- NPAPI plugin is deprecated
- Update esteid-update-nssdb script

[Full Changelog](https://github.com/open-eid/linux-installer/compare/v17.06...v17.10)

linux-installer version [17.06](https://github.com/open-eid/linux-installer/releases/tag/v17.06) release notes
--------------------------------------
- Added qdigidoc-tera dependency

[Full Changelog](https://github.com/open-eid/linux-installer/compare/v3.12.0...v17.06)

Packaging version 3.12 release notes
--------------------------------------
Changes compared to ver 3.10

- Changed branding


Packaging version 3.10 release notes
--------------------------------------
Changes compared to ver 3.9.1

- Fixed packaging of Latvian and Lithuanian CA certificates , the certificates are no longer included in the Estonian DigiDoc3 Client's distribution for Linux platform.


Packaging version 3.9.1 release notes
--------------------------------------
Changes compared to ver 3.9

Known issues: 
- Latvian and Lithuanian CA certificates are included in the Estonian DigiDoc3 Client's packaging for Linux platform.


Packaging version 3.9 release notes
--------------------------------------
Changes compared to ver 3.8.2

- Improved ID-card usage in Google Chrome/Chromium, added automatic configuration script. Acknowledgements. Sertifitseerimiskeskus and RIA thank Lauri Võsandi for his contribution.
- Improved packaging in Ubuntu environment. Acknowledgements. Sertifitseerimiskeskus and RIA thank Siim Põder for his contribution. 
- Added packaging support for chrome-token-signing browser extension in Chrome and Chromium browsers in Linux environment.
- Improved packaging in Ubuntu environment, tarball package now contains a build number.
- Added new Finnish certificates "VRK CA for Qualified Certificates - G2" or "VRK Gov. CA for Citizen Qualified Certificates - G2" to Finnish certificates' installation packages. 
- Added Finnish, Latvian, Lithuanian test certificates to test certificates' installation packages. 


Packaging version 3.8.0 release notes
--------------------------------------

- Improved tarball packaging for Linux distributions, separate tarballs are now created automatically for each ID card software component.
- Changed the process of distributing SK root certificates in case of Linux environment. The certificates are now distributed via Firefox CA certificates package.
- Fixed Ubuntu Debian packaging errors that were discovered by using Lintian tool.
- Added support for Ubuntu 13.10. 

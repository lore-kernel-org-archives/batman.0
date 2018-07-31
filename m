Return-Path: <mailing.m1@kkk-web.de>
From: MK <mailing.m1@kkk-web.de>
Message-ID: <bb8d1046-af37-dab3-12ce-46455acedbbf@kkk-web.de>
Date: Tue, 31 Jul 2018 21:24:54 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="XSIbY9hymujnYv9Zs4kgNqkwHeV4a3yiN"
Subject: [B.A.T.M.A.N.] BATMAN 2018.1 fails to compile
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XSIbY9hymujnYv9Zs4kgNqkwHeV4a3yiN
Content-Type: multipart/mixed; boundary="zwJ6CD8TD8wPnPn37vp7YqtSSdwHRHco5";
 protected-headers="v1"
From: MK <mailing.m1@kkk-web.de>
To: b.a.t.m.a.n@lists.open-mesh.org
Message-ID: <bb8d1046-af37-dab3-12ce-46455acedbbf@kkk-web.de>
Subject: BATMAN 2018.1 fails to compile

--zwJ6CD8TD8wPnPn37vp7YqtSSdwHRHco5
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Hi!

Since 2018.1 release the batman module fails to compile on my machine:

:~/Server-config/batman-adv-2018.1# make
/root/server-config/batman-adv-2018.1/gen-compat-autoconf.sh
/root/server-config/batman-adv-2018.1/compat-autoconf.h
mkdir -p /root/server-config/batman-adv-2018.1/build/net/batman-adv/
compat-patches/replacements.sh
touch
/root/server-config/batman-adv-2018.1/build/net/batman-adv/.compat-prepar=
ed
make -C /lib/modules/4.9.0-7-amd64/build
M=3D/root/server-config/batman-adv-2018.1/build
PWD=3D/root/server-config/batman-adv-2018.1/build REVISION=3D
CONFIG_BATMAN_ADV=3Dm CONFIG_BATMAN_ADV_DEBUG=3Dn
CONFIG_BATMAN_ADV_DEBUGFS=3Dy CONFIG_BATMAN_ADV_BLA=3Dy
CONFIG_BATMAN_ADV_DAT=3Dy CONFIG_BATMAN_ADV_NC=3Dn CONFIG_BATMAN_ADV_MCAS=
T=3Dy
CONFIG_BATMAN_ADV_BATMAN_V=3Dn INSTALL_MOD_DIR=3Dupdates/ modules
make[1]: Verzeichnis =E2=80=9E/lib/modules/4.9.0-7-amd64/build=E2=80=9C w=
ird betreten
make[1]: *** Keine Regel, um =E2=80=9Emodules=E2=80=9C zu erstellen.  Sch=
luss.
make[1]: Verzeichnis =E2=80=9E/lib/modules/4.9.0-7-amd64/build=E2=80=9C w=
ird verlassen
Makefile:90: die Regel f=C3=BCr Ziel =E2=80=9Eall=E2=80=9C scheiterte
make: *** [all] Fehler 2

This is a debian stretch installation. Someone out there with the same
problem? Make clean did not help.

A bit lost :)
Martin





--zwJ6CD8TD8wPnPn37vp7YqtSSdwHRHco5--

--XSIbY9hymujnYv9Zs4kgNqkwHeV4a3yiN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE9IPOuVyPsFfx2iJ9cNiJ0EN5ao8FAltgt4cACgkQcNiJ0EN5
ao9HOA/7BgZAhZs9Av5obZNsuGiSM+RsC9AuQ8kJ50J+EcOiXA/bH0oUP9N+ZayU
h7PJpchzrnCQyoTAMipH5jocdgl9hH79lS/PlNeEkXJvv9Y3yG9+oqUwo2grSUM9
Uyu8y7uplWslGq/MtWyV0hFCFHCPcQng4hBSDgctYO0O8ANWvCMfgHWOR+2O4WxC
J7tu5sTvDF/6azfhh9k+LBqf+ZfN5k4e1lTpL+0S6PcGW5EloYpo8k3UfQ8rktlt
LRYU4H27kt6SOVE0u9W45coDMdi8q4y8+jNiY9KPQkI5YvYKy3oaqJ2eGZintoku
+d6lrLTOIZDtezp9Z6Zo4nVJaSfIAW4y1DI25urWaVsfsKR/Ym9B6wscBR1UrpE2
HS4SVzBFoPAY9wspFX/iojA6FOH17sOO4nfOA1pXGh6h7KAbAeoPUAPlMgVoxWj6
o2LeGA6OIqqGOoM9U9YyM6XG/ybic2YN2O2YQtIbe3CLFFyrXFaeIcOa0TQM5X9J
oCKueMj9o+J+LOl4l1rQIFFkix9Azi8aWAKjsXgxJyonbnhrRStea02i2gCn10gq
SSd1p8mnXubKwsv4T9EpikAFoU/JlKEILoohw4HgORJbUFXD4BopnRm9qOUh1szx
I0M3vu4QzDADg7aVZJ7cdiAp0BHDtoeDPdG04dOjXPUDJKvbkcA=
=V+sI
-----END PGP SIGNATURE-----

--XSIbY9hymujnYv9Zs4kgNqkwHeV4a3yiN--

Return-Path: <antonio@meshcoding.com>
Message-ID: <52FB2186.2060701@meshcoding.com>
Date: Wed, 12 Feb 2014 08:23:50 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1390299725-1873-1-git-send-email-antonio@meshcoding.com>	<86mwipch0u.fsf@coulee.tdb.com>
 <86lhy8pn5v.fsf@coulee.tdb.com>	<52DF7556.9090200@makrotopia.org>
 <86y527oqpl.fsf_-_@coulee.tdb.com>	<52E003DD.6040302@meshcoding.com>
 <52E02EDC.3080805@wirelesspt.net>	<86iotbo9hw.fsf@coulee.tdb.com>
 <52E05E0F.7010203@wirelesspt.net>	<52E08DFE.9030604@makrotopia.org>
 <52E5063E.3080408@makrotopia.org>	<52E51A04.8020800@meshcoding.com>
 <52E5322D.60202@wirelesspt.net>	<52E532D0.2000907@meshcoding.com>
 <52E5341F.30800@meshcoding.com>	<52E69D7D.80905@wirelesspt.net>
 <861tzsgaub.fsf@coulee.tdb.com>	<52E70836.3050502@wirelesspt.net>
 <867g9jciol.fsf@coulee.tdb.com> <52E97715.3060306@wirelesspt.net>
 <52F59F90.7000204@wirelesspt.net>
In-Reply-To: <52F59F90.7000204@wirelesspt.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6wbHdWOiGsIvI1lGkrsrnfrt4Xt3dDLjr"
Subject: Re: [B.A.T.M.A.N.] batman-adv: memory leak?
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, cmsv@wirelesspt.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6wbHdWOiGsIvI1lGkrsrnfrt4Xt3dDLjr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/02/14 04:08, cmsv wrote:
> [  239.420000] [<8020ff04>] 0x8020ff04
> [  239.420000] [<801d8154>] 0x801d8154
> [  239.420000] [<80211184>] 0x80211184
> [  239.420000] [<800d8890>] 0x800d8890
> [  239.420000] [<800ec6f0>] 0x800ec6f0
> [  239.420000] [<801d9f58>] 0x801d9f58
> [  239.420000] [<801d93dc>] 0x801d93dc
> [  239.420000] [<800d9114>] 0x800d9114
> [  239.420000] [<800d93dc>] 0x800d93dc
> [  239.420000] [<801d9a70>] 0x801d9a70
> [  239.420000] [<8006a284>] 0x8006a284
> [  239.420000]
> [  239.420000]
> [  239.420000] Code: 0c3a9ac3  00402821  0040a821 <8c42000c> 54400052
> 00008021  8e050054  10a00005  8fb10010
> [  239.730000] ---[ end trace 7d873dc004108502 ]---
> [  239.740000] Kernel panic - not syncing: Fatal exception in interrupt=

> [  239.740000] Rebooting in 3 seconds..
>=20


Hi!

Have you been able to run a test with kernel symbols enabled??
That would be a great help ;)

Cheers,

--=20
Antonio Quartulli


--6wbHdWOiGsIvI1lGkrsrnfrt4Xt3dDLjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS+yGKAAoJEEKTMo6mOh1V6fsP/Rxdb8Nhw7R2YnK1nXJ49iyj
B1cmy+rASJVMFTK4uy7CFTnPeF279DuHCuvWwnWH0neyLUyD2j/vsZ3ocjVANOU8
8jzEqiYSsj3KABUupzewPNcMsfTGA8ur2SPCrwf2FbjEPMmw0xkhqV7lZpKejTp8
+IoShc2OVWJ2xI6+BqJ5bJ8QfzPbKVZaV0tyH5uiS/APRr94HY++0kzja0cIe3e4
gHp9wyW114wXF8YMV5i4aNWsh1yXXWvT2xPGkHNN1HfiZmxVTo5DK1S+E5q/XX6P
euGHGEljmNkef1efxCI3B8jlaQM0brExSUfvnRCGTGpwA7hbKWAMhE4PaPjdAJwb
d62FN1Lf2rDFvs3YHEvpLBIcwIPtAoMkFa99eD8ZCRKRxWuWAfQ49JRdeZAE1A6W
ItJ3FFkzz9y/EJYaux79uplU/LBnrhmxu3xbvRdIkJ0jxwr9YtzEfGNkKHL4gSb+
SPT/0ko+HFg3tyO7mFEKRB8Kn0v1PZSuB8WROdaPRtJmKBWToxkQ6pazhtna6iVA
VidfqbQU0sjSLysYHKBVTErlCJEYZYPI5CWhWHogETSsEeymrVkBvZ4kfxrlacf6
LhGIzjixOHFh+PZqtxYCHfCTSCC4BJfExkqJHsvffU3iGwbeg0uYbcgimEGMYJzP
9q95cxq92fi/1lMBti53
=tg6x
-----END PGP SIGNATURE-----

--6wbHdWOiGsIvI1lGkrsrnfrt4Xt3dDLjr--

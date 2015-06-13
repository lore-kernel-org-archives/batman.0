Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 13 Jun 2015 21:30:30 +0200
Message-ID: <1775906.OVcfLHEFNd@sven-edge>
In-Reply-To: <165699CE-BD67-45D4-AAC1-64663C9B466B@gmail.com>
References: <CALaFpeVMwOE5DtHoDWVA+CBXq2jMuKLdmU-CcOWhCNRkHQ9F5w@mail.gmail.com>
 <7101665.y6bS5x8EtZ@sven-edge>
 <165699CE-BD67-45D4-AAC1-64663C9B466B@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1744180.CtEXD6DAzf";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] batman-adv: Force line topology
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
To: Carlos Meralto <carlosmeralto@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart1744180.CtEXD6DAzf
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Saturday 13 June 2015 19:17:57 Carlos Meralto wrote:
> Thanks for the answer Sven.
>=20
> > You can patch the driver to allow this (it is just a simple check w=
hich
> > disallows it in most drivers... or actually in wireless core [1]). =
But you
> > should make sure that you still use the same mac addresses for vif =
+
> > bridge
> > and don't end up with 4 address packets.
>=20
> Can you explain how I can apply this "patch=E2=80=9D? I saw the file =
attached but i
> don't know what parameters must change.

You have to modify this file or similar ones yourself to avoid that it =
sets=20
IFF_DONT_BRIDGE. And then you have to recompile your kernel with your p=
atch=20
and run it - but you should be aware that this is only a hack. It was a=
lready=20
discussed on this mailing list how the wifi stack avoids that the bridg=
e=20
accepts specific types of interfaces [1].

You should also find in this thread a patch [2] which shows how some eb=
tables=20
functionality could in theory also be added to something like batman-ad=
v. You=20
should be aware that this is not in the upstream version because it is=20=

considered not acceptable by the Linux networking subsystem maintainer.=


You should also be aware that it is problematic to test to different pr=
otocols=20
by using two different, protocol/implementation specific ways to force =
them to=20
a specific topologies.

Kind regards,
=09Sven

[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2010-May/002718.h=
tml
[2] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2010-May/002731.h=
tml

--nextPart1744180.CtEXD6DAzf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVfITZAAoJEF2HCgfBJntG7z0P/iT6Iq9Vantq1BNPQW2IwN+V
e3FEUi7WT/2f/s8IRWSCtlnZx7mmGWNv7SqzkE3DS2FWgUJ0+cLoY45Opqws7XNi
C18pDlBd2RUKhBSs1bsPScXDPOsel91xv66q059CQLtGY6yWPHDOrQM1UftYgzK1
iwrylwmAjXW7RsuVUFP1uUUBe2Pg0iuOMy1pa3m+KgmXjdbAN7c+/Z2LJmmJ2kkf
vJMrsxcZUrOgKgIGXYOylcvQUQwBV7Erx8nNpM4FylSQMVy0ZSDf+tt0zTM7a5rM
K8SXTBU4qS4zEMQ50Npyv8v39UeHqeYl6FMRP+oA8xPGGpEquojNQAT7fJnq+Gx8
v/xRMj7acwsi9eRhn3HanN5AhXFjW4lIhZXQE+O+gIUEDZnQAAy57uItsci6ntDL
fDhqTi5tAZkhI9KOPUweS4iq0jtCXrHiAJ0YQJsCCH/hOYcS40zVwhiy/DPrsltM
xg+677rhhy4WUYgi65k42czNnZ+vBndbP3TjViy3iOPHd/XvYYWDq8+uYKm8uPqi
bFiHDWI0RGa+zKPe0FaKysC+68M5CLSJl2usj0zzpcafWYrKBEQuypTfZNHdf5Ha
PmJ4FdtwlI9UGFpRqRVSdCUVTyqRSbXIXPoCedVlm7tRGMbNQomsTDqRjgj1taaZ
PQbmA3vtFmlowPGSWJOT
=hViQ
-----END PGP SIGNATURE-----

--nextPart1744180.CtEXD6DAzf--


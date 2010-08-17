Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 17 Aug 2010 11:51:18 +0200
References: <4C6A5477.7030900@web.de>
	<201008171127.09099.sven.eckelmann@gmx.de>
	<4C6A5A44.6060108@web.de>
In-Reply-To: <4C6A5A44.6060108@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1379389.BgMGnEUd6z";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201008171151.19398.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Problem openWRT "backfire" and "kmod-batman-adv"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Tim <Timbo2001@web.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1379389.BgMGnEUd6z
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Tuesday 17 August 2010 11:45:40 Tim wrote:
> On 17.08.2010 11:27, Sven Eckelmann wrote:
> > On Tuesday 17 August 2010 11:20:55 Tim wrote:
> >> So the patch seems to change the situation somehow, but the device kee=
ps
> >> freezing!
> >=20
> > Which patch? There are two patches... and one patch in two different
> > versions.
> >=20
> > Best regards,
> >=20
> > 	Sven
>=20
> I just noticed the patch Marek sent, so i used the patch Marek attatched.

Please test the other two which Marek also sent to you in response of his m=
ail=20
with the first patch:

01-notify.patch
02-dev_hold.patch

Just add both at the same time and test again. Testing only one of both=20
doesn't make sense now after your initial test of the old version of
01-notify.patch.

thanks,
	Sven

--nextPart1379389.BgMGnEUd6z
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMaluWAAoJEF2HCgfBJntGfVYP/10qrPJXtMJDFI/VkukRgl95
y7wGkAUMKYJeHYXVsE8qsOCKAmj+PgKrB/R7nfnaXGu71DANBWzbhmliEUutLdbF
C1o23u1BxZGGan6FtoiOJRmjTa1t2UsOZW1tiYnPUUbLzqDZI5Il1KVcYLcS52WV
pjQRiODxgWfMEPzt2MeSC2iFlYtxCXpmJFcflhgPaXUoBd8tsfHehZUCumgYbWDG
n9F4t7XIHtUqQq2eWFG9B6Am+uLuYIqTt9mRsiDTPoXp0cH4pfsfLzWfChff8s/x
XCniGDHr0uyJqXsRcVdJFmc/ZU9uGE62V1bDYrCQ/7dgmZEpXVh6BktI2uBc/oi3
sieReGedR3GoqMaWwEDkg9vE7Ac+rGP9+JI9wyO8A1fTdw8o11L6NsHvqfdPiQsM
1M4xk+2hd10D1FkDFbDvy8VoQuXHuExfE7MCPDJXcpfKfB+kqnUUYahnEAh8JQHC
76DjWHO4MhuRMo0s5ZNynD+vQm+uaMr00e5Z+Leey3nak/GsNaZCVMoZKIVkwgh5
PpW4L0y0fRWEoFcboXHYjAMRjCduF38s+jByB4RyRmAwp5SV/LG3LTUYoxG5Vzdp
M7WQwqiAJ4h3bo2j+WMBGd5puMj/fL1dfTBAL26cmNd2HF2uc+40EjVoafbv/Kjn
7dY6/8l+68nqTiUkX3BP
=N+bH
-----END PGP SIGNATURE-----

--nextPart1379389.BgMGnEUd6z--

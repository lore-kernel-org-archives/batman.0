Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 20 Sep 2016 17:36:58 +0200
Message-ID: <22687137.t3Ci01JQqR@bentobox>
In-Reply-To: <20160920142902.GB7375@otheros>
References: <35819279.yt4EnXKmx6@bentobox>
 <1468423822-28324-5-git-send-email-sven@narfation.org>
 <20160920142902.GB7375@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3134609.xmo2B6o7Lc";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/7] batctl: Allow to disable automatic
	interface new/destroy
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

--nextPart3134609.xmo2B6o7Lc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 20. September 2016 16:29:02 CEST Linus L=FCssing wrote:
[...]
> > This can be done by avoiding automatic creation of an interface when the
> > command "add" is used together with the option "-M". The add would fail
> > when the soft-interface disappeared for some reason and thus the
> > soft-interface would not be created again with the default configuratio=
n.
> > But more importantly, the "del" command can be informed with the option
> > "-M" to not try to remove the soft-interface in the first place.
>=20
> Currently wondering... have you thought about maybe
> memorizing when a batman-adv interface was created via the new
> "new" command? And in that case then transparently avoiding the automatic
> destruction.
>=20
> Would be one less parameter to memorize for the user then.

batctl would have to remember this to work and batctl is no program which i=
s=20
running all the time. So it has to use temporary files... no.

One point here is to get rid of the batman-adv only files for creation/
destruction of itnerfaces and use the standard rtnl netlink. So I don't wan=
t=20
to create a new interface which does this in the kernel which supports your=
=20
idea.

Kind regards,
	Sven

--nextPart3134609.xmo2B6o7Lc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJX4VeaAAoJEF2HCgfBJntG5qoP/0H5hQns/Krh4q8vn1NrKJWb
PRaW0v/vb9cMdPFwzTNsxJCJDh8TtXIjXAb4918/Jkq2jtR3gh5t9nH6FxcLREdg
ijK1Xn3cIf87zJXzE1S36QwaZnPySkjv0U+iXP7vJVVKPsbKgWqOF5Vv0vUvjyMv
jobgwODfiPn7rIam2TsQMLr7q/AxEYgb+Ve85fWJsgTrcC39Hpcg/rpyVvnh2z16
LwrQsoMIVXmo7C2Ylkb9aO5IIpgGs2kxRI7ivhr+jPjV6XhpkqmUvW7RF3oFtCGS
rkAK5zYY5R7JZlsITa+gLi+vd1qLSlL9Qe4KoetzBRYAhk018Gw5MPKO4pcAWzOe
TtAxqSwx2nMpKY9Q1cQq4Z/CqMgGao/FFGNTEf9rdjQg6lbg/NqV7PPLAn1Vzd4s
C7BgpPlAlZbV0X04FpjguVSCh7Ua7zgyQmKFV+z2q+gc3PUWLy6LaqPXrMVMFuLv
zLHNpe1WRS72VYXSwbCLyFfKDJtSbeGK2LSQUGgsgZxyALUiXZAGHrfTKiFT+6gL
A+bb9l6X8ZBZyBTnWKEttztUdNXULT5MRfQ+CwItP++J6y2qJpIl6Yo7dUt6Bw3L
+FVLZkZdpjg8d4NmL224DGrV7hTRhnosnouqxWkzgiYbC4imbeMfhmx0VRpG03d3
Syf0ujQsUmIP4O0Gb7lz
=d3NI
-----END PGP SIGNATURE-----

--nextPart3134609.xmo2B6o7Lc--


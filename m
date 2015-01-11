Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 11 Jan 2015 18:29:33 +0800
Message-ID: <2264416.eIYjFu77aT@diderot>
In-Reply-To: <547C53C5.7090205@hundeboll.net>
References: <1417426648-9319-1-git-send-email-sven@narfation.org>
 <1417426648-9319-2-git-send-email-sven@narfation.org>
 <547C53C5.7090205@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1786862.Mh1ydEHUdG";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 2/2] batman-adv: Use only queued
	fragments when merging
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Martin =?ISO-8859-1?Q?Hundeb=F8ll?= <martin@hundeboll.net>, Sven Eckelmann <sven@narfation.org>


--nextPart1786862.Mh1ydEHUdG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday 01 December 2014 12:40:53 Martin Hundeb=F8ll wrote:
> On 2014-12-01 10:37, Sven Eckelmann wrote:
> > The fragment queueing code now validates the total_size of each fra=
gment,
> > checks when enough fragments are queued to allow to merge them into=
 a
> > single packet and if the fragments have the correct size. Therefore=
, it
> > is not required to have any other parameter for the merging functio=
n than
> > a list of queued fragments.
> >=20
> > This change should avoid problems like in the past when the differe=
nt skb
> > from the list and the function parameter were mixed incorrectly.
> >=20
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
>=20
> Acked-by: Martin Hundeb=F8ll <martin@hundeboll.net>

Applied in revision 939717c.

Thanks,
Marek

--nextPart1786862.Mh1ydEHUdG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUslCNAAoJEFNVTo/uthzAIDUH/1Gj5DvRE8TjLeGsAPH1LQrY
70L+jJttGAjjlfnTi68mtCzjsavOByzHbLJYebCM7/1a7KRpQG0tVo6sDUYne/K7
3OaNw9Vc7P7xzCeL21FX0sxbt5pWDRtRerB1dtZpnHiwhOFfBrkL4Scv9ecFtlll
ZMk8FRFuJoTGMKtpbefnRAerrygmGZHEfHZNKrBQQFXxTB8um+Sw+E2LP8m44mX4
12u3yZCEvhbcEVime6yIt8hAGQX7+crf4hBaR5WoKq0kAHWd0Xr/xrPILptp6uqo
J9Md3ZeqRcHDyRRxu+v2a43XsRJ4q1Z7tVybgcnb3WJw4KT/fVkWuzcHgJIOywk=
=ua+9
-----END PGP SIGNATURE-----

--nextPart1786862.Mh1ydEHUdG--


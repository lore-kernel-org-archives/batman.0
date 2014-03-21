Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 21 Mar 2014 16:40 +0800
Message-ID: <1522518.ri0JWGFlKW@diderot>
In-Reply-To: <1395251855-30765-7-git-send-email-antonio@meshcoding.com>
References: <1395251747-27289-1-git-send-email-antonio@meshcoding.com>
 <1395251855-30765-1-git-send-email-antonio@meshcoding.com>
 <1395251855-30765-7-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4518503.xxrTRBiIif";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 next 11/11] batman-adv: fix more code
	style
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
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart4518503.xxrTRBiIif
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday 19 March 2014 18:57:35 Antonio Quartulli wrote:
> - use common iteration style pattern when looking up an
>   object
>=20
> Introduced by f2ed1502191a37abb39e3e2c80cca07f0f3bb411
> ("batman-adv: Send multicast packets to nodes with a WANT_ALL flag")
>=20
> Cc: Linux L=FCssing <linus.luessing@web.de>
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  multicast.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)

Applied in revision b08dc3d.

Thanks,
Marek

--nextPart4518503.xxrTRBiIif
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTK/rgAAoJEFNVTo/uthzA8RYH/2sJ2Y44AhQgPnnJh5ZiXQWY
850eZygVjRlCx3c8hmJGZU9WdZqhik/uvxhXPzVku1VImADlr25VDX/Cw/2Po24P
BUcKQvqKHxsgGqkx0Hzv2iG3cck0D7KkQMXESngqDOYJXbBaO8sFZXMeiJ1nPDxH
bdFkPiBEzU8vCPonECYI4v1HsUBy5xveY4hNtc0fcnbkxejsIoyhZNCXXpS7NTR+
76hGSypcyn0I3r3Tth8ubCaPebi0SZyBOahD19isPJP1WyaveHCDLkRhrllpC1rd
TFCXSG4DQpoHIsTcSIXnVEktSQ8wYs3FEdHtXXNFDcIjl5F9t3QCiaU62+EEKe8=
=dc3W
-----END PGP SIGNATURE-----

--nextPart4518503.xxrTRBiIif--


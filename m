Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 18 Jun 2015 13:15:01 +0800
Message-ID: <65210387.gN7zAV2gST@voltaire>
In-Reply-To: <1434602839-4468-1-git-send-email-linus.luessing@c0d3.blue>
References: <1434602839-4468-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart20206789.HSR5cCupO9";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Fix compile error on
	deactivated MCAST feature
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


--nextPart20206789.HSR5cCupO9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thursday, June 18, 2015 06:47:19 Linus L=FCssing wrote:
> Some members of "struct batadv_orig_node" are not available if compil=
ing
> without the multicast optimizations feature.
>=20
> Fix this by moving their initialization into the right #ifdef's.
>=20
> Fixes: 7f220ed1f063 ("batman-adv: Fix potential synchronization issue=
s in
> mcast tvlv handler") Signed-off-by: Linus L=FCssing
> <linus.luessing@c0d3.blue>
> ---
>  originator.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Applied in revision 256776e.

Thanks,
Marek

--nextPart20206789.HSR5cCupO9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVglPZAAoJEFNVTo/uthzAQfQIAJdHOOAEXVHfOj22DUcOV6OJ
1LaJO3zrH4TktGYlP9AeG2enldJKymnnMIJKXVdiSkQnFWlQpJIn7pX78tArFWJw
IauYojuEvHnuvIR4wWFi4m7p74UKc4WEojMbjiisTCuVo7nEC+NvHCla/Ym+ngKz
4MunqRTJNTIA1TlQAsBA6DbzogrcOuGvJjQtg4I2Lun+bCp3XegLh/GPLiLyJUQL
Hu/B2Emjv5JUk4hUk4uEIwubnsl0S5LQTdmFeZsax0HnoPEK/NYh2xHaXBT7P2lG
u16L7fUdf2jNmV8rkbDIKM61zse68IyG6CwAZUmr7Y6tUWER4iNrzEAtNnkZVNw=
=RfyT
-----END PGP SIGNATURE-----

--nextPart20206789.HSR5cCupO9--


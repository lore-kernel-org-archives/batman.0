Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 13 Jul 2015 11:16:30 +0800
Message-ID: <1602341.t1WsWSYKaB@voltaire>
In-Reply-To: <1435700726-6607-1-git-send-email-linus.luessing@c0d3.blue>
References: <1435700726-6607-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2715776.X2JOZmzf9o";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Fix potentially broken
	skb network header access
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


--nextPart2715776.X2JOZmzf9o
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday, June 30, 2015 23:45:26 Linus L=FCssing wrote:
> The two commits noted below added calls to ip_hdr() and ipv6_hdr(). T=
hey
> need a correctly set skb network header.
>=20
> Unfortunately we cannot rely on the device drivers to set it for us.
> Therefore setting it in the beginning of the according ndo_start_xmit=

> handler.
>=20
> Fixes: 405cc1e5 ("batman-adv: Modified forwarding behaviour for multi=
cast
> packets") Fixes: 1c090349 ("batman-adv: Add IPv4
> link-local/IPv6-ll-all-nodes multicast support") Signed-off-by: Linus=

> L=FCssing <linus.luessing@c0d3.blue>

Applied in revision 02008ee.

Thanks,
Marek

--nextPart2715776.X2JOZmzf9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVoy2SAAoJEFNVTo/uthzAjbkH/21rIPLq5DPT8T56yEtIebXi
nMoN6qrrOihC4HholR3i/SSXIs8UYDwJjrwlHD9+8bdsJIO8JcOxLaCa15j430Hw
ECwtXdS/eA7/EN35LEsMUzdaKRZJ+q9iEe7bhko1mkVH8LifV8MceEvrGQ/rcGdV
afdADM/pfj2sCycBik4BEJl5Ph/lhLNGEpvjlpLDf7OItz4Z7gNPBcX1bGw7FQPu
IONfeg0k5a26iKkz+HWgD3WW7z/3bcjUfcMihV7JvY1wZWU7JyFzmWrUDDVyWgwz
IB35Xd8XwSSsHJGvqeabhw//AEtvNd8vvFJ4psm7Bc+Eq3DmMva8QsNM/P2XGb4=
=t5iv
-----END PGP SIGNATURE-----

--nextPart2715776.X2JOZmzf9o--


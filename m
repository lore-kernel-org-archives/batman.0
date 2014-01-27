Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 27 Jan 2014 15:39:39 +0800
Message-ID: <1460416.LgI2gHyY43@diderot>
In-Reply-To: <1390166566-8315-3-git-send-email-linus.luessing@web.de>
References: <1390166566-8315-1-git-send-email-linus.luessing@web.de>
 <1390166566-8315-3-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2070653.hoIcofEiU9";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv6 2/2] batman-adv: remove obsolete
	skb_reset_mac_header() in batadv_bla_tx()
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


--nextPart2070653.hoIcofEiU9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday 19 January 2014 22:22:46 Linus L=FCssing wrote:
> Our .ndo_start_xmit handler (batadv_interface_tx()) can rely on havin=
g
> the skb mac header pointer set correctly since the following commit
> present in kernels >=3D 3.9:
>=20
> "net: reset mac header in dev_start_xmit()" (6d1ccff627)
>=20
> Therefore this commit removes the according, now redundant,
> skb_reset_mac_header() call in batadv_bla_tx().
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
> ---
>  bridge_loop_avoidance.c |    3 ---
>  1 file changed, 3 deletions(-)

Applied in revision a093442.

Thanks,
Marek

--nextPart2070653.hoIcofEiU9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJS5g08AAoJEFNVTo/uthzALkYH/2PVLRhVP0mQuBXrDTvctpnR
EGz0hyIjPXAk1UDxbGTy3tMGtza0jKkAHkmh0T6Ye39Dfb+XDw0tZHIp6kZrJQcp
aFDIUK4YiYdHQ2NzdChT80/VQqQufUQwcFbwCSVKvlrM9q+KCR55sy/T8Mp2P+y+
0B49Qpt9vvGDCNu1QBn5Louzmez4aZl+GbTouBraLDeLhZl9frYU24aJotSl5fWw
4hM4C62bgL8Z059skOaU+G+ezzTCNXZd6TODI+ZtVeZ/1N6C0ETN9eNnfxa9AlB8
T1h/Sd/gD3S0Ms7fzkD8SxScW9xInSZi6s0mSIByxdM2bq/baakxje4+bs60bcA=
=r2SU
-----END PGP SIGNATURE-----

--nextPart2070653.hoIcofEiU9--


Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 30 Dec 2015 19:36:26 +0800
Message-ID: <6284608.dq66nB2XcN@voltaire>
In-Reply-To: <1448758137-21202-1-git-send-email-sven@narfation.org>
References: <1448758137-21202-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2645018.oX0u1uy8Kl";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix invalid read while
	copying bat_iv.bcast_own
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

--nextPart2645018.oX0u1uy8Kl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, November 29, 2015 01:48:57 Sven Eckelmann wrote:
> batadv_iv_ogm_orig_del_if removes a part of the bcast_own which previously
> belonged to the now removed interface. This is done by copying all data
> which comes before the removed interface and then appending all the data
> which comes after the removed interface.
> 
> The address calculation for the position of the data which comes after the
> removed interface assumed that the bat_iv.bcast_own is a pointer to a
> single byte datatype. But it is a pointer to unsigned long and thus the
> calculated position was wrong off factor sizeof(unsigned long).
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/bat_iv_ogm.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied in revision 24b1aae.

Thanks,
Marek

--nextPart2645018.oX0u1uy8Kl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWg8G6AAoJEFNVTo/uthzA+cIH/3aP1cnIKW1CcR1a/v4xf3hJ
NGpmLLP97ZmrHo+Uz+fOZR/49zuaNYhpdEODYAwHjR59cBoHv9NDNEVSAgylhGef
QD/FtTt3EF+Idah2hLBxVHWM9fdatv6MKhWHPWXGi84CNxxgVnc3ynHpWwdo7ehE
YFBSwdmcNjWI+2pfyTw0rV04DYjsR5wT+sL18eil3SfKnSPGioo3hpJUGH4d2d0+
vo26pnzGqJU6qgIl0kkZnQatdVPmqZkbDUTRg8dTkZO+VCQCODb+vYJxzcynXsfG
GEc+arIjmfKWh2OMi6q910xEgf9V8TWIJ5LV/U2rinSMwnHAEz5gOi223ujiZPU=
=8O/Y
-----END PGP SIGNATURE-----

--nextPart2645018.oX0u1uy8Kl--


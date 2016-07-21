Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 22 Jul 2016 00:01:48 +0200
Message-ID: <54416253.5e3YsyuenG@sven-edge>
In-Reply-To: <1469137112-24094-1-git-send-email-linus.luessing@c0d3.blue>
References: <1469137112-24094-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3713661.lmOlaNnlZH";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Remove unnecessary
	lockdep in batadv_mcast_mla_list_free
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

--nextPart3713661.lmOlaNnlZH
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Donnerstag, 21. Juli 2016 23:38:31 CEST Linus L=FCssing wrote:
> batadv_mcast_mla_list_free() just frees some leftovers of a local feast
> in batadv_mcast_mla_update(). No lockdep needed as it has nothing to do
> with bat_priv->mcast.mla_list.
>=20
> Fixes: 5b95c427d187 ("batman-adv: Annotate deleting functions with extern=
al
> lock via lockdep") Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.bl=
ue>
> ---

Reviewed-by: Sven Eckelmann <sven@narfation.org>

Kind regards,
	Sven

--nextPart3713661.lmOlaNnlZH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXkUZMAAoJEF2HCgfBJntGB8IQANXYF165svARFUkr95vg4KwY
xUp5toixcOmuPexnHrD4wF+z7mQcdKevE6ypj6ezE04/fPImt7E9S6pU2VHZ9hyV
JTKBy4ljSEhBO4uMXVJeO6WiLbIfm2xIC6VM9VRqCmGjuCGi7Dz+o/XwK03Eu7Zk
vNAoTwIxCeX/YrY9En2NhFUTuBBh83mpXoKK+kHdzZ55c4HbzAl7orQTr5diNXC/
zsp72+AALhmxmgigFqzcW8okl3qw6M4vZLMfgHZ8Bm0UC0bSmleCks9jctgfDZMN
sPQMHY0ek4JWxHkoMzg0TlQ0G6W8Kc9Ck96A/hy9koBmJ7aiaNKeospmDv0A9yyw
K3W8dvELQi6vDKqbwH50V0L5mAQB1VuGNR83ysXiu01B+lWAH8bL36MOdaYo1Avb
4B6fCkN47rdxzxS2L+jUSKSE4asmC8EQvI3wzXsaxGMez03XpNTKIUqAoZLbM+EW
cyubNG3RMcyWiJbs0dTPYsrSeSnBCzF4LM+s9d40d15IGRLIioiu5fKZ0Gx2Xkt0
0rTFSmahywwq5KWPXoRLQHuZrx2M8JKyznls9154HQ5d/DwTrND8A3AmAFGKfYX/
uAFGOXHNPgU09EJ1YegHvzixAStw9p69I1aCAxs7bYh/Wj3U7zmMpW6qJ+nccjtZ
UhpPlJt1TIQst19BbYQb
=/80T
-----END PGP SIGNATURE-----

--nextPart3713661.lmOlaNnlZH--


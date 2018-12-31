Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 31 Dec 2018 20:17:58 +0100
Message-ID: <2071883.YQQqAYjll7@sven-edge>
In-Reply-To: <20181231115936.GE4150@otheros>
References: <20181207135846.6152-1-sven@narfation.org>
 <20181207135846.6152-4-sven@narfation.org> <20181231115936.GE4150@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2017907.nQK1TWLzGE";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC v3 03/19] batman-adv: Prepare framework for
 hardif genl config
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

--nextPart2017907.nQK1TWLzGE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday, 31 December 2018 12.59.36 CET Linus L=FCssing wrote:
[...]
> >  static int batadv_pre_doit(const struct genl_ops *ops, struct sk_buff =
*skb,
> >  			   struct genl_info *info)
> >  {
> > -	struct batadv_priv *bat_priv;
> > +	struct batadv_hard_iface *hard_iface;
> > +	struct batadv_priv *bat_priv =3D NULL;
> > +	int ret;
> > +
> > +	if (WARN_ON(ops->internal_flags & BATADV_FLAG_NEED_HARDIF))
> > +		return -EINVAL;
> > +
> > +	if (WARN_ON((ops->internal_flags & BATADV_FLAG_NEED_HARDIF) &&
> > +		    (~ops->internal_flags & BATADV_FLAG_NEED_MESH)))
> > +		return -EINVAL;
>=20
> Seems like the second part is unreachable code. If
> BATADV_FLAG_NEED_HARDIF is set then the function returns with the first
> if-clause already.

Looks like I've incorrectly splitted the patch at this position. Makes more=
=20
sense when you check the next patch.

So the first check should be removed from this patch to make it less=20
confusing.


Btw. thanks for the spelling/grammar fixes.

Kind regards,
	Sven
--nextPart2017907.nQK1TWLzGE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlwqa2YACgkQXYcKB8Em
e0bNnQ/9FDfouEKRUOk4WTdINgjbrePiPpliWeY92DyMrLTYhBoDERp9eg4NsqN4
D0OYXCmhVkvnX6wHykNNz/6hu0ZvrNu3rokRzVa0lBf2WRu9RZSWE3ZZTSaxeYns
E6mwmivV/ii35NGidJz/BsPOGsK/QdTe6EyLQ1l8EhPxv1qluwsY+OgdN9URbtwR
+jaLMsRDOiXdgCX2iN20Q/PAZnKvj/C6VH4M30xztdlu6/lyKYqOMa2gwnz7YZKu
OgqtTKH7t4wiqF/Kj3yCZ+E0L5qk6qsM1zuMz3v7qYEkw6I6SiwOiudvI205YbCm
gdrxVNyQQj2wZfrAdBI248Z8gu+jbTKYpC3flMTO8wH7cQloTAUjS8hrREUzIsrt
LeukpKajo7EKmFuthNqS1aCrM4enIzVJyFzwD4EVSpa0riH7NpKbev2Q00PXgIjJ
8FvJl2wKWr+SVvzeft1GQcv6X/gHLbqp+ViVE3dQO0etDLI5PBZ5PTlIkZq/h6Pm
InwE0Z60GE/EhMNYRa1keFH7hg72PQTyK1yH7CawLxk57DcNsDg44q1+h5njOhZF
jwWg/wOeQBWhyJhJ5K/x5578nvR7+y3uC8kbhcTtKWAHtAGOneAx4I/fOP1h4VK5
4Oy1fxEU+omcIa10ktxaed1ptCQZIW6q5A3+q6agVZYIHJoipDU=
=CkKg
-----END PGP SIGNATURE-----

--nextPart2017907.nQK1TWLzGE--




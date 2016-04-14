Return-Path: <a@unstable.cc>
Date: Thu, 14 Apr 2016 09:39:15 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160414013915.GA28908@prodigo.lan>
References: <1460576087-21474-1-git-send-email-a@unstable.cc>
 <1891393.XZXRhtYPY0@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <1891393.XZXRhtYPY0@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: B.A.T.M.A.N V - make sure
 iface is reactivated upon NETDEV_UP event
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 13, 2016 at 10:32:43PM +0200, Sven Eckelmann wrote:
> On Thursday 14 April 2016 03:34:47 Antonio Quartulli wrote:
> [...]
> > diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
> > index 9abfb3e..316af66 100644
> > --- a/net/batman-adv/types.h
> > +++ b/net/batman-adv/types.h
> > @@ -1277,6 +1277,7 @@ struct batadv_forw_packet {
> >  struct batadv_algo_ops {
> >  	struct hlist_node list;
> >  	char *name;
> > +	void (*bat_iface_activate)(struct batadv_hard_iface *hard_iface);
> >  	int (*bat_iface_enable)(struct batadv_hard_iface *hard_iface);
> >  	void (*bat_iface_disable)(struct batadv_hard_iface *hard_iface);
> >  	void (*bat_iface_update_mac)(struct batadv_hard_iface *hard_iface);
>=20
> kernel-doc is missing for @bat_iface_activate

Thanks Sven, I sent v2 with the kerneldoc

Cheers,


--=20
Antonio Quartulli

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXDvTDAAoJEJ4aZjxxc6bKlQYP/jOGdNUtj4coztMa9N75f49+
PJHUlUVvfuONsuf3vdaWQe9WcL3yP3qPJP0pNvanMUG5/EqbudIDFc5tB1Qgfez3
BejkGVUWFF+D11ZPq1snqvleplJKGWvcQxntHXFshhY9I5Gay5WrhZbbAWbs/z8H
36uhj9NO6unqu/aCprcmOabkAgYKT2KZPvlKs8gePXKf9+UKxAdddiyfpUXjZD7P
ozKB99bTrYgIc60TEF2A48xwHRX5OIqErQMjHgdgFzW/qwM8F9+S0Jsaav6xmxwP
47FLOK4GWlsPGzFYraAL7WFjT96VwKGc0QDgCl4XfM3e00pi5PVmaJAV0sWFUOQ7
SuXQi3piQjCkA9g/GZMxu08+dNS8ttfNcDqJ7N4V1+DkkfNeMqbI/G3IO5vqYtB8
Akoql3PlmAX61O2z5XDcTsboZlV0ISPp372TU7STPDNaJ4Gk1iNk5KoncBetTo+z
E9DP1PnUJZr8VAISeMbXXhU+5JC8E3S3r+6CDmlMYa6dt0fyk9PujtQi9XjRrFRf
m5BvfQ+1a06FAwog+3LfPwGDfkoX6UJ4oS+VbmQDN9U/Cdd1LY0S+V08XrRjTKu0
Qapc+VdezAzH5AVaEXac4qDaxPH7GK2n/hvvoHZbndV3RBkJkWBq3YKV6lTGc/cc
wbhrrRR6yO/qO2SScNAl
=I+Es
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--

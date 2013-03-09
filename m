Return-Path: <ordex@autistici.org>
Date: Sat, 9 Mar 2013 21:17:21 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130309201721.GQ1400@ritirata.org>
References: <cbb43bcdb70a791087a6d9284732ff94963ce51b.1362825185.git.mschiffer@universe-factory.net>
 <f3fbb764235104e6dbc9a8e58ba66283d15e9d9f.1362825572.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6iXXu7NwgEt9u5a7"
Content-Disposition: inline
In-Reply-To: <f3fbb764235104e6dbc9a8e58ba66283d15e9d9f.1362825572.git.mschiffer@universe-factory.net>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: send each broadcast only
 once on non-wireless interfaces
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--6iXXu7NwgEt9u5a7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Matthias,

On Sat, Mar 09, 2013 at 11:40:26AM +0100, Matthias Schiffer wrote:
> @@ -515,6 +515,17 @@ batadv_hardif_add_interface(struct net_device *net_d=
ev)
>  	INIT_WORK(&hard_iface->cleanup_work,
>  		  batadv_hardif_remove_interface_finish);
> =20
> +	hard_iface->num_bcasts =3D BATADV_NUM_BCASTS_DEFAULT;
> +
> +#if IS_ENABLED(CONFIG_WIRELESS_EXT) || IS_ENABLED(CONFIG_CFG80211)
> +	if (net_dev->ieee80211_ptr)
> +		hard_iface->num_bcasts =3D BATADV_NUM_BCASTS_WIRELESS;
> +#if IS_ENABLED(CONFIG_WIRELESS_EXT)
> +	else if (net_dev->wireless_handlers)
> +		hard_iface->num_bcasts =3D BATADV_NUM_BCASTS_WIRELESS;
> +#endif
> +#endif
> +
>  	/* extra reference for return */
>  	atomic_set(&hard_iface->refcount, 2);

What about re-using batadv_is_wifi_iface() instead of adding the same code =
here?
:)

batadv_is_wifi_iface() takes an ifindex as parameter and then gets the
net_device by means of dev_get_by_index. You may want to split it up so tha=
t you
can avoid the research since you already have the related net_device object.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--6iXXu7NwgEt9u5a7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRO5jRAAoJEADl0hg6qKeOkoAP/1NuTyhX8et45RSr5qNyDxLE
NNGDAmilX9qJT/kYd1uNwiXUDnGjY9G/Tp8fvCAD9WpT5bnoLLrFwBgY7TfJEp9P
Y+wnfXYEuFKiDb2khvB2ErCyiaedeGuUklCUqER0wBz6GAr/CjYloy0OeokdhCyg
puTqkkGziN1NICx7kXX0WZMuCmmJkv7pvTQQ73SnlZiKY4RVg8FqZZd3i/esfcLh
py9xvQ31gKGzpiMy20KGipjZflI8j2lzpqoWGhmu/qjOgS6U0OfqbOmqaUNLBuTZ
jqk9QwIqevhhFtMkJhIZVv0tFfuGcjAlKJTmgvFlphK1YY06fXrTNsNJelPAmk2v
ks1RR5GA+iT+EaEiBTqha1aBLfThKf5UfmeL5q1zcnskVPI2Uukmj3HgfMm6YagR
J6ofFeGqitf1ehntBziMvU46mjKYU6bmY2F564jYqW1fHKuR7WeekHf3zNEFFZjk
x7xjwLgtYz0IbZcNMiLmTLH3Fjw3yTy/KjkA+LXSq9HyP/SB+QgmhkKkk6WY4p73
P7ZgC9zlp2LPJ+f6aHBnEutfuifWQwfGRVItoGJQUO67yiPh12DFtk9PkaKpA3OM
X+hhdPgY0Tqtr+z66iBibJxNa47zQUx8CjEoXvEl1gehjCnnKfsWzxVp6zokP6CL
p1qzMPoxWsK1qW0evCu3
=LIY9
-----END PGP SIGNATURE-----

--6iXXu7NwgEt9u5a7--

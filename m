Return-Path: <a@unstable.cc>
Date: Fri, 27 Jan 2017 22:34:22 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20170127143422.GF12187@prodigo.lan>
References: <20170127141044.5317-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Content-Disposition: inline
In-Reply-To: <20170127141044.5317-1-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: Avoid buffer overflow while
 querying ARP cache
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


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 27, 2017 at 03:10:44PM +0100, Sven Eckelmann wrote:
> The arpreq.arp_dev is a limited buffer (16 bytes). Avoid that more bytes
> from the interface name are copied into this buffer by switching from
> strcpy to strncpy.
>=20
> Fixes: c7da798113a2 ("alfred: IPv4 multicast distribution support.")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  util.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/util.c b/util.c
> index 84ab3af..ed83895 100644
> --- a/util.c
> +++ b/util.c
> @@ -92,7 +92,9 @@ int ipv4_arp_request(struct interface *interface, const=
 alfred_addr *addr,
>  	sin->sin_family =3D AF_INET;
>  	sin->sin_addr.s_addr =3D addr->ipv4.s_addr;
> =20
> -	strcpy(arpreq.arp_dev, interface->interface);
> +	strncpy(arpreq.arp_dev, interface->interface, sizeof(arpreq.arp_dev));

arpreq is already set to 0 few lines above. why not simpling
"sizeof(arpreq.arp_dev) - 1" as last argument for the strncpy() and avoid t=
he
line below?

Or is this required for consistency with the rest of the code?


Cheers,

--=20
Antonio Quartulli

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYi1pqAAoJEJ6F1zG2JyOsRNUP/jONy7IBhGPBXOVO8sF083i5
wL3VpbYVCwPcobnlZhmdLw6jlYbLMHIfXHLGGKqIIcUxqmDpGrGqISqliF+d6j3B
qptGA19T4BUvfXEzyMPyTffWfVq25lKdWx4M7fV+uzMHYhHqwMeBSeuvYgV3Vpp/
TLsxiyVCv8+Ht1RvLHioKSFQ6Nj4uRDbciYu6ZVEo32oAA6PHQldu5BdjVf9XicS
Z9m2FRMhf7hAZYZochRVAGUQtcUInwQCMajyinewyJvi/GIjyy7nDNTcuudvr9Ph
ZbRFMWiOAp0YkOXPiuEK6JkZlpDrlCytgdNY5gC9+dpYKVkwdT7PRBnElmXPf6bW
liSiXeljT+nkPbXDiLKJgHisV0IIUsiaCj4cWkjD+hiEzVm87UFmxsO16psStSGs
LhkoaM88aW93hSBxsg2Z9UENXrdpvIg4+3DZR1EwunfmvwNNwo3/ADe2+i1a73aW
kgisG1BKJ/m5ea4u+sIGdev+hwHqV5e6nJljBxU2aGSp3m5azIoCxIthp8KZ4Na1
UkXbW8r3ZF7VkHjQAMbgSACmGUZVfwkvIKKox5ZT2wT+NN3dDAzkvH6fdRdIxC/D
W+u6EUhJSlpDOQJLWmUogf1DfuqFxZ5ooA6vO/4PEcSGn7wRjxyrYeyUl6LiPZzt
zzAwcpp1fTBfr+04jhc5
=pPM9
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--

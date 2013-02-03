Return-Path: <ordex@autistici.org>
Date: Sun, 3 Feb 2013 19:49:24 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130203184924.GA3429@ritirata.org>
References: <1405827.5RSdDMUrGW@sven-desktop.home.narfation.org>
 <1359916914-9798-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <1359916914-9798-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [FIX] batman-adv: fix master setting in rtnl
	interface
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


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 03, 2013 at 07:41:54PM +0100, Antonio Quartulli wrote:
> diff --git a/hard-interface.c b/hard-interface.c
> index 6c32607..bbc6188 100644
> --- a/hard-interface.c
> +++ b/hard-interface.c
> @@ -313,7 +313,7 @@ int batadv_hardif_enable_interface(struct batadv_hard=
_iface *hard_iface,
>  	struct batadv_priv *bat_priv;
>  	struct net_device *soft_iface;
>  	__be16 ethertype =3D __constant_htons(ETH_P_BATMAN);
> -	int ret;
> +	int ret =3D 0;

mh, maybe this is not really needed.
Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRDrE0AAoJEADl0hg6qKeOQZgP/25YDtk+Rqx02t3LbRWcr6TQ
soZCjMQOC4wkesTVtGZM3kmHvX8mfCqwA87igBlnZ/Rf18JpBILJK6mmxrP+yr6h
751UAaRiY0cMhR6KyxIux5CYwbOLAeuGjO8ZWdFLWG6oVMmZwWrqwCahr9+/Z9O7
7veliSzKvTg5UoJCFvAx0mrWs0tvHqF478saPH3J8aL9hselRlSm1sM6+6qKROoW
5psxV4wIH8mcXGGEczaqqF5KC9fDuqZUyi77mnvpm5GMbxtmgQr95DGATgSJqNH9
GdjJrGG15rbEBauq/ZF05fSzbFAWqQalmsuFpWZJ/yYEdsRl0m116tClIvqGKjJ8
KXrtZYypoZdOqJRLPi99G2P0E4WwLkOposR8ZYmnogpJJD5huteztNe/eiow5wIV
Pvt9KFXM2Ix48CD9S0OZrzxCk7ElRvqi1VP6FxE7V9MH0eZWI6vopa8stsEqOcso
YSjXyyGQf1xmxF9Vm0gceyA0MMqFVAdyxClKppe2FcFEXM03WTP42dlX9m+1Bolk
JVv0x5Xj/6HU8wzlM455Glh437147F3Rk1Zc2YzI0a/XE9Swyz5FsqL1bNRSah3N
N85dVeL3C1+KIrWc1tsiOuBPF6KM+uvGCKx3jAo+IAPQwaGrQsEi3O5z2pfObF0s
BHkfwnZ7kqDPxp3t6oYK
=q1Pe
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--

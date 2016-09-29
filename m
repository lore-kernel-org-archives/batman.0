Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Thu, 29 Sep 2016 18:39:04 +0200
Message-ID: <1741703.FnyRNTXpQ6@sven-edge>
In-Reply-To: <20160920121245.593-2-linus.luessing@c0d3.blue>
References: <20160920121245.593-1-linus.luessing@c0d3.blue>
 <20160920121245.593-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2529175.aWr83AmAcm";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: Store and transmit own
	neighborhood hash
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

--nextPart2529175.aWr83AmAcm
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 20. September 2016 14:12:43 CEST Linus L=FCssing wrote:
[...]
> diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
> index e79f6f0..762b34c 100644
> --- a/net/batman-adv/bat_v.c
> +++ b/net/batman-adv/bat_v.c
[...]
> +	memset(bat_v->neigh_hash, 0, sizeof(bat_v->neigh_hash));

Include <linux/string.h> is missing for it. Can you please add while
resending the patch?

[...]
> diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
> index ee08540..d4b5750 100644
> --- a/net/batman-adv/bat_v_elp.c
> +++ b/net/batman-adv/bat_v_elp.c
[...]
> +	pr_warn_once("An error occurred while calculating neighbor hash for %s\=
n",
> +		     hard_iface->net_dev->name);
> +}

Please include linux/printk.h for pr_warn_once.

[...]
> +int batadv_v_elp_init(void)
> +{
> +	tfm =3D crypto_alloc_shash("sha512", 0, 0);
> +	if (IS_ERR(tfm))
> +		return PTR_ERR(tfm);

These two require linux/err.h

[...]
>  int batadv_mesh_init(struct net_device *soft_iface)
> diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
> index 3f1c286..3a5612d 100644
> --- a/net/batman-adv/originator.c
> +++ b/net/batman-adv/originator.c
[...]
> +		if (memcmp(tmp_hardif_neigh->addr, neigh_addr, ETH_ALEN) >=3D 0)
> +			break;

memset requires linux/string.h

Kind regards,
	Sven
--nextPart2529175.aWr83AmAcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJX7UOoAAoJEF2HCgfBJntG6eMQAMNtnsNjNwqGpXhLEb80MprS
TpSdSrbkczfegbkW1aXa31HSiYeRiUN0muL/il4Ka5rjum3WdqD6XstRcyjFtHhZ
FmBvpyPhwTP6u+AGnM6klJdJKzWK8oyD0DBEmQGq+O34IRBIzzpFPx1j5a8RaZY4
ieY6cx9YYYW+FKbPQZeuP9BmaJd1W0ot3cykwNkIqYwqcM6ckuSgSYLbziA8m/nn
TN7bSoduPcICHbrNkeUjd3YtiQVX6jb9LxQ+3bw9gtuKJBIFAsh/VPRPTWuFe59f
Pe2vKPtuT9LwdI7YRgygtkUwS4Eogb0jvaCIziRBjWYBs3rN7tL6w0efa8t5FUly
e6WRl8UiusnDP4tU9zOOFhjUN9+k9ODIPx47rPGgcM5OM7drdeu/gJjnQ0ELqh4G
ZdJtMKrt1B9tb5epUiS4XSzlka7FEcQlljFAp/OFTCVMI5OhB6JWA6uXbGDUIVWq
+RoS2v72s1lZqqnxzcNu/0Xtw9903Q4JL+sM1AEsraFyue+ctDXQLnvGCEE9yaMb
U1WfjuqbDo6J/D5bF7ojCprQvEWfdFoD+wwJIFr0tTztXfzCsNCX6iYroWZHu0N2
xOV70iVICFB8Z2WJ3ZYEdyWe89QHVbFaTqfR3eUmj498Gkz7LjsndBhCmSwlIoD1
+rY7CgRTJjwsTS4PXZjC
=HXAT
-----END PGP SIGNATURE-----

--nextPart2529175.aWr83AmAcm--


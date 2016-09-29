Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Thu, 29 Sep 2016 18:05:22 +0200
Message-ID: <1927845.coqzugHYhY@sven-edge>
In-Reply-To: <20160920121245.593-2-linus.luessing@c0d3.blue>
References: <20160920121245.593-1-linus.luessing@c0d3.blue>
 <20160920121245.593-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1828500.gO4tTlHnSD";
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

--nextPart1828500.gO4tTlHnSD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 20. September 2016 14:12:43 CEST Linus L=FCssing wrote:
[...]
>  /**
> + * batadv_v_elp_update_neigh_hash - updates neighborhood hash related da=
ta
> + * @hard_iface: interface which the data has to be prepared for
> + *
> + * Firstly, this function updates the neighborhood hash of a hard interf=
ace.
> + * That is it resummarizes the present neighborhood into one compact hash
> + * representation.
> + *
> + * Secondly, minimum and maximum throughput values within this neighorho=
od are
> + * updated.
> + */
> +static void batadv_v_elp_update_neigh_hash(struct batadv_hard_iface *har=
d_iface)
> +{
> +	struct batadv_priv *bat_priv =3D netdev_priv(hard_iface->soft_iface);
> +	struct batadv_hardif_neigh_node *hardif_neigh;
> +	struct ewma_throughput *ewma_throughput;
> +	u8 *own_addr =3D hard_iface->net_dev->dev_addr;
> +	u32 min_throughput =3D ~((u32)0), max_throughput =3D 0;
> +	u32 throughput;
> +	int ret;
> +
> +	SHASH_DESC_ON_STACK(shash, tfm);

This macro doesn't exist on Linux < v3.18. Can you please add it to
compat-include/crypto/hash.h?

[...]
> +/**
> + * batadv_tvlv_nhh_data - neighborhood hash data
> + * @min_throughput: worst of all TX throughputs this neighbor has to oth=
ers
> + * @max_throughput: best of all TX throughputs this neighbor has to othe=
rs
> + * @neigh_hash: a sha512 hash of all neighbors this neighbor sees
> + *  (hash over the alphabetically ordered, concatenated, binary represen=
tation)
> + */
> +struct batadv_tvlv_nhh_data {
> +	__be32 min_throughput;
> +	__be32 max_throughput;
> +	u8 neigh_hash[SHA512_DIGEST_SIZE];
> +};
> +

Please use "struct batadv_tvlv_nhh_data - neighborhood hash data" in
kernel-doc block


Kind regards,
	Sven


--nextPart1828500.gO4tTlHnSD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJX7TvCAAoJEF2HCgfBJntGOnoP/1n2Qz7Eq8NYPodz4lqG41F+
SDze28J4cQ0a6OqNDmaLu66411pAI9tbQXLkVISQm0QJ4kLrGWszB/JS1Nls/oeg
fF105MyXLkag0ueuIV/7xz79+Z3H6w8yKAgv7buOvIh3pMeUoqvo+tyKQSeNXnoU
LD0A/ZxSSVC0CznguJzdL2NUQCEedC/Rja/Z1w0DmhRzBoBMWGEmhDwnkjMtyRFr
TLUEVB2oMkBh2VUG5S5T0hsrlgQHg3CjX1EoGKhb4lCuyNIWMUBSMsj9EtMARoNN
KcT4DeWWBIWnGWCr7FnWHPIl10AZ/kMbubm1Ld1ZFLNZxEy5j+V0AkOopnLPAVfX
F+lgDyDta82ZHAa2UMYxbsc6WucG2RfsdtqkNbK3KnKxFn2bYzTDB1H1BtVPYBJh
MefpgziUKShfDtwhE/+7kbiii77ZrsVjFbWy5hpN1A7wFK5OlTMXgpJrj9NNjqPs
tOpUIb6GprGxnzocJnPzR0UHb7Qc+Wl0j7YGx66PguZT44sAePfdNmcjTDwo1Ess
SkcNDlEryP/vXyi9DeSHdDEq1cBkJQfNu2VIcY+vVFNJfhGuvHgcwFw4tf5U4Xmg
ghd/zBKsCko9SSoVgplfhGA8Ta0dIoHVawZo0WaWH11J8VmCaxFxWnSTaJ8tqOL7
Yz3igh7JwDemSMvR8wuC
=ijom
-----END PGP SIGNATURE-----

--nextPart1828500.gO4tTlHnSD--


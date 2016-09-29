Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Thu, 29 Sep 2016 18:46:22 +0200
Message-ID: <1868968.mA82KYzBaD@sven-edge>
In-Reply-To: <20160920121245.593-3-linus.luessing@c0d3.blue>
References: <20160920121245.593-1-linus.luessing@c0d3.blue>
 <20160920121245.593-3-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5160344.aBWApIApp0";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: Introduce packet type
	independent TVLV handler API
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

--nextPart5160344.aBWApIApp0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 20. September 2016 14:12:44 CEST Linus L=FCssing wrote:
[...]
> diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
> index 77654f0..b4a0442 100644
> --- a/net/batman-adv/tvlv.c
> +++ b/net/batman-adv/tvlv.c
[...]
> +		if (tvlv_value_cont_len > sizeof(tvlv_value_buff)) {
> +			pr_warn_once("batman-adv: TVLVs greater than 128 bytes unsupported fo=
r now, ignoring\n");
> +			goto skip_handler_call;
> +		}

Please add the include of linux/printk.h for pr_warn_once.

[...]
> +	WARN_ON(!orig_node);

Please add the include of linux/bug.h for pr_warn_once.


> diff --git a/net/batman-adv/tvlv.h b/net/batman-adv/tvlv.h
> index e4369b5..b3d604f 100644
> --- a/net/batman-adv/tvlv.h
> +++ b/net/batman-adv/tvlv.h
> @@ -30,12 +30,21 @@ void batadv_tvlv_container_register(struct batadv_pri=
v *bat_priv,
>  u16 batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
>  				     unsigned char **packet_buff,
>  				     int *packet_buff_len, int packet_min_len);
> +void *batadv_tvlv_ogm_pack_ctx(struct batadv_orig_node *orig_node);
> +struct batadv_orig_node *batadv_tvlv_ogm_unpack_ctx(void *ctx);
>  void batadv_tvlv_ogm_receive(struct batadv_priv *bat_priv,
> -			     struct batadv_ogm_packet *batadv_ogm_packet,
> +			     const struct sk_buff *skb,
>  			     struct batadv_orig_node *orig_node);

The forward declaration for "struct batadv_ogm_packet;" should now be
replaced with "struct sk_buff;"

Thanks,
	Sven
--nextPart5160344.aBWApIApp0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJX7UVeAAoJEF2HCgfBJntG7cUP/RXiq2zWHul/kaoNTN+T/KYz
S4pWGkgD0NUam4Nzl5qR+2quhxD3SHZ9PQFdTcTAZhVpn7ow4drklrfmNd1Jdven
bEDs8HbzTHdeKi8Lsfi1HPoLCPZ5WjfUBX1eEmlS2t3HHV/et1Kx4T+OStzG0ZqI
MY/dEfuzHaZNVQl76WklAIeHFjURL8J+Cx+yW4KeFoJD+ofzijEN30xwMPdS9aMN
7lJVl6JxwBjoMdnE5lypsolSgrKOsgyKUESrie0ocpcZaoy7wnGUhjlxFiryPaNO
wTUvb8t7+k2NHJn+X3T4vns6uIYKhGzbyxzOiHVI6LMnGFzFBTUWYkkPZVr3ZkA8
o9Oh6GB3eWbohr0Sir+UQCcWKYPJ9zGtE2gFPsO/BCwi9qmV+fFooTj4kHNz6UUL
RfrsAIiBlSlTMta13u7EgiAai5AsbVeBdj6WW1v2V/MqB6n1CZpEzsBl7F6SlGYS
CfdCmjVrFoTrvwDrDw02EgBWAQE0h+B54PZwEpB3sHhH99yY0CiWqDr6VamYh3s9
fmQWEYtsC9++rnDpO29KXOu3cWhDnItDbrzCc7Yn6VU9rIQkhGhzHBfqLW/n7nvD
kk7z1649eEUDHMxI+9Tp9sr6v0t479DleOOO4yC1ACTKZnrZIiAJyvpcF8oPGZI1
7RIXT0JAA1x9IYNdexAe
=GHYY
-----END PGP SIGNATURE-----

--nextPart5160344.aBWApIApp0--


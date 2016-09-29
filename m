Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Thu, 29 Sep 2016 18:55:21 +0200
Message-ID: <4118077.YhDRDWzlPo@sven-edge>
In-Reply-To: <20160920121245.593-4-linus.luessing@c0d3.blue>
References: <20160920121245.593-1-linus.luessing@c0d3.blue>
 <20160920121245.593-4-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart16595310.tcnJbkfkSJ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: Evaluate and use
	neighborhood hash TVLV
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

--nextPart16595310.tcnJbkfkSJ
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 20. September 2016 14:12:45 CEST Linus L=FCssing wrote:
> diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
> index 762b34c..75a4147 100644
> --- a/net/batman-adv/bat_v.c
> +++ b/net/batman-adv/bat_v.c
[...]
> +	hardif_neigh =3D batadv_v_elp_unpack_ctx(ctx);
> +	if (WARN_ON(!hardif_neigh))
> +		return NET_RX_DROP;

Please include linux/bug.h for WARN_ON.


> index ed5936c..69a9a94 100644
> --- a/net/batman-adv/bat_v_elp.h
> +++ b/net/batman-adv/bat_v_elp.h
[...]
> +bool batadv_v_elp_nhh_cmp(struct batadv_hardif_neigh_node *hardif_neigh);
> +bool batadv_v_elp_rx_ingress_bad(struct batadv_hardif_neigh_node *hardif=
_neigh);
> +bool batadv_v_elp_rx_egress_bad(struct batadv_hardif_neigh_node *hardif_=
neigh);
> +bool batadv_v_elp_tx_ingress_bad(struct batadv_hardif_neigh_node *hardif=
_neigh);
> +bool batadv_v_elp_tx_egress_bad(struct batadv_hardif_neigh_node *hardif_=
neigh);
> +bool batadv_v_elp_no_broadcast(struct batadv_hard_iface *if_outgoing,
> +			       struct batadv_hardif_neigh_node *hardif_neigh,
> +			       bool inverse_metric);

Please include linux/types.h for bool.

> diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
> index 606f899..147d746 100644
> --- a/net/batman-adv/bat_v_ogm.c
> +++ b/net/batman-adv/bat_v_ogm.c
> @@ -43,6 +43,7 @@
>  #include "hard-interface.h"
>  #include "hash.h"
>  #include "log.h"
> +#include "bat_v_ogm.h"
>  #include "originator.h"
>  #include "packet.h"
>  #include "routing.h"

Please remove this duplicate include. bat_v_ogm.h is the first include
in this file :)

Thanks,
	Sven

--nextPart16595310.tcnJbkfkSJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJX7Ud5AAoJEF2HCgfBJntG1OIP/2ooSF2dPA06hcnhUS/nsstn
L4RxEVedpYVav4zk0usSHa3A4rri0uyw43ooewd8uWB9OMDPwfVpUOvI5JZCRmcE
aNXDla1joPaKoUC95tCGCvW5rGp+d5Qy5fxybP7s0cQYkiAC/QJaSh3Nr6sdJ8G7
LhxbYBajBh5ewlrHkEBrd6hLYG8Jvw76sG3fN0v1rt4AUkTek+Zu9aX7PVAc1ahJ
dsEJMsutewUYGRmcVelHElLn3yB70/q8iNItC1qbq5jRnQIVE1EYqU9kx0g0Ensl
+MOoB5sB6kHhTZmOBL4G/LLR73/pqk4ogO9bHAy50SzmUC0mv0kmnq2JRXYW2Eg5
MAfMaK0P/SXw4n/5JK1W756PYj/ATC/B+2009o0QDI1T5qWHAwG/3xo4fY0zYo3e
MADTcUuBJg1QsHrl0tsneBtV0kzMaaK3B/q84EeHSMe/uzrEKW1FyLUqUAZ8wMdI
Dnb2M9Q+BOHCeoaozGkZ03Ucy78Yh0IQV/I5/n7VBgjG6MOHoja+TfsDsPKz+/0H
HyXb3MVSlx9Uq5BhaTxxfYxWhAzvMNqIYrAM5z3ia0frcWjOf6Ca0VFeueMEHeU2
wtTxdSRbZYqNzCX5wi6xMxgWcXy3tFRLTGU9udEqhWW7x1AfJ9JlN/vLpaKh7OOu
LWarGQzY+M3szvV2cK1+
=PAML
-----END PGP SIGNATURE-----

--nextPart16595310.tcnJbkfkSJ--


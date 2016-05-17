Return-Path: <a@unstable.cc>
Date: Tue, 17 May 2016 17:40:15 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160517094015.GD12056@prodigo.lan>
References: <2757709.ryloMgzIDh@bentobox>
 <1462959332-23410-2-git-send-email-sven@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="F8dlzb82+Fcn6AgP"
Content-Disposition: inline
In-Reply-To: <1462959332-23410-2-git-send-email-sven@open-mesh.com>
Subject: Re: [B.A.T.M.A.N.] [PATCH v8 2/2] batman-adv: throughput meter
 implementation
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>


--F8dlzb82+Fcn6AgP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 11, 2016 at 11:35:30AM +0200, Sven Eckelmann wrote:

[...]

> +/**
> + * enum batadv_tp_meter_reason - reason of a a tp meter test run stop

typ0: double "a"

> + * @BATADV_TP_COMPLETE: sender finished tp run
> + * @BATADV_TP_SIGINT: sender was stopped during run

how about calling this TP_CANCEL ? batman-adv does not know much about the
SIGINT because that is only an interface between the user and batctl.

Another thing: how about adding the prefix "REASON" to all these attributes=
 to
avoid confusion with the others ? What do you think ?

i.e. @BATADV_TP_CANCEL --> BATADV_TP_REASON_CANCEL

> + * @BATADV_TP_DST_UNREACHABLE: receiver could not be reached or didn't a=
nswer
> + * @BATADV_TP_RESEND_LIMIT: (unused) sender retry reached limit
> + * @BATADV_TP_ALREADY_ONGOING: test to or from the same node already ong=
oing
> + * @BATADV_TP_MEMORY_ERROR: test was stopped due to low memory
> + * @BATADV_TP_CANT_SEND: failed to send via outgoing interface
> + * @BATADV_TP_TOO_MANY: too many ongoing sessions
> + */
> +enum batadv_tp_meter_reason {
> +	BATADV_TP_COMPLETE		=3D 3,
> +	BATADV_TP_SIGINT		=3D 4,
> +	/* error status >=3D 128 */
> +	BATADV_TP_DST_UNREACHABLE	=3D 128,
> +	BATADV_TP_RESEND_LIMIT		=3D 129,
> +	BATADV_TP_ALREADY_ONGOING	=3D 130,
> +	BATADV_TP_MEMORY_ERROR		=3D 131,
> +	BATADV_TP_CANT_SEND		=3D 132,
> +	BATADV_TP_TOO_MANY		=3D 133,
> +};
> +

[...]

> --- a/net/batman-adv/bat_iv_ogm.c
> +++ b/net/batman-adv/bat_iv_ogm.c
> @@ -160,8 +160,10 @@ static int batadv_iv_ogm_orig_add_if(struct batadv_o=
rig_node *orig_node,
>  	orig_node->bat_iv.bcast_own =3D data_ptr;
> =20
>  	data_ptr =3D kmalloc_array(max_if_num, sizeof(u8), GFP_ATOMIC);
> -	if (!data_ptr)
> +	if (!data_ptr) {
> +		kfree(orig_node->bat_iv.bcast_own);
>  		goto unlock;
> +	}
> =20

is this chunk coming from another patch ?


[...]

> --- a/net/batman-adv/routing.c
> +++ b/net/batman-adv/routing.c
> @@ -45,6 +45,7 @@
>  #include "packet.h"
>  #include "send.h"
>  #include "soft-interface.h"
> +#include "tp_meter.h"
>  #include "translation-table.h"
> =20
>  static int batadv_route_unicast_packet(struct sk_buff *skb,
> @@ -242,7 +243,6 @@ static int batadv_recv_my_icmp_packet(struct batadv_p=
riv *bat_priv,
>  		/* receive the packet */
>  		if (skb_linearize(skb) < 0)
>  			break;
> -

why removing this line ? is it a style adjustment ?

[...]

> +
> +/**
> + * BATADV_TP_PLEN - length of the payload (data after the batadv_unicast=
 header)
> + *  to simulate
> + */
> +#define BATADV_TP_PLEN 1450

shouldn't this depend on BATADV_TP_PACKET_LEN ?


Cheers,

--=20
Antonio Quartulli

--F8dlzb82+Fcn6AgP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXOub/AAoJEJ4aZjxxc6bKJYwP/jE2ziFp1pD4hqkz11eHBQii
Z/oMw9Qkf1gF0nVz2ClWGaV+ozfcqjaZO/MidE/F8ZF5EdcpaBCMu0K9Fc0YY+Om
xH1CyIq49TY9PDwpzuwiZCzoL+VOtQhrd1z1jgRcKe6ecHTos4MQ7jUO+oh30Huj
dsPTa6bR8Bm+KJ2Bu7ZT7o6XN+CXRRYtkpS1xoD9pZq6t4rNQo72iCwJe99RBKvR
jTGDFGReE5aJdz4JoX8CTZqc8EAKtgkXdCtMxkoDY9svM5Wj5BGv3q+vKujiriCA
NWoLJT3UWnJJiUYqDo3PUE+hJ4zvfK1BYsvwOswz4ohzkhUtG3xNoHKYXXtS3OFz
Wz9Hg1re5UMkDNlupVbne0uqcvf6ZkHiSIpPdK0viaiNjEnwJCxKZp3W9j0i0YmS
QlqAkWAFO9V2HQfkYDPrQ7KoThekK8eOJ0qRf30NfW08/hoQLgNbrX6CpHFXps81
TLaiXhZw/pnPRDqIqTvWAZXO6FMSL6iBRNBSVZuNPED5TrJ9FsBJXulPF85qdQQ/
ZGn0nl3NdcHJaZADzionyKdxNL5z6F03DLScSStNIcgTSG0mbYuuMxYq3XCKm8uX
IUleysjzVB2iAVBT6NF5Jxwgjab6Te4dlBqnLsxN+CXTvctJ8oHXRH9CIok3hTL8
52uAk4CMqQdhuREMXCyO
=k7Va
-----END PGP SIGNATURE-----

--F8dlzb82+Fcn6AgP--

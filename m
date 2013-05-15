Return-Path: <ordex@autistici.org>
Date: Wed, 15 May 2013 09:07:35 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130515070735.GA3350@ritirata.org>
References: <1368476582-19220-1-git-send-email-martin@hundeboll.net>
 <1368476582-19220-2-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <1368476582-19220-2-git-send-email-martin@hundeboll.net>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/3] batman-adv: Remove old
 fragmentation code
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
Cc: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@hundeboll.net>


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 13, 2013 at 10:23:00PM +0200, Martin Hundeb=C3=B8ll wrote:

[...]

> +/**
> + * batadv_send_skb_prepare_unicast - encapsulate an skb with a unicast h=
eader
> + * @skb: the skb containing the payload to encapsulate
> + * @orig_node: the destination node
> + *
> + * Returns false if the payload could not be encapsulated or true otherw=
ise
> + */
> +static bool batadv_send_skb_prepare_unicast(struct sk_buff *skb,
> +					    struct batadv_orig_node *orig_node)
> +{
> +	size_t uni_size =3D sizeof(struct batadv_unicast_packet);

a blank line here is needed

> +	return batadv_send_skb_push_fill_unicast(skb, uni_size, orig_node);
> +}

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRkzQ3AAoJEADl0hg6qKeOnyIP/0dHm9Dp/Rk84DlpJsnJZgog
yTOXi8HtdsuAP3JGns47Oa5dJCUnDY+hK8vJsydQDlxy378jyh1Jbr2xhVnj6A88
W158zC3o73pFmB1rS06XzxBJcXQV5Tmq3JwHipd+Q9C+3w//oJn5ujp2Dy+qOwua
xfVowKXmggbAib12TfGp3T/33UyilB+5HYW3+zP2vvvdAqM7Ou3Xsu7sBKKme8I5
TCBnetGEH8H1dXS62/pm0fdgy0XCl16lqfZ+vK7dI0+Q3N/sgkMttSPOLqd1BnDD
xD8pgXkT+Yib49Q0RSIP1nEamGsTxs2gOc3I4SRbAD0AmtlqJUFHyQmxX2eqaLYI
H16mAv9t4QJbKrq3PJ+olvPT6VIOGQRdmbk+qFbMR78y7o11IK1fE2L0GRpNbcHJ
YcaIWBd/ivgvt8HirSCeCL/TGZ/62G8xyR89at2KgwO+PZoR/ynonFqli1tzJLkx
wUPTF16pa6/+U9VBG3EQMX/Aw5+iyaYZ2P9iZjreg5KfuekmW9kf5XWGwrHPfDu5
U21CLdIcP5mmshxbNtGXWgcdyljlV8Bo7hAlrXdiNxenpxjKJvF2PjHguolvPuzG
LU57iU24vUTtyb+Hj6TocBYRCkbsLhvEJjoT2HBXc4t+u5Jo4DP5xrEUzTqReh3x
8kQEczAMFUgACYnhhWtp
=3nQ6
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--

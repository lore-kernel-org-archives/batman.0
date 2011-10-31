Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 31 Oct 2011 01:10:04 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20111031001004.GE10726@pandem0nium>
References: <1319964962-5092-1-git-send-email-ordex@autistici.org>
	<1319964962-5092-5-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qOrJKOH36bD5yhNe"
Content-Disposition: inline
In-Reply-To: <1319964962-5092-5-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/6] batman-adv: Distributed ARP Table -
 add ARP parsing functions
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--qOrJKOH36bD5yhNe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch is not checkpatch.pl --strict clean

On Sun, Oct 30, 2011 at 09:56:00AM +0100, Antonio Quartulli wrote:
> ARP messages are now parsed to make it possible to trigger special actions
> depending on their types (snooping).
>=20
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  arp.c |   43 +++++++++++++++++++++++++++++++++++++++++++
>  arp.h |    7 +++++++
>  2 files changed, 50 insertions(+), 0 deletions(-)
>=20
> diff --git a/arp.c b/arp.c
> index 39043b8..ea7cc1e 100644
> --- a/arp.c
> +++ b/arp.c
> @@ -183,3 +183,46 @@ out:
>  	kfree(cand);
>  	return ret;
>  }
> +
> +/* Returns arphdr->ar_op if the skb contains a valid ARP packet, otherwi=
se
> + * returns 0 */
> +uint16_t arp_get_type(struct bat_priv *bat_priv, struct sk_buff *skb)
> +{
> +	struct arphdr *arphdr;
> +	struct ethhdr *ethhdr;
> +	uint16_t type =3D 0;
> +
> +	if (unlikely(!pskb_may_pull(skb, ETH_HLEN)))
> +		goto out;
> +
> +	ethhdr =3D (struct ethhdr *)skb_mac_header(skb);
> +
> +	if (ethhdr->h_proto !=3D htons(ETH_P_ARP))
> +		goto out;
> +
> +	if (unlikely(!pskb_may_pull(skb, ETH_HLEN + arp_hdr_len(skb->dev) + 8 +=
 12)))
> +		goto out;

use ETH_ALEN * 2 + 4 * 2 instead to show where theses numbers come from.


> +
> +	arphdr =3D (struct arphdr *)(skb->data + sizeof(struct ethhdr));
> +
> +	/* Check whether the ARP packet carries a valid
> +	 * IP information */
> +	if (arphdr->ar_hrd !=3D htons(ARPHRD_ETHER))
> +		goto out;
> +
> +	if (arphdr->ar_pro !=3D htons(ETH_P_IP))
> +		goto out;
> +
> +	if (arphdr->ar_hln !=3D ETH_ALEN)
> +		goto out;
> +
> +	if (arphdr->ar_pln !=3D 4)
> +		goto out;
> +
> +	type =3D ntohs(arphdr->ar_op);
> +	bat_dbg(DBG_ARP, bat_priv, "ARP message of type %d recognised "
> +		"[%pM-%pI4 %pM-%pI4]\n", type, ARP_HW_SRC(skb),
> +		&ARP_IP_SRC(skb), ARP_HW_DST(skb), &ARP_IP_DST(skb));

Would you mind printing the type as string? something like REQUEST or REPLY=
 instead of 1 and 2 ...


> +out:
> +	return type;
> +}

--qOrJKOH36bD5yhNe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk6t51wACgkQrzg/fFk7axbroACfRtJiNnAm4/Abp4rWeG/O4dPg
eZkAmwTw4/O3ptxv/OIQSimWGaAAf4cA
=Cb2M
-----END PGP SIGNATURE-----

--qOrJKOH36bD5yhNe--

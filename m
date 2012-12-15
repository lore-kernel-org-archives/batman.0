Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 15 Dec 2012 16:10:17 +0800
References: <cover.1355466678.git.martin@hundeboll.net>
 <e283ab952a3393aa0128d377436bc127cedd244a.1355466678.git.martin@hundeboll.net>
In-Reply-To: <e283ab952a3393aa0128d377436bc127cedd244a.1355466678.git.martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201212151610.17929.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/7] batman-adv: Return reason for
	failure in batadv_check_unicast_packet()
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

On Friday, December 14, 2012 14:32:46 Martin Hundeb=C3=B8ll wrote:
>  static int batadv_check_unicast_packet(struct sk_buff *skb, int hdr_size)
>  {
>  	struct ethhdr *ethhdr;
> @@ -564,15 +574,15 @@ static int batadv_check_unicast_packet(struct sk_bu=
ff
> *skb, int hdr_size)
>=20
>  	/* packet with unicast indication but broadcast recipient */
>  	if (is_broadcast_ether_addr(ethhdr->h_dest))
> -		return -1;
> +		return -2;
>=20
>  	/* packet with broadcast sender address */
>  	if (is_broadcast_ether_addr(ethhdr->h_source))
> -		return -1;
> +		return -3;
>=20
>  	/* not for me */
>  	if (!batadv_is_my_mac(ethhdr->h_dest))
> -		return -1;
> +		return -4;
>=20
>  	return 0;
>  }

Returning meaningless numbers isn't the way to go. Either we make our own=20
defines or we re-use our E***** friends.

By the way, I suggest to send this patch separately. It increases the chanc=
e=20
of getting merged faster and reduces your patchset.


Cheers,
Marek

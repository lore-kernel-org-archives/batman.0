Return-Path: <a@unstable.cc>
Subject: Re: [PATCH maint] batman-adv: Only read tvlv_len after checking
 buffer size
References: <20190822065536.18926-1-sven@narfation.org>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <d157c88f-d5e9-ce53-0db2-50ad0d11a6fc@unstable.cc>
Date: Fri, 23 Aug 2019 09:45:02 +0200
MIME-Version: 1.0
In-Reply-To: <20190822065536.18926-1-sven@narfation.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="L4CwaLgsABUF8aLi2zJ9byztBBC8ne0dz"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>
Cc: syzbot+355cab184197dbbfa384@syzkaller.appspotmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--L4CwaLgsABUF8aLi2zJ9byztBBC8ne0dz
Content-Type: multipart/mixed; boundary="NmP3AGxCta3Ggk24x7yc4Tgc1hDIjUJo6";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>
Cc: syzbot+355cab184197dbbfa384@syzkaller.appspotmail.com
Message-ID: <d157c88f-d5e9-ce53-0db2-50ad0d11a6fc@unstable.cc>
Subject: Re: [PATCH maint] batman-adv: Only read tvlv_len after checking
 buffer size
References: <20190822065536.18926-1-sven@narfation.org>
In-Reply-To: <20190822065536.18926-1-sven@narfation.org>

--NmP3AGxCta3Ggk24x7yc4Tgc1hDIjUJo6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Sven,

On 22/08/2019 08:55, Sven Eckelmann wrote:
> Multiple batadv_ogm_packet can be stored in an skbuff. The functions
> batadv_iv_ogm_send_to_if()/batadv_iv_ogm_receive() use
> batadv_iv_ogm_aggr_packet() to check if there is another additional
> batadv_ogm_packet in the skb or not before they continue processing the=

> packet.
>=20
> The length for such an OGM is BATADV_OGM_HLEN +
> batadv_ogm_packet->tvlv_len. The check must first check that at least
> BATADV_OGM_HLEN bytes are available before it accesses tvlv_len (which =
is
> part of the header. Otherwise it might try read outside of the currentl=
y
> available skbuff to get the content of tvlv_len.
>=20

Your explanation makes a lot of sense. Thanks for digging into this.

> Fixes: 0b6aa0d43767 ("batman-adv: tvlv - basic infrastructure")
> Reported-by: syzbot+355cab184197dbbfa384@syzkaller.appspotmail.com
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Please check this thoroughly. I just made this change while waiting for=

> something else to finish. So I have not tested it at all.
>=20
> Bug for this can be found under https://www.open-mesh.org/issues/398
> ---
>  net/batman-adv/bat_iv_ogm.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
> index 240ed709..61836143 100644
> --- a/net/batman-adv/bat_iv_ogm.c
> +++ b/net/batman-adv/bat_iv_ogm.c
> @@ -277,17 +277,22 @@ static u8 batadv_hop_penalty(u8 tq, const struct =
batadv_priv *bat_priv)
>   * batadv_iv_ogm_aggr_packet() - checks if there is another OGM attach=
ed
>   * @buff_pos: current position in the skb
>   * @packet_len: total length of the skb
> - * @tvlv_len: tvlv length of the previously considered OGM
> + * @tvlv_len: tvlv length of the considered OGM

Was this just a typ0 that you are now fixing?
Because I think tvlv_len still carries the same information as before
this patch (assuming this field is available)

>   *
>   * Return: true if there is enough space for another OGM, false otherw=
ise.
>   */
>  static bool batadv_iv_ogm_aggr_packet(int buff_pos, int packet_len,
> -				      __be16 tvlv_len)
> +				      __be16 *tvlv_len)

I personally don't like making this argument a pointer just because "we
will decide later if we want to dereference this address or not".
At least it should be made const to make it clear that this function
will not modify its value.

However, I think it would be cleaner to pass a pointer to the ogm packet
and then access the tvlv_len field when/if needed.

>  {
>  	int next_buff_pos =3D 0;
> =20
> +	/* check if there is enough space for the header */
>  	next_buff_pos +=3D buff_pos + BATADV_OGM_HLEN;
> -	next_buff_pos +=3D ntohs(tvlv_len);
> +	if (next_buff_pos > packet_len)
> +		return false;
> +
> +	/* check if there is enough space for the optional TVLV */
> +	next_buff_pos +=3D ntohs(*tvlv_len);
> =20
>  	return (next_buff_pos <=3D packet_len) &&
>  	       (next_buff_pos <=3D BATADV_MAX_AGGREGATION_BYTES);
> @@ -315,7 +320,7 @@ static void batadv_iv_ogm_send_to_if(struct batadv_=
forw_packet *forw_packet,
> =20
>  	/* adjust all flags and log packets */
>  	while (batadv_iv_ogm_aggr_packet(buff_pos, forw_packet->packet_len,
> -					 batadv_ogm_packet->tvlv_len)) {
> +					 &batadv_ogm_packet->tvlv_len)) {
>  		/* we might have aggregated direct link packets with an
>  		 * ordinary base packet
>  		 */
> @@ -1704,7 +1709,7 @@ static int batadv_iv_ogm_receive(struct sk_buff *=
skb,
> =20
>  	/* unpack the aggregated packets and process them one by one */
>  	while (batadv_iv_ogm_aggr_packet(ogm_offset, skb_headlen(skb),
> -					 ogm_packet->tvlv_len)) {
> +					 &ogm_packet->tvlv_len)) {
>  		batadv_iv_ogm_process(skb, ogm_offset, if_incoming);
> =20
>  		ogm_offset +=3D BATADV_OGM_HLEN;
>=20


The rest makes sense to me.


Regards,

--=20
Antonio Quartulli


--NmP3AGxCta3Ggk24x7yc4Tgc1hDIjUJo6--

--L4CwaLgsABUF8aLi2zJ9byztBBC8ne0dz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAl1fmYIACgkQ9FVsWUWD
Dm3/gg//Ud57otwiVj1pqXJiLHzz9QS6OdO910OFWhfKAodHAFY74siwUz02AA1G
h5ua4nerC52yOwlquDw8pexHqS+Q5PzKKjAS68z61pOknxIMrZXC1tojU2+IIfVy
sr5j9do7F2VfeJytxJX0TtqZHqdA4muTh8refTgriaaeLUf0Ylns1C68PCQH2lMg
RLujZOLCm1VhRYOunqGbsp6W0NCKTQX4/IGJxQIlWlMmTq++5CQX2EZnYt83Z9Iu
b9ZlHIuZT/fquZmsPkrO0AyrQ3tY+vsCJWi5j6VSXvSTQS4DO20FtBKZR/WRyd9W
v5NtkoSHSqA0+eiBaH34WYUtB7HROZee1uvPDcTXjlsil8FgIyxU1G2PNEGPAY0t
VNg7J9Dw7yNJieqDyph0uGlEWVzWNbYZi4K8CDuBmlROMzpHM8GjKkobLWxkDtc4
M3ki8my9pE77li8GLA8z/oztZ2o1vhJCVskMvMjO9nIoWhXyg/aO3blO7yRSS93K
HjhM5hIDdBWjKgLhI96ndu0VxxYWYdCL9u0o9Z15+pz4Chn2mQyABDiE6fuwLFZS
wujnWzOYhXZscIGIirxTQWz89al7jIwYh5DD1qwnCD2TJEzZhEly1QwkY0NO/hRq
f2qdZpAmMdTsmG9VQ6zfjQdk/U9vSDsV/TjRlOAKReTf7ypRsCY=
=GpAf
-----END PGP SIGNATURE-----

--L4CwaLgsABUF8aLi2zJ9byztBBC8ne0dz--

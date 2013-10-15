Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 15 Oct 2013 16:04:31 +0800
Message-ID: <3449342.7k6WirsOky@diderot>
In-Reply-To: <1379088490-2693-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1379088490-2693-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3484062.n3IY0qeaPt";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: generalize batman-adv icmp
	packet handling
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


--nextPart3484062.n3IY0qeaPt
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 13 September 2013 18:08:10 Simon Wunderlich wrote:
> +/**
> + * batadv_socket_receive_packet - schedule an icmp packet to be sent to
> userspace + *  on an icmp socket.
> + * @socket_client: the socket this packet belongs to
> + * @icmph: pointer to the header of the icmp packet
> + * @icmp_len: total length of the icmp packet
> + */
>  static void batadv_socket_add_packet(struct batadv_socket_client
> *socket_client, -				     struct batadv_icmp_packet_rr 
*icmp_packet,
> +				     struct batadv_icmp_header *icmph,
>  				     size_t icmp_len)
>  {
>  	struct batadv_socket_packet *socket_packet;
> +	size_t len;
> 
>  	socket_packet = kmalloc(sizeof(*socket_packet), GFP_ATOMIC);
> 
>  	if (!socket_packet)
>  		return;
> 
> +	len = icmp_len;
> +	/* check the maximum length before filling the buffer */
> +	if (len > sizeof(socket_packet->icmp_packet))
> +		len = sizeof(socket_packet->icmp_packet);
> +
>  	INIT_LIST_HEAD(&socket_packet->list);
> -	memcpy(&socket_packet->icmp_packet, icmp_packet, icmp_len);
> +	memcpy(&socket_packet->icmp_packet, icmph, icmp_len);

Shouldn't "len" be used here ?

Besides, if we make everything generic batadv_socket_packet->icmp_packet 
should not be hard-coded to batadv_icmp_packet_rr but the largest available 
ICMP packet type ?


> +/**
> + * batadv_recv_my_icmp_packet - receive an icmp packet locally
> + * @bat_priv: the bat priv with all the soft interface information
> + * @skb: icmp packet to process
> + *
> + * Returns NET_RX_SUCCESS if the packet has been consumed or NET_RX_DROP
> + * otherwise.
> + */
>  static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
> -				      struct sk_buff *skb, size_t icmp_len)
> +				      struct sk_buff *skb)
>  {
>  	struct batadv_hard_iface *primary_if = NULL;
>  	struct batadv_orig_node *orig_node = NULL;
> -	struct batadv_icmp_packet_rr *icmp_packet;
> +	struct batadv_icmp_header *icmph;
>  	int ret = NET_RX_DROP;
> 
> -	icmp_packet = (struct batadv_icmp_packet_rr *)skb->data;
> +	icmph = (struct batadv_icmp_header *)skb->data;
> 
>  	/* add data to device queue */
> -	if (icmp_packet->icmph.msg_type != BATADV_ECHO_REQUEST) {
> -		batadv_socket_receive_packet(icmp_packet, icmp_len);
> +	if (icmph->msg_type != BATADV_ECHO_REQUEST) {
> +		if (skb_linearize(skb) < 0)
> +			goto out;
> +
> +		batadv_socket_receive_packet(icmph, skb->len);
>  		goto out;
>  	}

Wouldn't it be better to dump unkown icmp types for us instead of copying 
everything to user space ?

Same is true for batadv_socket_write(). We should use the icmp header and not 
assume icmp echo.

Cheers,
Marek

--nextPart3484062.n3IY0qeaPt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSXPcTAAoJEFNVTo/uthzAcf4H/3qtIaiH1x4xkQ4pt7zdNv6M
E3FPNLQeHfRG4uYPBxEobhwH5fQ60eRHaCxt5Ba95IwUVmnLBxLqpyubE3ZAhIxo
VmSPQebNgZTZvJTZMGyRnYCvtJOhlKhLLbN6Rr/lrTd/RfeazJz0qNUTU5nh8T64
Mo2hYnEbrjYORRCcKwcqHxq/NWDOifjOKdFLYRq8OJhpNAlpc+rWpY/85fp9PTUd
6j5H8hf2CuijqqRxFeBALm2vO9jOc97scwOlBdlCyBpZSmKlTTn8XkPjPoAVG9Xy
m1xuO1iZC1lxNml7ZQB2BRSgW0ss5Q98F74FMliE9wGCKUBBeaYWojJp6CqAW84=
=XBi1
-----END PGP SIGNATURE-----

--nextPart3484062.n3IY0qeaPt--


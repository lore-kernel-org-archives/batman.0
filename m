Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 23 Jan 2011 03:52:31 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20110123025231.GA15942@pandem0nium>
References: <1295659302-7171-1-git-send-email-linus.luessing@saxnet.de>
	<1295659302-7171-8-git-send-email-linus.luessing@saxnet.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <1295659302-7171-8-git-send-email-linus.luessing@saxnet.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 07/19] batman-adv: Prepare and send
	own	multicast tracker packets
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


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

found one more thing which will break packet sending, please see inline:

On Sat, Jan 22, 2011 at 02:21:30AM +0100, Linus L=C3=BCssing wrote:
> [...]
> +/**
> + * Sends (splitted parts of) a multicast tracker packet on the according
> + * interfaces.
> + *
> + * @tracker_packet:	A compact multicast tracker packet with all groups a=
nd
> + *			destinations attached.
> + */
> +void route_mcast_tracker_packet(
> +			struct mcast_tracker_packet *tracker_packet,
> +			int tracker_packet_len, struct bat_priv *bat_priv)
> +{
> +	struct dest_entries_list next_hops, *tmp;
> +	struct mcast_tracker_packet *next_hop_tracker_packets,
> +				    *next_hop_tracker_packet;
> +	struct dest_entries_list *next_hop;
> +	struct sk_buff *skb;
> +	int num_next_hops, i;
> +	int *tracker_packet_lengths;
> +
> +	rcu_read_lock();
> +	num_next_hops =3D tracker_next_hops(tracker_packet, &next_hops,
> +					  bat_priv);
> +	if (!num_next_hops)
> +		goto out;
> +	next_hop_tracker_packets =3D kmalloc(tracker_packet_len * num_next_hops,
> +					   GFP_ATOMIC);
> +	if (!next_hop_tracker_packets)
> +		goto free;
> +
> +	tracker_packet_lengths =3D kmalloc(num_next_hops * sizeof(int),
> +					  GFP_ATOMIC);
> +	if (!tracker_packet_lengths)
> +		goto free2;
> +
> +	i =3D 0;
> +	list_for_each_entry_safe(next_hop, tmp, &next_hops.list, list) {
> +		next_hop_tracker_packet =3D (struct mcast_tracker_packet *)
> +					  ((char *)next_hop_tracker_packets +
> +					   i * tracker_packet_len);
> +		memcpy(next_hop_tracker_packet, tracker_packet,
> +		       tracker_packet_len);
> +		zero_tracker_packet(next_hop_tracker_packet, next_hop->dest,
> +				    bat_priv);
> +		tracker_packet_lengths[i] =3D shrink_tracker_packet(
> +				next_hop_tracker_packet, tracker_packet_len);
> +		i++;
> +	}
> +
> +	i =3D 0;
> +	/* Add ethernet header, send 'em! */
> +	list_for_each_entry_safe(next_hop, tmp, &next_hops.list, list) {
> +		if (tracker_packet_lengths[i] =3D=3D
> +		    sizeof(struct mcast_tracker_packet))
> +			goto skip_send;
> +
> +		skb =3D build_tracker_packet_skb(&next_hop_tracker_packets[i],

Don't use next_hop_tracker_packets[i]! This will give you a wrong
pointer, because the base is "sizeof(struct mcast_tracker_packet)"=20
and not "tracker_packet_len". Instead, please use a=20
"next_hop_tracker_packet" construct like in the loop above.

(BTW, i think you could merge the two loops and skip the array=20
"tracker_packet_lengths" for keeping the lengths, i think ...)

> +					       tracker_packet_lengths[i],
> +					       next_hop->dest);
> +		if (skb)
> +			send_skb_packet(skb, next_hop->batman_if,
> +					next_hop->dest);
> +skip_send:
> +		list_del(&next_hop->list);
> +		kfree(next_hop);
> +		i++;
> +	}
> +

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk07l+8ACgkQrzg/fFk7axa9MACdHhwFfdKLlC1lrZFjN7oPsn7n
pjoAoLthP69s1kGhxytIi3rhQ7pCBAAS
=l12R
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--

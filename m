Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 28 Feb 2016 07:36:40 +0100
Message-ID: <2655547.V2kIYkZTyH@sven-edge>
In-Reply-To: <10633463.PgZ4eD0ZeI@voltaire>
References: <b.a.t.m.a.n@lists.open-mesh.org>
 <1456505773-1059-1-git-send-email-sven@narfation.org>
 <10633463.PgZ4eD0ZeI@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1734318.6Fs0AlEuv5";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Check skb size before using
	encapsulated ETH+VLAN header
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

--nextPart1734318.6Fs0AlEuv5
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 28 February 2016 08:49:02 Marek Lindner wrote:
> On Friday, February 26, 2016 17:56:13 Sven Eckelmann wrote:
> > --- a/net/batman-adv/soft-interface.c
> > +++ b/net/batman-adv/soft-interface.c
> > @@ -408,11 +408,17 @@ void batadv_interface_rx(struct net_device
> > *soft_iface, */
> > 
> >  	nf_reset(skb);
> > 
> > +	if (unlikely(!pskb_may_pull(skb, ETH_HLEN)))
> > +		goto dropped;
> > +
> > 
> >  	vid = batadv_get_vid(skb, 0);
> 
> batadv_get_vid() also calls pskb_may_pull() and checks for VLAN_ETH_HLEN
> length. Isn't that sufficient ?

No, because it doesn't signal the result of pskb_may_pull back to this 
function. At least not in a way that the _rx function drops the packet on an 
error.

> On a related note - a few lines before your check you'll find:
> 
> /* check if enough space is available for pulling, and pull */
> if (!pskb_may_pull(skb, hdr_size))

This only includes the the unicast/unicast_4addr/bcast batman-adv header. It 
doesn't check the size of the encapsulated data (this also means *not* the 
encapsulated ethernet header)

> 
> In its current form that check is useless because
> batadv_recv_unicast_packet() already calls batadv_check_unicast_packet()
> which does the same
> pskb_may_pull(skb, hdr_size). Am I overlooking something ?

Looks like it also only checks the size of the batman-adv header and the 
content of the outer (not the encapsulated) ethernet header.

> 
> >  	switch (ntohs(ethhdr->h_proto)) {
> > 
> >  	case ETH_P_8021Q:
> > +		if (!pskb_may_pull(skb, VLAN_ETH_HLEN))
> > +			goto dropped;
> 
> Shouldn't this memory access be covered by the earlier check inside
> batadv_get_vid() ?

Nope, no drop of the packet when the may_pull in batadv_get_vid fails.

> 
> >  	/* skb->dev & skb->pkt_type are set here */
> > 
> > -	if (unlikely(!pskb_may_pull(skb, ETH_HLEN)))
> > -		goto dropped;
> 
> Agreed that this seems unnecessary.


At least it is too late :)

Please check my statements twice. Maybe I've overlooked something.

Kind regards,
	Sven

--nextPart1734318.6Fs0AlEuv5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW0pV4AAoJEF2HCgfBJntGktcP/1uzO4AplNaaYNkT9iMAnw+O
eUMTWulBEpMaZkcCHU6mqJTmD5fhYNG6DfTTnK1BaqaAbh7kVyS6WZlFrmQwgqrw
2ltctfbvnoxHA5RAFs7/BNEDthcPhvQ1JcDE8Ctoy9bhfkEO0ND6dkY6pY5WeeP1
Ryexw55xulpgqV8i+GJTQLSOwnhqr6pBlVsibIdr21POos5PjLHM73YbriV/M8sp
ux/8LigHTUIU8vyiFGiu2VKpwwJh9gDif984wKIR+EUr2xpWU/1jzbCzKbJOgKsS
G5VSKanldBIGO1bt2sDQNL2pXdROITJ5/AZZj4pxZm0AwgBKR2t4dXd6qPbN6RpL
FMf5qafO/+OYaP81CZX1DPvgKOPNN+0/IMssyTL/c3qt1zCRUPBrcQZmNDIvk4pP
bUnanrWbUv9rLJV2z/ciSUKl38KVEqFjHYBR21sjh8ioOovdccbr8vjtLJ1AFrah
gRDgE/tdQG1cmTim1HHhq1VsoMN4UrJLkAbVfv3abxJcsgOk0Ic5SpH+Y1N0g6k2
ff/NbSXZ+cLQQFBZh36WI15kEjbfItwqpxdyjXGm2Pmrl1UDS7g6YM+ou3BGrwpf
QT5kmLo7urUJ1HehVZyOcM/ltFNIUn/Z22k/OZUfZ9ABsM3MBcXlRXvpdJ4Wt7lE
OTztryIGDbL4NMuP+Vrs
=5aRp
-----END PGP SIGNATURE-----

--nextPart1734318.6Fs0AlEuv5--


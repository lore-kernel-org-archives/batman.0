Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 26 Feb 2016 17:00:49 +0100
Message-ID: <2502138.exi8rd1dt9@bentobox>
In-Reply-To: <1456492697-29708-1-git-send-email-apape@phoenixcontact.com>
References: <1456492697-29708-1-git-send-email-apape@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8639231.kb0ti4DAuP";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/7] batman-adv: speed up dat by
	snooping received ip traffic
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

--nextPart8639231.kb0ti4DAuP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 26 February 2016 14:18:17 Andreas Pape wrote:
> Speeding up dat address lookup is achieved by snooping all incoming ip
> traffic. This especially increases the propability in bla setups that
> a gateway into a common backbone network already has a fitting dat entry
> to answer incoming ARP requests directly coming from the backbone
> network thus further reducing ARP traffic in the mesh.
> 
> Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
> ---
[...]
>  	switch (ntohs(ethhdr->h_proto)) {
> +	case ETH_P_IP:
> +		iphdr = (struct iphdr *)(skb->data + ETH_HLEN);
> +		/* snoop incoming traffic for dat update using the source mac
> +		 * and source ip to speed up dat.
> +		 */
> +		batadv_dat_entry_check(bat_priv, iphdr->saddr,
> +				       ethhdr->h_source, vid);
> +		break;
>  	case ETH_P_8021Q:
>  		vhdr = (struct vlan_ethhdr *)skb->data;
> 
> -		if (vhdr->h_vlan_encapsulated_proto != ethertype)
> +		if (vhdr->h_vlan_encapsulated_proto != ethertype) {
> +			/* snoop incoming traffic for dat update also for vlan
> +			 * tagged frames.
> +			 */
> +			if (vhdr->h_vlan_encapsulated_proto == ETH_P_IP) {
> +				iphdr = (struct iphdr *)(vhdr +
> +						sizeof(struct vlan_ethhdr));
> +				batadv_dat_entry_check(bat_priv, iphdr->saddr,
> +						       vhdr->h_source, vid);
> +			}

Where is the code to check that there is enough data for the iphdr 
(pskb_may_pull)? Same question goes to Marek for his initial change in 
48628bb9419f ("batman-adv: softif bridge loop avoidance") that introduced the 
vhdr->vlan_ethhdr check

Kind regards,
	Sven
--nextPart8639231.kb0ti4DAuP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW0HaxAAoJEF2HCgfBJntGnNsQAJxU3pifZBkIheRpbjGHN/f2
/K9IqokxC/KUgjLaoSyCDcBllny2d0YYcR1tpGiUwFvdAR7STyHr2N4ZMsAXfU/1
wtAaS/T5BnzXsIsKSlHyzftaG4xIYCrscrxgRKCS6kRqa3zgglMjFQzGvpNdsqXl
BYNa0gRAloMmRiLwuc3u+BGyI+XOjvpUCZEsyilF9l78GIcP1/9NKGHnNrdKCaee
xIf1KCTt2zzKWSb6KhR9Z+xXOBuDhh46VkMb/l2OdUSjb4YCkI/1W8HYKnbOmoLW
x+j9pdeoc2bghzZYhqvW01W1ghEeHorvSH2KQyEnvqKqHomN7NhtHKgyTPlhZmLL
U+G1C+Jw/4404iJsjOMOHjJ7T3FJ5zsD1pnYWmabsyWytHQK7pKxdnatcntN/XVB
d9ua0E+SayB0uHmIjiBtWizwRnB6eLRCMzH1NkiUYJ2QXHeXoBfsqnM/24B/0Hg5
bIc4ivx04NLKzxUcihcEj+L09KxXsARUv2xnef9t22F1YIjbEZSZWEQTziltY2do
Nf/DVlh8XoOmcTzZtWIMK1SZEW4Ke2uvNr2g8+6PVxgm1qq2JCDJbsGCkK/jCDqU
cuWFT7c6MMoytUwaBiCmNlPkOZUs9WcRgElPiOERE7yxNY9mwrgJmdLXphMj//uN
SfNFs/FnaRbgak1ph9sh
=SlhW
-----END PGP SIGNATURE-----

--nextPart8639231.kb0ti4DAuP--


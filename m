Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 22 Jun 2014 17:21:40 +0800
Message-ID: <1676388.QilV9dKt8E@diderot>
In-Reply-To: <201406211657.42780.sw@simonwunderlich.de>
References: <1402650950-5886-1-git-send-email-sw@simonwunderlich.de>
 <2808362.GMTcl9ijMO@diderot> <201406211657.42780.sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1564490.3Nm4sW1Ihh";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: drop QinQ claim frames in
	bridge loop avoidance
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


--nextPart1564490.3Nm4sW1Ihh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 21 June 2014 16:57:42 Simon Wunderlich wrote:
> > Looks like copy & paste from batadv_bla_process_claim() ? How about using
> > a
> > shared function ?
> 
> Yeah, it's copy and pasted. The only thing which we could put into a common 
> function are the 4 checks, the local variables are used in a different way
> for the further code in each function. This didn't really look worth it so
> I didn't bother to refactor in that patch, if you feel otherwise let me
> know and i'll refactor in v2.

How about moving the while loop into batadv_bla_process_claim() itself ?

Something like:

	if (vid & BATADV_VLAN_HAS_TAG) {
		vhdr = vlan_eth_hdr(skb);
		proto = vhdr->h_vlan_encapsulated_proto;
		headlen += VLAN_HLEN;
	}

	if (proto == htons(ETH_P_8021Q)) {
		do {
			vhdr_ptr = skb_header_pointer(skb, headlen, VLAN_HLEN, &vhdr);
			if (!vhdr_ptr)
				return 0;

			headlen += VLAN_HLEN;

		} while (vhdr_ptr->h_vlan_encapsulated_proto == htons(ETH_P_8021Q));

		proto = vhdr->h_vlan_encapsulated_proto;
	}

	if (proto != htons(ETH_P_ARP))
		return 0; /* not a claim frame */

Towards the BLA claim check you can then check whether this BLA frame was 
encapsulated more than once (through a local variable).

Cheers,
Marek

--nextPart1564490.3Nm4sW1Ihh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJTpqAsAAoJEFNVTo/uthzABAEH/08JzbiQvueipOQwPJcj+R1f
dQ0ebWBbFUdWlEAPH5TxDM01qzPcLtpQkCnZxBEHdh6UCyVzr79vqOzndnkC8J0Z
mZi0woxX3xA6ccXkzFHSTNy5VNxZSWskICr1M/DJL/F11uJgWUpDJ8/Pj93pTP6T
sm/+IhnWjFxC6w6CPKiVIPRiT07yG7RWxPhQF7rKO01jyKjaQzP8fa0oik1KmUYs
w/JMhJDb18jGjooruV3YQ295ODFaZmiyTgF3loart4zEuqV0mGUnUpM9EcTC1tCV
z1ErAhqieuWZGefuc0zC0/FqCjEfcqL71mlrln1n1I1EvqSRid2+z1urNRqj5uM=
=v7KH
-----END PGP SIGNATURE-----

--nextPart1564490.3Nm4sW1Ihh--


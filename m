Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 19 Mar 2018 14:14:04 +0100
Message-ID: <6825317.Bh3rAZBzc7@bentobox>
In-Reply-To: <b50d17c8-e55f-6a05-88db-acdcc4c35732@universe-factory.net>
References: <20180318121201.29052-1-sven@narfation.org>
 <b50d17c8-e55f-6a05-88db-acdcc4c35732@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart19020918.GZbzBcJEOC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix skbuff rcsum on packet
 reroute
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart19020918.GZbzBcJEOC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Montag, 19. M=E4rz 2018 14:02:43 CET Matthias Schiffer wrote:
> Using skb_postpull_rcsum here is incorrect: As the name indicates, it is
> supposed to be used after pulling, and will thus subtract the checksum of
> the header *before* skb->data, while we are interested in the
> sizeof(*unicast_packet) bytes *after* skb->data.

Can you please explain this a little bit further. You give skb_postpull_rcs=
um=20
the start and length via parameter and it is writing the resulting csum in =
the
skb. It is not checking or accessing the position of skb->data [1]

    /**
     *	skb_postpull_rcsum - update checksum for received skb after pull
     *	@skb: buffer to update
     *	@start: start of data before pull
     *	@len: length of data pulled
     *
     *	After doing a pull on a received packet, you need to call this to
     *	update the CHECKSUM_COMPLETE checksum, or set ip_summed to
     *	CHECKSUM_NONE so that it can be recomputed from scratch.
     */

See also __skb_postpull_rcsum [2]:

		skb->csum =3D csum_block_sub(skb->csum,
					   csum_partial(start, len, 0), off);

What about the examples I gave in my patch - for example the easy-to-read=20
set_eth_addr [3]?

Kind regards,
	Sven

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/include/linux/skbuff.h?id=3Dc698ca5278934c0ae32297a8725ced2e27585d7f#n3070
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/include/linux/skbuff.h?id=3Dc698ca5278934c0ae32297a8725ced2e27585d7f#n3058
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/net/openvswitch/actions.c?id=3Dc698ca5278934c0ae32297a8725ced2e27585d7f#n3=
19
--nextPart19020918.GZbzBcJEOC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlqvt5wACgkQXYcKB8Em
e0ba4RAAhqGh2T9V39US9aI328mdSoap5BDl9ZT3PzCSYte+afEx39iwk0ki2TWe
iN8tjTD70fBwpUjPtJpdALtm+juc9LMTPFSxHcimmJJ7MSaDhrjeD7XY+wN84ROl
pt4XZD8ufUHItp3WEZZ7hYNiRju/h178q4jNeqoPBAbqs4b+sk/J7SBH8rQ6cI+3
X6qPsK/WzAN6Ql7ECqWWLEnHpYyMTgN5865SxfJ3SB2vAyA1slrvVs3q2bPkVr40
1a5Gsgtsdbn3B2GnJW7xes7NXSTsgu/uEe67ziGX/qh8I9ZOgpz49BaToIPsJeq5
gKu1guKN0DEZco3Dm4pWtjhQzvpMC8uxHFih+PGk8lilqM3mms+l4zDmZXTwX39Q
v0TR/uxvdhk7juvS7CqV/gxcqz4DGHZgTWyWc8Xm7hTJtcp/z99N20hHHsLjQuMN
zsMdPV5PvgPR8kQWFeW+yAGFok4SIunwpuuTssnxlrJH2D/m9XTo0KQB3DfP81O4
ga3R379jIdeDJw4GjkX3DA8dXlZ5vVYh7zdZyDOoMSY28Xj9XnPrb5P+rl8aQhyr
7e1dNiUhrSNyLaEAf00nEwniwaIRZ6pmk3l3iAMmFq6K4GoKHyMV9G6vN8xK1PCA
CWCiNFxjYlVI4BPTU0PNJbNjfjHxlPOjTIkRHairIwxymkHndqs=
=AcpT
-----END PGP SIGNATURE-----

--nextPart19020918.GZbzBcJEOC--


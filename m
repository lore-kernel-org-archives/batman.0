Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 21 Feb 2017 18:28:35 +0100
Message-ID: <3561262.vdVOCJ3LT9@bentobox>
In-Reply-To: <20170212102634.6279-1-sven@narfation.org>
References: <20170212102634.6279-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1873494.43aJmcFi8j";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 1/2] batman-adv: Fix double free
	during fragment merge error
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
Cc: Martin =?ISO-8859-1?Q?Hundeb=F8ll?= <martin@hundeboll.net>

--nextPart1873494.43aJmcFi8j
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sonntag, 12. Februar 2017 11:26:33 CET Sven Eckelmann wrote:
> The function batadv_frag_skb_buffer was supposed not to consume the skbuff
> on errors. This was followed in the helper function
> batadv_frag_insert_packet when the skb would potentially be inserted in the
> fragment queue. But it could happen that the next helper function
> batadv_frag_merge_packets would try to merge the fragments and fail. This
> results in a kfree_skb of all the enqueued fragments (including the just
> inserted one). batadv_recv_frag_packet would detect the error in
> batadv_frag_skb_buffer and try to free the skb again.
> 
> The behavior of batadv_frag_skb_buffer (and its helper
> batadv_frag_insert_packet) must therefore be changed to always consume the
> skbuff to have a common behavior and avoid the double kfree_skb.
> 
> Fixes: 9b3eab61754d ("batman-adv: Receive fragmented packets and merge")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied in e3bab02816097f860545d9ce9ae0808c69d7c92f [1].

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/e3bab02816097f860545d9ce9ae0808c69d7c92f
--nextPart1873494.43aJmcFi8j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAliseMMACgkQXYcKB8Em
e0buNBAApQb92jrF+Pi8s2e9kkCDJ0J5ByU4M8flkIEZ6Ny6jI21jYVgjB2OmEFq
9s5nJkd97J1lZQBhugSJ+/NAB2qscRHsUIhwrBSYstMvFXE1n7T1kz5AuxPDIrX3
hGZQ1W+u8a28i0T/gayi9C6ILvdMUe8gjKbSI1EoAl3iRw/RMnrrTpPCEzY5xLbQ
kzmgF4woNQmbxaAaOHxuVvCW/zkC66eN7c4HqZN4F69HckU8Y4BGfkoMyK5E675Q
+t0sp32PcLu+Y8EHzPwqxpVgyS8oc6u42YaTA/+l6p0yS4nl5BVJagufXjnqvdlz
wwJm9Wh06ieKyH4Tx3+YGRs4vzqCN3+34KXkb6EUdA/mz6LRyBlqjUXiPRJ3G5b7
QHpQLIRyBZ7TudfkOf6qX4QugL4+uHNeV2wUKUWdqCrPgLPeEKW5j1EPg1nfj9fd
tp88/M8VlgYiJj41c87QXf1TaySZmoFKwWc4zfshDLQvyFJu6tZtUMhyTa5+reqr
dXzbLHyJAfIKSYKOpT1gOAZOmvLAnYT8zVkNfP19OLdu0KSbTbaSlQnzUzc63QC8
Arjt3WMAaq3UhLVXDAgMi7+vg1Ul5yJCcKf+oNlGNb/VCNqWrFbo1q1hLAe/PN1s
EPatR30otz/zQdzrbSB3wDdXxikbeETGJPiftcl5oo6XgKEf8aY=
=LIMC
-----END PGP SIGNATURE-----

--nextPart1873494.43aJmcFi8j--


Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 23 Dec 2013 20:19:03 +0800
Message-ID: <1751590.9Lpm3OFviJ@diderot>
In-Reply-To: <1387758485-3568-2-git-send-email-antonio@meshcoding.com>
References: <1387758485-3568-1-git-send-email-antonio@meshcoding.com>
 <1387758485-3568-2-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2191759.g7ty2D73jD";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 2/2] batman-adv: clean nf state
	when removing protocol header
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart2191759.g7ty2D73jD
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 23 December 2013 01:28:05 Antonio Quartulli wrote:
> If an interface enslaved into batman-adv is a bridge (or a
> virtual interface built on top of a bridge) the nf_bridge
> member of the skbs reaching the soft-interface is filled
> with the state about "netfilter bridge" operations.
> 
> Then, if one of such skbs is locally delivered, the nf_bridge
> member should be cleaned up to avoid that the old state
> could mess up with other "netfilter bridge" operations when
> entering a second bridge.
> This is needed because batman-adv is an encapsulation
> protocol.
> 
> However at the moment skb->nf_bridge is not released at all
> leading to bogus "netfilter bridge" behaviours.
> 
> Fix this by cleaning the netfilter state of the skb before
> it gets delivered to the upper layer in interface_rx().
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  soft-interface.c | 5 +++++
>  1 file changed, 5 insertions(+)

Applied in revision 1356028.

Thanks,
Marek

--nextPart2191759.g7ty2D73jD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSuCo3AAoJEFNVTo/uthzATr8H/iZhpyKrzhZ68LxBAQy/8cEp
ec6ROJ6xh0gafoHXACA5kTgDaaW6buPfbUBY454cuDjmwwqhKsj5+lkc237ribt9
q7xhytB7W96at+9mf6szbFg3aiGxwI7h47lSalUIyQ2mY/f5w4aebsETpYNFzaQU
nIiRNbmfpT2Ztu5FR/33omcVCeK36l+n7X5yT7qUKwKbQtXO9kwv43bF1490Q7l1
0OYyGhouCB2iW6e9fTJUEsLina5O2fe9vnw0KrWJNql3IM9NDKzu1q2NWjk9eVVM
pjIEe64oQaj1Y/RaMDhQ8epQywJ+Qp7tJ3Mm4bCgGYrAsyJFbtSkRuNl1OXVT9A=
=0PiM
-----END PGP SIGNATURE-----

--nextPart2191759.g7ty2D73jD--


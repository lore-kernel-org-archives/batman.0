Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 24 Nov 2013 00:35:17 +0800
Message-ID: <3008590.CHRxIxEvmE@diderot>
In-Reply-To: <1385121727-12847-2-git-send-email-sw@simonwunderlich.de>
References: <1385121727-12847-1-git-send-email-sw@simonwunderlich.de>
 <1385121727-12847-2-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4813572.o30rB3eIQI";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: fix orig_node multiif
	regression in network coding
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
Cc: Simon Wunderlich <simon@open-mesh.com>


--nextPart4813572.o30rB3eIQI
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 22 November 2013 13:02:07 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> A previous commit for the multi interface optimization did not
> change the member access for orig_node to their respective new ifinfo
> structures for the network coding implementation.
> 
> This was introduced by change de6bcc76ea84fecb136f8c8f5ba1862e4a13f06b
> ("batman-adv: split out router from orig_node")
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
>  network-coding.c |   16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)

Applied in revision d078de3.

Thanks,
Marek

--nextPart4813572.o30rB3eIQI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSkNlFAAoJEFNVTo/uthzAucYIAKQYHFEjcHm1CYZkBgcCshN0
1UuewUJOJ1v7i9Xirk8kNJ1Y9XGlDhZjv4sEdmBdu8GJ665yzcDDz5eMOX2kmrNA
nBA4w9niu8WfrNl+aZaInu4pfTq91jpmEO9m1k41p7lD2lEwgK8deLQ63PcI7oUv
I4iUygzOujLJ6gq43fOK7aalarvuxS7bSGoZvc3L0eTaDtknK+JssMFzS2sbz7zh
mbsJ0q/Svv3jpgzaRk4h6wLh8yWkoMREIs2LKCsGs4GIg0YserDWaAVSSgN/VrZn
V3zo22G4lcYtfUCR2yt5nj5psh59Fx1i0LdECafSvojK/+O5WiheFE1OLqo+ZiA=
=xuAY
-----END PGP SIGNATURE-----

--nextPart4813572.o30rB3eIQI--


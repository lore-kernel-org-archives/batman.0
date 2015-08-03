Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 04 Aug 2015 03:59:22 +0800
Message-ID: <1652760.0jMUkvcHug@voltaire>
In-Reply-To: <3503158.kbfCh64iFS@prime>
References: <1437857863-28742-1-git-send-email-mareklindner@neomailbox.ch>
 <3503158.kbfCh64iFS@prime>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2737905.GR4LfBPi55";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: move neigh_node list add
	into batadv_neigh_node_new()
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


--nextPart2737905.GR4LfBPi55
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, August 03, 2015 20:00:42 Simon Wunderlich wrote:
> Signed by sw@simonwunderlich.de.	Show Details
> 
> On Sunday 26 July 2015 04:57:43 Marek Lindner wrote:
> > All batadv_neigh_node_* functions expect the neigh_node list item to be
> > part of the orig_node->neigh_list, therefore the constructor of said list
> > item should be adding the newly created neigh_node to the respective
> > list.>
> > 
> >
> > Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> 
> Acked-by: Simon Wunderlich <sw@simonwunderlich.de>

Applied in revision c214ebe.

Regards,
Marek

--nextPart2737905.GR4LfBPi55
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVv8ghAAoJEFNVTo/uthzA39YH/1f4aDUHawpFfXCY1UqLz6zR
d7sqTPCW77XPYW68IBChcveu7933Gl5ivYXBaA5X7AlrSFCtGKjZhrleCet0Dc+S
eH6gF4Xdza3z903MthJpjQzqG1KTMnVDwB10SzE9BCNJ8e6/Plv9lZX1cu3ON/yO
mNim97O6/7vUkgEIRI/0po0Cv3XVL/rAe943O/dpTWVNXJZZgNJMnBJJY0CEH1Kk
vGKNpVLaELpeS57/yfcBFExoxy8NdMFOcqGy2jdBUw1hf+9H1CVvHAKiEZD5UvA7
r5aye3mIIB4964JbKDf1PkWzQi9qqPQnVZLv17zrQesiOM9FoWqd3rCbAo9s78A=
=025N
-----END PGP SIGNATURE-----

--nextPart2737905.GR4LfBPi55--


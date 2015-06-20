Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 20 Jun 2015 18:14:16 +0800
Message-ID: <2965545.uDBilNAQQ0@voltaire>
In-Reply-To: <1847613.Lr5mR0jfaA@sven-edge>
References: <1434721827-4935-1-git-send-email-mareklindner@neomailbox.ch>
 <1847613.Lr5mR0jfaA@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7211118.GMLtev6dXd";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: protect tt request from
	double deletion
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


--nextPart7211118.GMLtev6dXd
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, June 20, 2015 10:26:31 Sven Eckelmann wrote:
> On Friday 19 June 2015 21:50:27 Marek Lindner wrote:
> > The list_del() call was changed to hlist_del_init() to allow
> > take advantage of the hlist_unhashed() check prior to deletion
> > in batadv_tt_req_node_new().
> >
> > 
> >
> > Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> > ---
> > v2: removed redundant hlist_unhashed() check & reword commit message
> 
> list_del_init would also work. It is not necessary to switch to hlists for 
> this feature. It is not possible with RCU but this is not used here.

I am aware of that fact. Still, I'd like to convert the list to hlist. If you 
prefer I can do this in 2 steps (first changing to list_del_init() and then 
changing everything to hlist).


Cheers,
Marek

--nextPart7211118.GMLtev6dXd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVhTz4AAoJEFNVTo/uthzA0JAIAMRI6JYp0nOdcQFwKeH+yLhg
ZO+DOkurG64tJqtii64a/8cnugBA5GnT2jLs7EhaNd9i6CIq1+JUBoIfPpb2wvxI
x610ikeBGnrvMmYj6EEKOi8TEWuNbGNilRQriSOwxH6min3TxWtjpOckdJz5bmaK
jpMwydiPwVxzsGhLbNKzXx8xnMnvv6Lm+CXop2eIw0BrlO5mdGVQUneL5I6tCi2F
lT7txt2GiFqlR/Kz2UswKC4W+VHn5v9HYn++jYtPhTtctuGOPjbUxFWpB2SjTA+w
EVWMFOGId9ebn+GbPUWFQq7dBKLe/YJ7YZOeQaokFUVnrUfsFaLlnNXwuIRvEVc=
=JBLp
-----END PGP SIGNATURE-----

--nextPart7211118.GMLtev6dXd--


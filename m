Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 16 Jun 2015 22:12 +0800
Message-ID: <1987884.ZZQIqrk8nR@voltaire>
In-Reply-To: <1434460643-3681-6-git-send-email-linus.luessing@c0d3.blue>
References: <1434460643-3681-1-git-send-email-linus.luessing@c0d3.blue>
 <1434460643-3681-6-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2004533.5gfVRHcfjI";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 maint 5/5] batman-adv: Fix potential
	synchronization issues in mcast tvlv handler
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


--nextPart2004533.5gfVRHcfjI
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday, June 16, 2015 15:17:23 Linus L=FCssing wrote:
> +               /* flag checks above + mcast_handler_lock prevents th=
is */
> +               if (unlikely(!hlist_unhashed(node)))
> +                       BUG();
> +

I don't think this will work because hlist_unhashed() checks for node->=
pprev=20
being NULL or not. hlist_del_rcu() sets node->pprev to LIST_POISON2.

We could also use BUG_ON() for readability. Something like:

BUG_ON(node->pprev =3D=3D LIST_POISON2);

Though there are not many code sections working with LIST_POISON2 outsi=
de the=20
list handling code.

Cheers,
Marek

--nextPart2004533.5gfVRHcfjI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVgC64AAoJEFNVTo/uthzAW5kIAJkV8VyoEIqqG8PUZhz+y6mX
hDFmWAZZ5L0GqvuKhDabafhejfW8ieH4sCmVbK7dU+rF61XhFK5dAWcJZqaN6x1E
bgo96UuY9utXbKRppY2fiB5oIY+IqGr9a6U17ccQCJ/MuG0hLL1tdvkzaVWhURW2
/Z3LbJAcHIV9uN7S1OSjFDi7xi7Xt9Z/K+cUHiAG/7dIuvwiZWFIeECTqfxOhdwv
gimyKVB+u9aW1YNw+NIHalpiDk8Tsmjw7Nfpe7lpbhSCI3WP6VPfQPzIDbHOFviP
mgY6D7guCww2yhvXPEj/zTAAHK0sF2H6rzs1XFsm+yVkseaqHm56ELdnpyu8EgA=
=owK3
-----END PGP SIGNATURE-----

--nextPart2004533.5gfVRHcfjI--


Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 28 Jun 2015 22:11:21 +0800
Message-ID: <4978967.ff90mneJLc@voltaire>
In-Reply-To: <55883B64.1050201@meshcoding.com>
References: <1434904223-10227-1-git-send-email-mareklindner@neomailbox.ch>
 <1434904223-10227-2-git-send-email-mareklindner@neomailbox.ch>
 <55883B64.1050201@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2643720.fPxWrkEA7I";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: prevent potential hlist
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
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart2643720.fPxWrkEA7I
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, June 22, 2015 18:44:20 Antonio Quartulli wrote:
> On 21/06/15 18:30, Marek Lindner wrote:
> > The hlist_del_rcu() call in batadv_tt_global_size_mod() does not check
> > if the element still is part of the list prior to deletion. The atomic
> > list counter should prevent the worst but converting to
> > hlist_del_init_rcu() ensures the element can't be deleted more than
> > once.
> >
> > Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> 
> Acked-by: Antonio Quartulli <antonio@meshcoding.com>

Applied in revision 4729a33.

 
> However, as discussed offline after Sven's suggestion in ticket #217,
> the entire if-loop still needs to be protected with the vlan_list_lock
> and not just its body.

I'll take care of that in a separate patch.

Regards,
Marek

--nextPart2643720.fPxWrkEA7I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVkACJAAoJEFNVTo/uthzAydoIALCM3zPB5HDwvotJ9icTzFHm
0WXS8cg9OLR3Iv/vzf53Utu77C6VSeU4vdWuaKbgYPYYa/XBYQHqvIWgn333QBBN
D/W9590rnb9ekE5lUSqDgTu5QNr/hdynLJQ+kGGWUDfOhbJ2KjDnyS18IhlAMpxi
MOaOry40cjKlEgD0f/l8B4CExZ+JgHxv6tQQITN1h1kv3XLP61Zm1xFXe/SweuvO
pa4kJNhCVH8+FkttUePwFAZ2WYl3Vr8oCh4E61u3CNiom9nOpm63jopF4Z4hdcsl
1qWJ2RdkWS5XPcEaaN5u0PeMP8aueEML9zU2Z/Hoi3vZaJklq9un9P6fUujxku0=
=S4oj
-----END PGP SIGNATURE-----

--nextPart2643720.fPxWrkEA7I--


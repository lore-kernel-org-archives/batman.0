Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 19 Jun 2015 11:23:18 +0200
Message-ID: <1740986.1nN0tfpCTA@bentobox>
In-Reply-To: <1434697758-8399-1-git-send-email-mareklindner@neomailbox.ch>
References: <1434697758-8399-1-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1459983.ehCpvyd3ds";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: convert tt request list into
	hlist
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>


--nextPart1459983.ehCpvyd3ds
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 19 June 2015 15:09:18 Marek Lindner wrote:
> The tt request list does not require a double linked list, hence a
> conversion to hlist saves memory without losing functionality.
> 
> Also, the list_del() call was changed to hlist_del_init() to allow
> an adding an extra check prior to deletion in batadv_tt_req_node_new().
> 
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>

hlist_node is still double linked [1] (pprev is an "indirect" pointer to the
next pointer of the previous hlist_node in the list). The hlist_head is the
only one which has only one pointer. This is the reason why you can't add
things to the end of an hlist. But you can still add an hlist_node before
another hlist_node. This would be something which you could not do easily on a
"not double linked list"

Kind regards,
	Sven

[1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/linux/list.h?id=a54acb3a6f853e8394c4cb7b6a4d93c88f13eefd#n588

--nextPart1459983.ehCpvyd3ds
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVg9+IAAoJEF2HCgfBJntGec4QALCs3q3Xbp++YjJLw2fZbd/+
2nXkw3bUWeiNYJQY8Dz2l0rEv6lDdgug5ziffZ/sOCrOPYLDOd+ocYNTH1ppgnwt
AkfcVqZovlWHyG7DTkUOWY4EgvnKqUK2jNbVXinWdxLLAyMSud1MbZva6kDyjXpf
99FjjBlBQ6WPfnHYM1+3/AwVyCOVcifs4D7MD8uu5QxsgMpihQesnfH0RHXpz+2a
O28eEiFNbaLarH/nyDwx90qOcTiYEem6/NfdIOe4A5Hc46XeT4GOri67ZuwyldeC
sPbu66G7MVeDU+1UNT3xKP6Esw2ykC5WxvO55bruriM/rwpLBiH5p0JaSKaLUaqt
Z3Jbmd6FBS5U/AFrzVkgE5NgLTxB1RcjkI3fxDGJKzf7Fm6kUToWv0gfM48fn2ew
DCK1aLHdabpQ+R8nyKpMkfeD8XDb+diN/XprkGDpdpnl8wvYQJmzvBuUnwTgw+lt
HzeO4qdTuJmIw0UeLygEjl396Lzt1Xm5hr76YJGBwniSRoCiLFSWC9WLX2cGmHy/
j2v8cH9SALkEG/ZmGPFwAWxnrRiJhc8QEFT84XrKqqjV7wox64HR0hSVtsa7d4a7
1I5cZ8PWvfZUsXEaRDKsO49zqEnGBmrBRbkYtiM+EgntgZnX7nUMS1tvFzuJJ4pX
jy8EyT2o5WJYtiBLngLy
=Kc/0
-----END PGP SIGNATURE-----

--nextPart1459983.ehCpvyd3ds--


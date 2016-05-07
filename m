Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 08 May 2016 01:01:31 +0800
Message-ID: <1690340.pptNQMoULa@voltaire>
In-Reply-To: <572E1EE2.3060806@wifibot.com>
References: <572DF6E3.3030901@wifibot.com> <18515809.rdrhCmqhC3@voltaire>
 <572E1EE2.3060806@wifibot.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3126679.ZWQMq9sBmR";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] no able to switch routing algo to V ?
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

--nextPart3126679.ZWQMq9sBmR
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, May 07, 2016 18:59:14 contact wrote:
> I just updated I need to recompile and re-flash my nodes it takes 
> sometime, can you check please if all your patches are here ?
> 
> [..]
>
> Fast-forward
>   ...make-sure-ELP-OGM-orig-MAC-is-updated-on-.patch |  64 ++++++++++++
>   ...-adv-Avoid-duplicate-neigh_node-additions.patch |  89 +++++++++++++++++
> ...Avoid-nullptr-derefence-in-batadv_v_neigh.patch |  38 +++++++
> ...an-adv-Fix-refcnt-leak-in-batadv_v_neigh_.patch |  81 +++++++++++++++
> ...Fix-double-neigh_node_put-in-batadv_v_ogm.patch |  40 ++++++++
> ...initialize-ELP-orig-address-on-secondary-.patch | 110
> +++++++++++++++++++++

Looks good. However, comparing git revisions (as Sven suggested) is more 
precise than posting such logs.

Cheers,
Marek

--nextPart3126679.ZWQMq9sBmR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXLh9rAAoJEFNVTo/uthzAXrQH/3ZWYYOjwTfkhmuCux/x73Dx
vsI47YApt1TA2i/EWMdJz9R893/GjjZaKlGeDpmkV+t0yFFsgnkN80TDFLY5Xru5
CIM+Bb+EvCCPc5x1OuBOLqWGK+mGKOIvbSkLnlgnTKmeJC0rCzUj7GEnFgcNlJcC
aIH4Yg8LsBf10uaGa7I43KOgOg4A3CmKoQLQVS4qvaw9+qUlDzXjogFgpzvRTls4
R3gIdnR+OK/BE3KDWuVCFHXCLXMHG4lStXqHGy7KupHc6UBJqCEY0cRKqsfjIK9J
/vZH2u+jgVr3DxFJM70aEzOpOas5PGgrcL5q1sFssNHfWFg9BJUKEoYVRidPrds=
=QGTb
-----END PGP SIGNATURE-----

--nextPart3126679.ZWQMq9sBmR--


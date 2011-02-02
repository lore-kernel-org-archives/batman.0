Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 2 Feb 2011 22:42:46 +0100
References: <1296352379-1546-2-git-send-email-sven@narfation.org>
	<1296668238-19323-1-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1296668238-19323-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3355874.uxNevtXeFx";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201102022242.52008.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Re: batman-adv: Correct rcu refcounting
	for gw_node
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Linus =?iso-8859-1?q?L=FCssing?= <linus.luessing@ascom.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart3355874.uxNevtXeFx
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday 02 February 2011 18:37:18 Linus L=FCssing wrote:
> From: Sven Eckelmann <sven@narfation.org>
>=20
> Was:
> ---
> <TODO: write a long monologue about every problem we have or could have or
> maybe never had and would have when we not have it>
>=20
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>=20
> So after some more discussions with Marek and Sven, it looks like we
> have to use the rcu protected macros rcu_dereference() and
> rcu_assign_pointer() for the bat_priv->curr_gw and curr_gw->orig_node.
>=20
> Changes here also include moving the kref_get() from unicast_send_skb()
> into gw_get_selected(). The orig_node could have been freed already at
> the time the kref_get() was called in unicast_send_skb().
>=20
> Some things that are still not that clear to me:
>=20
> gw_election():
> * can the if-block before gw_deselect() be ommited, we had a nullpointer
>   check for curr_gw just a couple of lines before during the rcu-lock.

I thought that this if block should be moved to gw_select. And your gw_sele=
ct=20
still has the bug that the bat_priv->curr_gw isn't set to NULL when=20
new_gw_node is NULL.


> gw_deselet():
> * is the refcount at this time always 1 for gw_node, can the null
> pointer check + a rcu_dereference be ommited? (at least that's what
> it looks like when comparing to the rcuref.txt example)

Why can't it be NULL? And _always_ use rcu_dereference. What example tells =
you=20
that it isn't needed? None of the examples has any kind of rcu pointer in i=
t=20
(just el as pointer which is stored in a struct were the pointer inside the=
=20
struct is rcu protected).


> gw_get_selected():
> * Probably the orig_node's refcounting has to be made atomic, too?

This part is still a little bit ugly and I cannot give you an easy answer.=
=20
Just think about following:
 * Hash list is a bunch of rcu protected lists
 * pointer to originator is stored inside a bucket (list elements inside the
   hash)
 * hash bucket wants to get removed - call_rcu; reference count of the
   originator is decremented immediately
 * (!!!! lots of reordering of read and write commands inside the cpu!!!! -
    aren't we happy about the added complexity which tries to hide the memo=
ry
    latency?)
 * the originator was removed, the bucket which is removed in the call_rcu
   still points to the removed originator
 * a parallel running operation tries to find a originator, the rcu list
   iterator gets the to-be-deleted bucket to the originator
 * the pointer to the already removed originator inside the bucket is
   dereferenced, data is read/written -> Kernel Oops

Does this sound scary? At least it could be used in some horror movies (and=
 I=20
would watch them).

But that is the other problem I currently have with the state of batman-adv=
 in=20
trunk - and I think I forget to tell you about it after the release of=20
v2011.0.0.

So, a good idea would be the removal of the buckets for the hash. Usage of=
=20
"struct hlist_node" inside the hash elements should be a good starting poin=
t.=20
But think about the problem that the different hashes could have the same=20
element. So you need for each distinct hash an extra "struct hlist_node"=20
inside the element which should be part of the hash. The hash_add (and=20
related) functions don't get the actual pointer to the element, but the=20
pointer to the correct "struct hlist_node" inside the element/struct. The=20
comparison and hashing function would also receive "struct hlist_node" as=20
parameter and must get the pointer to the element using the container_of=20
macro.


> @@ -171,7 +172,7 @@ struct bat_priv {
>         struct delayed_work hna_work;
>         struct delayed_work orig_work;
>         struct delayed_work vis_work;
> -       struct gw_node *curr_gw;
> +       struct gw_node *curr_gw;        /* rcu protected pointer */
>         struct vis_info *my_vis_info;
>  };

Sry, but I have to say that: FAIL ;)

I think it should look that way:
> -       struct gw_node *curr_gw;
> +       struct gw_node __rcu *curr_gw;

Best regards,
	Sven

--nextPart3355874.uxNevtXeFx
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJNSc/ZAAoJEF2HCgfBJntGiKoQAIVWTHyow4qIzk9PU7T2xNE5
1HlsWNcO3AB8schKqqGGjLetZskit/qV5Ntuddj38tCV6xhIDr06WXGk6xh4yBhu
YZ3TA1SBtrDwv8FjvRfisqNPUVPYpcm0ZfVMVwQE18yQ/IEn4cHOhRs7u4QkSP9P
reuWygoB87m1MoZtL86v14Dtv1POGfVsaGuGk0dmf51adLv7O5uSggEq3EiIRBWj
D89HJLzfgOG5FYjQhDrlYizttV9dEYMPOLdWcuTn0VX0j9/rlpFEGIAEPvNcwUyq
EgrvyuTMgqHMi05B8UUi8g1NhdQHpivu8x7ieDZhAVZdY89mvJ+0EAJxiMVQ+7IO
6NnMDWvUl8blohZ+HzUiG86hc4unm73/RmN6ZxJO1eVoEBJbk5L/h2mgiaPQNgTH
f78oN6ANtGaBMkAeNRYAeZaxX33UPhm6yJw42FOJNhMDVIHqvy2dMquH+iEoJcgX
z2BpKVYq9z9CjZGsFjw0EdMUCwtHLWG5lY2PUJmb9QliCVQEyKxAkE5ZXNIn2Yz6
8pfRMu5GJSg6x63nKSPxX/xHeOb7nDnMZOyhZPt6yMMari01v0s6ZWEjs1d1HBMB
dfp9j1KguahaFwXvkg2Y6ke5nFHLe/JlHybnnboKNsOmXbmtW3DQhiLuTruOmbld
k/5Ks2J30CuSoL2DbT+u
=qLs0
-----END PGP SIGNATURE-----

--nextPart3355874.uxNevtXeFx--

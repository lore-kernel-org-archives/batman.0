Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 17 Jun 2015 18:41:29 +0800
Message-ID: <2830554.KUT0a7xqCK@voltaire>
In-Reply-To: <1434467426-4281-6-git-send-email-linus.luessing@c0d3.blue>
References: <1434467426-4281-1-git-send-email-linus.luessing@c0d3.blue>
 <1434467426-4281-6-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1778709.nplejUJ7Af";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 maint 5/5] batman-adv: Fix potential
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


--nextPart1778709.nplejUJ7Af
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday, June 16, 2015 17:10:26 Linus L=FCssing wrote:
> So far the mcast tvlv handler did not anticipate the processing of
> multiple incoming OGMs from the same originator at the same time. Thi=
s
> can lead to various issues:
>=20
> * Broken refcounting: For instance two mcast handlers might both assu=
me
>   that an originator just got multicast capabilities and will togethe=
r
>   wrongly decrease mcast.num_disabled by two, potentially leading to
>   an integer underflow.
>=20
> * Potential kernel panic on hlist_del_rcu(): Two mcast handlers might=

>   one after another try to do an
>   hlist_del_rcu(&orig->mcast_want_all_*_node). The second one will
>   cause memory corruption / crashes.
>   (Reported by: Sven Eckelmann <sven@narfation.org>)
>=20
> Right in the beginning the code path makes assumptions about the curr=
ent
> multicast related state of an originator and bases all updates on tha=
t. The
> easiest and least error prune way to fix the issues in this case is t=
o
> serialize multiple mcast handler invocations with a spinlock.
>=20
> Fixes: 77ec494490d6 ("batman-adv: Announce new capability via multica=
st
> TVLV") Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  multicast.c  |   62
> ++++++++++++++++++++++++++++++++++++++++++++++------------ originator=
.c
> |    4 ++++
>  types.h      |    3 +++
>  3 files changed, 56 insertions(+), 13 deletions(-)

Applied in revision 7f220ed.

Thanks,
Marek

--nextPart1778709.nplejUJ7Af
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVgU7ZAAoJEFNVTo/uthzAYUYH/2RSMX/yxdBmIRRADRW5bhFX
jJJ3udjR93Ya4Nv0qrZhp/b5mPdlafjk+ll4VkPLJexBxhO1MS2zpELw/QBH9/3r
x5twSY9Ec3DH89xGHOLQlHBLphop79ZWb49IMfZYHtdHUI7b6lz7qEPP+SRFHznk
lL3z75g0piS7A4LUGp+agTcCBOWl/Q4DkJeNDfyFzzmo3M3H895dU4XRvyPiA6BI
c8jE97od9ZswrElcCRq3XeSlkILAUNw0Zk/GxMDB74RtkB2kuwY7rdSkTC49t5Ro
L5btuB/5bBLDZhN7+arr42m1Ew0exa9HIzmbQFUrPCtrq48OdnMOrsC3QLVB85k=
=4U29
-----END PGP SIGNATURE-----

--nextPart1778709.nplejUJ7Af--


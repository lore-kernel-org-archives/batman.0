Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 15 Dec 2015 15:15:40 +0100
Message-ID: <3299124.KqqXPVO90f@sven-edge>
In-Reply-To: <20151215131533.GF7560@otheros>
References: <1448305042-5806-1-git-send-email-sw@simonwunderlich.de>
 <10435676.kQRiOMhoYg@sven-edge> <20151215131533.GF7560@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1831978.1QcWs0v8YW";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: fix lockdep splat when
	doing mcast_free
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
Cc: Simon Wunderlich <simon@open-mesh.com>, Antonio Quartulli <antonio@meshcoding.com>

--nextPart1831978.1QcWs0v8YW
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday 15 December 2015 14:15:33 Linus L=FCssing wrote:
> On Mon, Dec 14, 2015 at 07:56:19PM +0100, Sven Eckelmann wrote:
> > On Monday 07 December 2015 23:12:42 Linus L=FCssing wrote:
> > > On Sat, Nov 28, 2015 at 09:21:02AM +0100, Sven Eckelmann wrote:
> > > > mcast.mla_list is protected by tt.commit_lock (see
> > > > batadv_mcast_mla_tt_add,
> > > > batadv_mcast_mla_list_free and batadv_mcast_mla_tt_retract).
> > >=20
> > > mcast.mla_list changes should be protected by the non-parallel co=
de
> > > flow: During runtime, batadv_mcast_mla_tt_update() is only called=
 from
> > > the self-rearming OGM scheduler thread -
> > > batadv_mcast_mla_tt_update() will never run more than once at the=

> > > same time.
> > >=20
> > > The second place for mcast.mla_list changes, batadv_mcast_free(),=
 is
> > > called only on shutdown after the OGM scheduling thread was stopp=
ed.
> >=20
> > The two functions with the lockdep assert are
> >=20
> > * batadv_mcast_mla_list_free
> > * batadv_mcast_mla_tt_retract
> >=20
> > (batadv_mcast_mla_tt_add looks basically like batadv_mcast_mla_list=
_free)
> >=20
> > The call graphs are attached and these graphs have (pure) starting =
nodes
> > which are not only batadv_exit and batadv_iv_ogm_schedule. Parts of=
 them
> > look like they are only protected because of tt.commit_lock.
>=20
> Thanks for these pictures! (btw. which tool did you use for that?)

It is just doxygen with the dot (graphviz) enabled for all (also undocu=
mented=20
+ local/static functions).

>=20
> The two non-colliding paths I had in mind were
> batadv_iv_ogm_schedule() and batadv_mcast_free(), which looks
> like:
>=20
> batadv_mesh_free()
> =09-> batadv_purge_outstanding_packets()
> =09=09-> cancel_delayed_work_sync()=09!
> =09[...]
> =09-> batadv_mcast_free()
>=20
> Which ensures that no batadv_iv_ogm_schedule() is running before
> calling batadv_mcast_free().

That seems to be right.

> But I missed the path from batadv_update_min_mtu()... However,
> it should not race with batadv_mcast_free() either, which is
> called once the last hard-iface gets disabled:
>=20
> batadv_hardif_disable_interface()
> =09-> batadv_purge_outstanding_packets()
> =09=09-> cancel_delayed_work_sync()=09!
> =09-> dev_put(soft_iface)
> =09=09[ if last hard-iface, then soft-iface is out
> =09=09  of scope for any new batadv_update_mtu() and
> =09=09  gets freed: ]
> =09=09-> batadv_softif_free()
> =09=09=09-> batadv_mesh_free()
> =09=09=09=09-> batadv_mcast_free()
>=20
> But with yet another path it is getting even more, rediculously
> complicated... Just proving that trying to keep a lock-less update
> for mla_list here is a bad, unmaintainable approach :).

Yes, and I am currently not trusting the reference/rcu code in batman-a=
dv=20
anymore. It seems to have a lot of backpointers (yes, loops are very ba=
d for=20
reference counting and the workarounds chosen in the code for that don'=
t look=20
very sane either). I actually don't want to check this mess to find out=
 if=20
there is a situation where were there can be an (incorrectly counted)=20=

reference somewhere back to it. Let us just assume that everything is f=
ine=20
here... better for everyones sanity.

> So I'm definitely in favor of having some spinlock to refer to for
> mcast.mla_list update, even if it isn't necessary for
> batadv_mcast_free(). But I don't see a race for the current
> mla_list updates either (otherwise I'd need a specific, more
> verbose example, I guess...).

The assert was more for having a common lock for all accesses to this l=
ist=20
(ogm_schedule, mtu change event, hardif add/del, softif free/add). This=
 lock=20
already existed indirectly and protected the updates. The free function=
s=20
should have the same protection (especially when changes are done to th=
e code=20
in the future which might call these functions in a different context).=
 So=20
right now the patch from Simon only works around the lockdep warning an=
d=20
prepares the code for the "future". So I don't think it is required for=
 -
stable - especially when you are sure that there is no race between _fr=
ee and=20
_retract.

Kind regards,
=09Sven
--nextPart1831978.1QcWs0v8YW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWcCCMAAoJEF2HCgfBJntGcKEP/2iPrySgVtErBTieTWbbzWnK
Ar5lHw/kbCPJr7SUoG8Th1QIW35Gb45Sxf1oRrLaXJauhrXHDC160S7RFnwAGA8H
rGkbjhyXzd2hoPmK20NL5XlNbaCUJYYZPd942ceBkeYrFKYqBOQFKceAJao9L+ZC
XTrFL/oxdDhrtmoa2cRkgQA43jVycU0BTZXBoWHD4z0P/LVCRI9suRSmRbZscx/B
gnXcBe5evP0BVawrDzvZcHDCs+Bf+WjdDww2g78aQUHanehxDYCZCp23Mc5Awanj
I/RNl5no09UiQK8kemd8b6xIaj4Q5Og2Fh6p0uQvzQGc8BUyQbfJNXBTEmxBr3Po
f0PEqWICkbOp8Hv8LOjRpPTQao64EdfNx2d1Y98dcyt3OWaeIIud7fJPm6Lxq2bX
ekHyO0Tnst9LjYo3TfFLyF5QpXciPs05CIVZcUNft11/BUdgwTS5oQkA3im44XE8
a56USuPiEL6Lgk799nPTk0HOHXUbP9a2AgtJKZzYJw90KroQIN4/dBDKew+1OswB
3RMsPTs7KPOjuR4StShCIPwRZK64ibLxBVdKu26zJqtz91Qi7l5QVa8tAeJ0gyGA
4Y+gdsTgB9Mm1Bxo1QKmsEehXGuXE5hbyZ8zfvS/hPpu52cBrtCDuKMB6ANVs8ui
hqWnLBUhCkcCmZ6li9km
=PjNp
-----END PGP SIGNATURE-----

--nextPart1831978.1QcWs0v8YW--


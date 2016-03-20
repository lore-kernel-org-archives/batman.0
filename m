Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 20 Mar 2016 12:01:09 +0100
Message-ID: <16765982.vnPfJFa6WA@sven-edge>
In-Reply-To: <9014983.RsdMSR9Elr@voltaire>
References: <1457189627-8839-1-git-send-email-sven@narfation.org>
 <9014983.RsdMSR9Elr@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2942407.QqEY7UDEn7";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Reduce refcnt of
	removed router when updating route
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

--nextPart2942407.QqEY7UDEn7
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 20 March 2016 18:45:29 Marek Lindner wrote:
> On Saturday, March 05, 2016 15:53:47 Sven Eckelmann wrote:
> > --- a/net/batman-adv/routing.c
> > +++ b/net/batman-adv/routing.c
> > @@ -104,6 +104,8 @@ static void _batadv_update_route(struct batadv_priv
> > *bat_priv, neigh_node = NULL;
> > 
> >         spin_lock_bh(&orig_node->neigh_list_lock);
> > 
> > +       curr_router = rcu_dereference_protected(orig_ifinfo->router,
> > true);
> > +
> > 
> >         rcu_assign_pointer(orig_ifinfo->router, neigh_node);
> >         spin_unlock_bh(&orig_node->neigh_list_lock);
> >         batadv_orig_ifinfo_free_ref(orig_ifinfo);
> 
> Don't we also need to check for curr_router->refcount > 0 to mimic the check
> above ? Maybe a negative refcount does not hurt or is it unsigned ?

If this one gets negative then we would have a bug in a different place. The 
assignment only happens in this neigh_list_lock protected block. So the 
neigh_node behind orig_ifinfo->router must at least have a reference count of 
1 or there was no valid reference (as in reference counter) for the pointer.

The the kref_get_unless_zero before was only necessary because the curr_router 
was aquired inside a rcu_read_lock protected region which is not perfectly in 
sync with its writers. So it could happen that rcu_dereference returned a 
pointer to a neigh_node but this neigh_node will be free'd (reference counter 
== 0). And we cannot get a valid reference for an object which has refcount of 
0. This function avoids this problem by assuming that orig_ifinfo->router is 
NULL. This is not perfectly correct but better than having a pointer to free'd 
memory.

Kind regards,
	Sven
--nextPart2942407.QqEY7UDEn7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW7oL1AAoJEF2HCgfBJntGXM0QALGfREs3ycyIM08G0i12pzvw
sZetnEjRrFN2W+nfBn1GbPl6kAZorIXSRj6ND7gCbH6EbCpzBuU0UCu0yIK5/hXp
hsK1garUN5Cj3FeyRfzMK8/rB+ubV0/cxSVdDDR5nkkxjwiOzyRG/yrIloJejJ1o
C5WaddHi7wI0EUqVChoXPdSLP2QNwUYTIWDQ6Me5B8c0huLyL7wysjAXRLULmbCS
ZS8VxCUuX1CvUyfYWSg+b/itjxUjR/j0tJ8+tS9M4n908j07wu6EQKiGgKRvQzd9
OIsZKXQP88m/1fhdlccpaDH0gAC1LZVF4gXWEjzPy0FTIpvlvhjoUd6oeYhQ8Nyq
7+ZXaehlAqiccAkwNFzRhXRXsgaxa3ija4ptnUNt0ShIUOLXwwo50DqjDv2FNhn7
do/vbQHW0uI1xF77B9JdD/Mnq4DxqoGDcpIwrX9cvXPWhydgzB5238AYtH23ankK
1fRhtxTthLwLlEaHO18a/Ajzsj9hHFD32U028mR8FBa+LiswAWOeloS3l0fU9R/s
Tm9dW7inKs1D6Nec/yLFD+Sf0od2tZAO6x00J5U3pGb+i52LVo5zbSuZZOsbdVaF
GWipHvW/W/E9hJvXR5kQCZgOKpIb+hOx3C7511VZQZbCeknN/G++xo37D1zoemI/
FD3HbpBijE48etXXqXGg
=ADkN
-----END PGP SIGNATURE-----

--nextPart2942407.QqEY7UDEn7--


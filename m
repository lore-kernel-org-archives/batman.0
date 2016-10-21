Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 21 Oct 2016 14:30:10 +0200
Message-ID: <2315506.rV8PSJo6DZ@bentobox>
In-Reply-To: <20161005234308.29871-2-linus.luessing@c0d3.blue>
References: <20161005234308.29871-1-linus.luessing@c0d3.blue>
 <20161005234308.29871-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart123116798.q7Ex06gODH";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 1/2] batman-adv: fix race conditions
	on interface removal
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

--nextPart123116798.q7Ex06gODH
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Donnerstag, 6. Oktober 2016 01:43:07 CEST Linus L=FCssing wrote:
> The most prominent general protection fault I was experiencing when
> quickly removing and adding interfaces to batman-adv is the following:

I am personally not sure whether go through net.git or through net-next.git.
If you think it should go through net-next then maybe it would be good to
state quite early in the commit message that mdelay(...) is required to cau=
se
the problem?
=20
> ~~~~~~
> [ 1137.316136] general protection fault: 0000 [#1] SMP
[...]
> [ 1137.320038] Call Trace:
> [ 1137.320038]  [<ffffffffa0363294>] batadv_hardif_disable_interface+0x29=
a/0x3a6 [batman_adv]
> [ 1137.320038]  [<ffffffffa0373db4>] batadv_softif_destroy_netlink+0x4b/0=
xa4 [batman_adv]
> [ 1137.320038]  [<ffffffff813b52f3>] __rtnl_link_unregister+0x48/0x92
> [ 1137.320038]  [<ffffffff813b9240>] rtnl_link_unregister+0xc1/0xdb
> [ 1137.320038]  [<ffffffff8108547c>] ? bit_waitqueue+0x87/0x87
> [ 1137.320038]  [<ffffffffa03850d2>] batadv_exit+0x1a/0xf48 [batman_adv]
> [ 1137.320038]  [<ffffffff810c26f9>] SyS_delete_module+0x136/0x1b0
> [ 1137.320038]  [<ffffffff8144dc65>] entry_SYSCALL_64_fastpath+0x18/0xa8
> [ 1137.320038]  [<ffffffff8108aaca>] ? trace_hardirqs_off_caller+0x37/0xa6
> [ 1137.320038] Code: 89 f7 e8 21 bd 0d e1 4d 85 e4 75 0e 31 f6 48 c7 c7 5=
0 d7 3b a0 e8 50 16 f2 e0 49 8b 9c 24 28 01 00 00 48 85 db 0f 84 b2 00 00 0=
0 <48> 8b 03 4d 85 ed 48 89 45 c8 74 09 4c 39 ab f8 00 00 00 75 1c
> [ 1137.320038] RIP  [<ffffffffa0371852>] batadv_purge_outstanding_packets=
+0x1c8/0x291 [batman_adv]
> [ 1137.320038]  RSP <ffff88001da5fd78>
> [ 1137.451885] ---[ end trace 803b9bdc6a4a952b ]---
> [ 1137.453154] Kernel panic - not syncing: Fatal exception in interrupt
> [ 1137.457143] Kernel Offset: disabled
> [ 1137.457143] ---[ end Kernel panic - not syncing: Fatal exception in in=
terrupt
> ~~~~~~

Can we reduce the length of some lines here? Especially the modules line
(which is not really interesting - I hope) to something like "Modules linked
in: batman-adv(O-) <...>". Also please remove the "[ 1137.457143] " and just
use 2/4 spaces in front of the snippet.

>=20
> It can be easily reproduced with some carefully placed
> msleeps()/mdelay()s.
>=20
> The issue is, that on interface removal, any still running worker thread
> of a forwarding packet will race with the interface purging routine to
> free a forwarding packet. Temporarilly giving up a spin-lock to be able

s/Temporarilly/Temporarily/

[...]
>=20
> PS: checkpatch throws the following at me, but seems to be bogus?
>=20
> ~~~~
> -------------------------------------------------------------------
> /tmp/0001-batman-adv-fix-race-conditions-on-interface-removal.patch
> -------------------------------------------------------------------
> CHECK: spinlock_t definition without comment
> +                             spinlock_t *lock);
>=20
> total: 0 errors, 0 warnings, 1 checks, 411 lines checked
>=20
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inpl=
ace.
>=20
> /tmp/0001-batman-adv-fix-race-conditions-on-interface-removal.patch has s=
tyle problems, please review.
> ~~~~~

Yes, this is bogus and a deficit of checkpatch.pl. But since we run checkpa=
tch
each day and I don't want to find a way to fix it in checkpatch.pl - maybe =
you
can shorten it in send.h?

    bool batadv_forw_packet_steal(struct batadv_forw_packet *packet, spinlo=
ck_t *l);

[...]
> +bool batadv_forw_packet_steal(struct batadv_forw_packet *forw_packet,
> +			      spinlock_t *lock)
> +{
> +	struct hlist_head head =3D HLIST_HEAD_INIT;
> +
> +	/* did purging routine steal it earlier? */
> +	spin_lock_bh(lock);
> +	if (batadv_forw_packet_was_stolen(forw_packet)) {
> +		spin_unlock_bh(lock);
> +		return false;
> +	}
> +
> +	hlist_del(&forw_packet->list);
> +
> +	/* Just to spot misuse of this function */
> +	hlist_add_head(&forw_packet->bm_list, &head);
> +	hlist_add_fake(&forw_packet->bm_list);

Sorry, I don't get how this should spot misuse via this extra hlist_add_hea=
d.
You first add the packet to the list (on the stack) and then setting pprev
pointer to itself. So you basically have a fake hashed node with next point=
er
set to NULL. Wouldn't it be better here to use INIT_HLIST_NODE instead of
hlist_add_head? I would even say that INIT_HLIST_NODE isn't needed here
because you already did this during batadv_forw_packet_alloc.

But I would assume that you actually only wanted hlist_add_fake for the
WARN_ONCE in batadv_forw_packet_queue, right?

[...]
> +/**
> + * batadv_forw_packet_queue - try to queue a forwarding packet
> + * @forw_packet: the forwarding packet to queue
> + * @lock: a key to the store (e.g. forw_{bat,bcast}_list_lock)
> + * @head: the shelve to queue it on (e.g. forw_{bat,bcast}_list)
> + * @send_time: timestamp (jiffies) when the packet is to be sent
> + *
> + * This function tries to (re)queue a forwarding packet. If packet was s=
tolen
> + * earlier then the shop owner will (usually) keep quiet about it.

Can "shop owner" please replaced with some relevant information for
batman-adv?

> + *
> + * Caller needs to ensure that forw_packet->delayed_work was initialized.
> + */
> +static void batadv_forw_packet_queue(struct batadv_forw_packet *forw_pac=
ket,
> +				     spinlock_t *lock, struct hlist_head *head,
> +				     unsigned long send_time)
> +{
> +	spin_lock_bh(lock);
> +
> +	/* did purging routine steal it from us? */
> +	if (batadv_forw_packet_was_stolen(forw_packet)) {
> +		/* If you got it for free() without trouble, then
> +		 * don't get back into the queue after stealing...
> +		 */
> +		WARN_ONCE(hlist_fake(&forw_packet->bm_list),
> +			  "Oh oh... the kernel OOPs are on our tail now... Jim won't bail us =
out this time!\n");

Can this be replaced with a less funny but more helpful message?

[...]
> =20
> +/**
> + * batadv_purge_outstanding_packets - stop/purge scheduled bcast/OGMv1 p=
ackets
> + * @bat_priv: the bat priv with all the soft interface information
> + * @hard_iface:	the hard interface to cancel and purge bcast/ogm packets=
 on

Please replace the tab between " @hard_iface:" and "the hard in" with a spa=
ce

[...]
> @@ -21,6 +21,7 @@
>  #include "main.h"
> =20
>  #include <linux/compiler.h>
> +#include <linux/spinlock_types.h>
>  #include <linux/types.h>

This include is actually correct - but I am currently mapping=20
linux/spinlock_types.h to linux/spinlock.h in iwyu. So would be easier for =
me
when this include will be set to linux/spinlock.h.

I am not sure about all the crime related puns in this patch but the idea
makes sense and also cleans up some of the forwarding packet code.

Kind regards,
	Sven
--nextPart123116798.q7Ex06gODH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYCgpSAAoJEF2HCgfBJntGYIkP/2wcGh2j8xRpIRO9WUAXZzoc
j17rHs0hty9Ik642T3BU0QuQsbFMkLeiBKrdX/mayy3wor29RHcLv/H/k23bKQjz
om5q9neQPaRPD2jVY99u+N6tvB1gKHm5+0bIcENRlTfa4lK0HPifX30+5nlH2Lsa
dRYjPHPS0ESta++bStR2niSUP60yT04xCW87hiGoKNm7LjGvSXnNRa1WTJPOFIxS
9dcX4hQxzFWJnNI8BWhlBJzV7E13tVIKnuZl8Q7lMoYbiyhPfzvvf4xcFMpL/lgU
oTiTv0b+FlTMX7Zj4ovkipoal2ctq6lLAxi2ZeEnwfHXAM4Eq715RbMmPWRec23G
I4MGKB1RFVBy+Q7nsR/Tm/Z2enFkXY1JGv6/a7HbxvFTi7CooEFJgnkhBLaoRCdY
FskiLzRkjXjSVwoyWDBFMJH3r0r/k7XZY69lPqpLqRLTfaaysakvjZpBvbLhKx1X
Zgjtm1y7LeuP2ZR8vKbkVifsftHt8kOpuhhmuXUHxhC27bLYvxSmUxyll0arvlO9
+FqPqI+vcFovQW41eFqsSQgvXZzKsOmiTTDSVH5Ym5kyA9bhvkG4sth2x2bEQ/bu
K62RfYsvChItJ5z/ieO7Cg01nHBjMjLrrtUjxZB0tutfWc6FhncQK596OMe8vsXk
YiFRVJVw4zjIuTqU/9IE
=fiF9
-----END PGP SIGNATURE-----

--nextPart123116798.q7Ex06gODH--


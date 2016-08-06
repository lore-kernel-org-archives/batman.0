Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 06 Aug 2016 10:13:38 +0200
Message-ID: <3793403.6mU5AUzq3p@sven-edge>
In-Reply-To: <20160806011112.GC4299@otheros>
References: <1470083926-6409-1-git-send-email-linus.luessing@c0d3.blue>
 <1877539.fInDOEgoYM@bentobox> <20160806011112.GC4299@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart37707919.bpp1qog2Fu";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 2/2] batman-adv: Simple (re)broadcast
	avoidance
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart37707919.bpp1qog2Fu
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Samstag, 6. August 2016 03:11:12 CEST Linus L=FCssing wrote:
> On Thu, Aug 04, 2016 at 07:56:44AM +0200, Sven Eckelmann wrote:
> > Ok, looks like the neigh_list edge in my graph is incorrectly there. Bu=
t=20
what=20
> > about last_bonding_candidate? This definitely has a reference counter (=
and=20
> > needs it) and thus your code would cause problems when bonding is enabl=
ed.
>=20
> One more tiny thing, that I noticed during rereading & playing
> with that part of the code:
>=20
> The usage of orig_node->last_bonding_candidate looks a lot like
> rcu-pointer style. However it is read & set without any
> rcu_dereference() / rcu_assign() wrappers.

It is set+accessed with a spinlock.

With rcu on the read side (and spinlock on the write side) we should guaran=
tee=20
that the rcu protected pointer is mostly read [1]. This is not the case her=
e=20
and thus it is using spinlocks at the moment.

> Is something else protecting a simultaneous read (for instance from
> the neighbor table output) of last_bonding_candidate while being
> changed via batadv_last_bonding_replace()?

See above

What has the neighbor table output to do with last_bonding_candidate? It=20
doesn't seem to access this pointer. Maybe I am missing something here. Can=
=20
you please give an example how these are connected.

RCU also doesn't protect the changes to the object itself. It only helps us=
=20
not to access invalid (free'd) memory regions when another context just=20
replaced our pointer. This is done by splitting the previously (more or les=
s)=20
single operation of removing the object into two phases. One is to remove t=
he=20
object from the datastructure (list, pointer, ..) and then only reclaiming =
the=20
memory when no one (correctly using rcu) can see the old object anymore. It=
 is=20
possible in the time between the removal from the datastructure that one=20
context sees the new object when accessing the datastructure and another=20
doesn't. Similar things can happen when new objects are added to the=20
datastructure.

Just using the spinlock on both sides gives us the same protection (without=
=20
the conflicting views of the datastructure from different contexts) - but i=
t=20
would be slower when we have multiple readers (and nearly no writer) trying=
 to=20
access the pointer all the time. This doesn't seem to be the case here beca=
use=20
the main function batadv_find_router is at the same time reader+writer.


And just to remind the reader: The content of the object referenced in the=
=20
datastructure still has to be protected with a spinlock (or something simil=
ar)=20
in case multiple contexts may want to change the content.


And to be fair: There is one case were a spinlock is missing in=20
batadv_find_router

    	last_candidate =3D orig_node->last_bonding_candidate;
    	if (last_candidate)
    		last_cand_router =3D rcu_dereference(last_candidate->router);

I had this on my list but mostly forgot about it while chasing the referenc=
e=20
counting bugs. Maybe you found more problems but I am not sure which ones :)

Kind regards,
	Sven

[1] https://www.kernel.org/doc/Documentation/RCU/whatisRCU.txt
    search for "read-mostly" situations
--nextPart37707919.bpp1qog2Fu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXpZwyAAoJEF2HCgfBJntGI50QALUF6sRjvylGbjQoyxiqelFI
LDS27yMZ5Ip67+kh3LHXwsglhGcNLIQ5WUZMlwyxgBkE2sdKbtk3qMT4S52PDW5J
bNqeNvNae+sZi1K77mYNPUUSwDUBkpnHbVRogq0u964vlAVTZRYia518a0zrY1NY
Jcr6hNpmgPrkw3yF8IELzVT2frDkkeecMIkXr1DFCxVXsJWhcc1N46AxRPKWHYJK
Grs5reu33Zb2V4v1TIkvQlGgvtEDlZFAfvUvA0bZJXCFMaxsHE5vK+AwmdvKI1UD
iIPxUFggf9apzhEWqll2bWrEbxRCzl8nZr+5oRzZ/EhW9F9OivHBoIoGqFmnXqu5
VoiWoYIFvzESaj3gTF6jEH1ESKM+O8BmGEbO6YrrMWgwh71mxppsWMQy8m0RxeKi
BpBeAC2MofPlWkMbGWUWuzHWH/GfCl7WYKCfob0YiJ5AsQ+IjkTomp89tvArrpZ5
7/InGf3AaxzGHN1M3vkq+KPpp6hQhNU5FE0thwUDMRJiT3BNyNfrUNeGhwbbGkRX
nxR/Zg6f/gFnPRBE8iK1A0eItivHZOzqrKk6NmpXZzyaNK4wGk9eVxvNRxNYH2nM
Ji1LTUd9himDpeDNZGk3NfdY+8f1elbBzs0wbf6mE8VTpIiU3JGnqYwI3V2pR2y9
8rqR6tWB7sF4og3FJ1pt
=+hQO
-----END PGP SIGNATURE-----

--nextPart37707919.bpp1qog2Fu--


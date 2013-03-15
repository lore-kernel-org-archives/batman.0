Return-Path: <ordex@autistici.org>
Date: Fri, 15 Mar 2013 14:29:46 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130315132946.GJ8563@ritirata.org>
References: <CAP5XTDM0KWS4c=0Z_KO=AdFh9rBDo_AOz553bstFk0FQRuWA0Q@mail.gmail.com>
 <20130315115722.GI8563@ritirata.org>
 <CAP5XTDMsHjgL0Mj8Wi8it+S=LU3qpC7enRyp570wrucOBaSczQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3U8TY7m7wOx7RL1F"
Content-Disposition: inline
In-Reply-To: <CAP5XTDMsHjgL0Mj8Wi8it+S=LU3qpC7enRyp570wrucOBaSczQ@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: Modified DAT structures and
 functions in order to support both IPv4 and IPv6
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--3U8TY7m7wOx7RL1F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2013 at 03:19:22PM +0200, Mihail Costea wrote:
> On 15 March 2013 13:57, Antonio Quartulli <ordex@autistici.org> wrote:
> > On Sat, Mar 09, 2013 at 07:40:48PM +0200, Mihail Costea wrote:
> >> Subject: [RFC] batman-adv: Modified DAT structures and functions in or=
der
> >>  to support both IPv4 and IPv6
> >>
> >> In order to support DHT for IPv6 there was needed a general implementa=
tion for
> >> the IP field in distributed-arp-table.c (now the IP is __be32 and this=
 patch
> >> will transform it to unsigned char *). Distinction between types is do=
ne
> >> using a new enum.
> >>
> >> Also all functions were changed to support this.
> >>
> >> Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>
> >
> > Hi Mihail,
> >
> > thanks for this patch. Sorry for the late reply, but I required some ti=
me to
> > review it all :)
> >
> > As first concern I would say that we need some more #ifdef (not thrown =
in the
> > code, but placed in the right spots) to let the whole code work if some=
body has
> > disabled the IPv6 support in his kernel.
>=20
> Thx for the info. I haven't thought about this. I'll think how it's
> best to work with the IPv6 support.

ok

>=20
> > More comments inline
> >
> >>
> >> ---
> >>  distributed-arp-table.c |  234 ++++++++++++++++++++++++++++++++++++--=
---------
> >>  types.h                 |   21 ++++-
> >>  2 files changed, 197 insertions(+), 58 deletions(-)
> >>
> >> diff --git a/distributed-arp-table.c b/distributed-arp-table.c
> >> index 9215caa..ed6e817 100644
> >> --- a/distributed-arp-table.c
> >> +++ b/distributed-arp-table.c
> >> @@ -20,6 +20,7 @@
> >>  #include <linux/if_ether.h>
> >>  #include <linux/if_arp.h>
> >>  #include <net/arp.h>
> >> +#include <net/ipv6.h>
> >>
> >>  #include "main.h"
> >>  #include "hash.h"
> >> @@ -31,6 +32,36 @@
> >>  #include "translation-table.h"
> >>  #include "unicast.h"
> >>
> >> +/* Prints similar debug message for IPv4 and IPv6.
> >> + * At list one variable parameter should be the IP itself, and it sho=
uld
> >> + * be placed correctly based on format prefix and format suffix argum=
ents.
> >> + */
> >> +#ifdef CONFIG_BATMAN_ADV_DEBUG
> >> +
> >> +#define batadv_dat_dbg_ip(bat_priv, ip_type, format_prefix, \
> >> +                            format_suffix, ...) \
> >> +             { \
> >> +             switch (ip_type) { \
> >> +             case BATADV_DAT_IPv4: \
> >> +                     batadv_dbg(BATADV_DBG_DAT, bat_priv, \
> >> +                                format_prefix "%pI4" format_suffix, \
> >> +                                     __VA_ARGS__); \
> >> +                     break; \
> >> +             case BATADV_DAT_IPv6: \
> >> +                     batadv_dbg(BATADV_DBG_DAT, bat_priv, \
> >> +                                format_prefix "%pI6c" format_suffix, \
> >> +                                     __VA_ARGS__); \
> >> +                     break; \
> >> +             } \
> >> +             }
> >> +
> >> +#else
> >> +
> >> +#define batadv_dat_dbg_ip(bat_priv, ip_type, format_prefix, \
> >> +                            format_suffix, ...) /* do nothing */
> >
> > in this case we prefer to write a stub function rather than an empty de=
fine. In
> > this way the type check can still work and report issues. See
> > distributed-arp-table.h for an example.
>=20
> Should both defines be functions or only the empty define?
> It's not a big problem. It would be nice to play more with functions
> with variable args too :).

I'd say to use functions for both.
=20
> >>  static void batadv_dat_entry_free_ref(struct batadv_dat_entry *dat_en=
try)
> >>  {
> >> -     if (atomic_dec_and_test(&dat_entry->refcount))
> >> +     if (atomic_dec_and_test(&dat_entry->refcount)) {
> >> +             kfree(dat_entry->ip);
> >>               kfree_rcu(dat_entry, rcu);
> >> +     }
> >
> > mh, here we are mixing rcu freeing and not. it may be better to create =
a freeing
> > function which take cares of freeing everything which will be set in th=
is point
> > by means of call_rcu() (you can grep for call_rcu in translation-table.=
c to see
> > how we use it).
> >
>=20
> Thx. I saw that if we use call_rcu() there's no need to use
> kfree_rcu(), but only kfree().

correct, but in the function invoked by call_rcu, not here.

> >> +
> >> +/**
> >>   * struct batadv_dat_candidate - candidate destination for DAT operat=
ions
> >>   * @type: the type of the selected candidate. It can one of the follo=
wing:
> >>   *     - BATADV_DAT_CANDIDATE_NOT_FOUND
> >> --
> >
> > What is not entirely clear to me (I may have overlooked it) is how do t=
he two
> > types of data interacts. If I am not wrong, you want to use the same ta=
ble for
> > both data, but this will create problems when comparing a 16bytes long =
ipv6
> > address with a 4bytes long ipv4 one. So you should assume that mixed co=
mpare can
> > happen and you should check the type of the two objects before going to=
 the real
> > data compare.
> >
> > I think you are on the right track, but you should think a bit more how=
 to
> > generalise your approach in order to account the case I described above.
> >
>=20
> About this I think we could use container_of or something similiar
> maybe to get the whole dat_entry structure and then test if types are
> equal.

yeah, should be good. Unless we can pass the entire dat_entry to the compare
function, but I think this is not really doable (haven't looked in it now).

>=20
> > It would also be nice to generalise it such that you do not have to tal=
k about
> > IPs, but about "DHT data" and its len, which can then be whatever we wo=
uld like.
> > However this point might be something we want to discuss later...now yo=
u can
> > focus on your patch assuming we want to store IPv4/6 only.
> >
>=20
> Good to know. I would prefer for this patch to keep it similar so  we
> wouldn't lose time with understanding the patch again.

sure

>=20
> > Cheers,
> >
> > p.s. feel free to join our IRC channel (#batman at irc.freenode.org) fo=
r live
> > discussions)
> >
> > Cheers=C2=B2,
> >
> > --
> > Antonio Quartulli
> >
> > ..each of us alone is worth nothing..
> > Ernesto "Che" Guevara
>=20
> Thx a lot for the review. Monday I will send the update to the changes.
> Should it be in this thread or a new thread?
>=20

better a new thread and postpone "v2" to the RFC word. In this way everybody
know that you are posting a new version of something that went over the ml =
in
the past.

If possible, after the "---" (it you open the .patch file with an editor you
will notice the --- right after the message body) it would be good to have a
short summary of what you changed since v1. In this way, whatever the versi=
on of
your RFC/PATCH everybody can easily understand what you changed since your =
last
post.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--3U8TY7m7wOx7RL1F
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRQyJKAAoJEADl0hg6qKeOw8AP/0esm8Ogf1gun+b+EgRS9qsz
Qq9pJZZDN4zDyFgQC5P0Tp8CBOXxJEEJ79ND6lGaxfWQudG19gSeKdt1Xn5zEEao
s7wv1hwIekekzR8HGkscIdwkdOmzWkb58I4TNeYf29D2E8t5QJzQ8HGJD/sDMlH4
C7u+k6LPLtVLQSExi5jIYmbQT0Ao7LmIrKE480vkQcoRtlCCRjg3BOO5iAuUuE1n
lBnl+Kyilq4O9mMsL8ibVK2XCLaSuZ1mWpyZCaBPws3PXfNPC19VjOXg1f/JJ9+e
AtyFTMnL/RNQAHv47vWEETuZExpTifAvva52iagJqG7jo4+El4tqFO9Ws8YLluna
PA6Sm6VHm5BYx2YSmk6G7d6aYhTTdhkqJVBIJWGOVqiVlLswzEizyAsg/GpcVleb
EacQDZd6YR3E/oKSZ0kdLb30RGB8sBXjo/lStHMm9FnKH1+IrbKafOPlNKIYGWqe
g37efOMZfaPeCp/+Dp8uwTrMiTUrtU2NWRQZsQ5DS+LYv7puhv4rr12K938He9yY
++jF8ETyMyL0hucElcOl5G3G0iwy82wDoAh4u6/myRxak9lPBXmYgGfdSEgWqo7L
xgIKDcrGmVYftGuMSL3dgRpapfFTTVX1H/O0Q5vVgWLM00XK97AL3laRxIaI+sOV
KxkB56/1jYSsG8193/Fc
=gzdb
-----END PGP SIGNATURE-----

--3U8TY7m7wOx7RL1F--

Return-Path: <ordex@autistici.org>
Date: Wed, 29 May 2013 17:33:14 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130529153314.GV3333@ritirata.org>
References: <1368793673-27539-1-git-send-email-mihail.costea2005@gmail.com>
 <1368793673-27539-2-git-send-email-mihail.costea2005@gmail.com>
 <20130526135746.GM1679@ritirata.org>
 <CAP5XTDPhKhaJtagOw2XO04g5ffqt=MmFKaTjtaHZ5RAiACWHJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tbn31orTZdSAVHoc"
Content-Disposition: inline
In-Reply-To: <CAP5XTDPhKhaJtagOw2XO04g5ffqt=MmFKaTjtaHZ5RAiACWHJg@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] [RFC 2/4] batman-adv: added IPv6 to DAT and
 generic functions in distributed-arp-table.c
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


--tbn31orTZdSAVHoc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2013 at 08:21:37AM -0700, Mihail Costea wrote:
> On 26 May 2013 06:57, Antonio Quartulli <ordex@autistici.org> wrote:
> > On Fri, May 17, 2013 at 03:27:50PM +0300, Mihail wrote:
> >> From: "mihail.costea90@gmail.com" <mihail.costea90@gmail.com>
> >>
> >> Added IPv6 functionality to generic functions implemented in the first
> >> patch.
> >
> > avoid references to "first"/"second"/"third" patch. Once committed, the=
y will
> > just be some patches in the list. You can either explicitly mention the=
 name of
> > the patch ("writing the subject in this way") or just saying
> > previously/whatever else.
> >
> >
>=20
> ACK
>=20
> >>
> >> Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>
> >> Signed-off-by: Stefan Popa <Stefan.A.Popa@intel.com>
> >> Reviewed-by: Stefan Popa <Stefan.A.Popa@intel.com>
> >>
> >> ---
> >>  distributed-arp-table.c |   30 ++++++++++++++++++++++++++----
> >>  types.h                 |    6 +++++-
> >>  2 files changed, 31 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/distributed-arp-table.c b/distributed-arp-table.c
> >> index b2ca7e0..42118be 100644
> >> --- a/distributed-arp-table.c
> >> +++ b/distributed-arp-table.c
> >> @@ -32,7 +32,7 @@
> >>  #include "unicast.h"
> >>
> >>  static char *batadv_dat_types_str_fmt[] =3D {
> >> -     "%pI4",
> >> +     "%pI4", "%pI6c",
> >
> > better going on a new line rather than putting both on the same one (li=
ke the
> > array declared in the gateway code).
> >
>=20
> ACK
>=20
> >>  };
> >>
> >>  static void batadv_dat_purge(struct work_struct *work);
> >> @@ -173,6 +173,10 @@ static size_t batadv_sizeof_dat_data(uint8_t data=
_type)
> >>       switch (data_type) {
> >>       case BATADV_DAT_IPV4:
> >>               return sizeof(__be32);
> >> +#if IS_ENABLED(CONFIG_IPV6)
> >> +     case BATADV_DAT_IPV6:
> >> +             return sizeof(struct in6_addr);
> >> +#endif
> >>       default:
> >>               return 0;
> >>       }
> >> @@ -295,6 +299,12 @@ static uint32_t batadv_hash_dat_ipv4(const void *=
data, uint32_t size)
> >>       return batadv_hash_dat(data, BATADV_DAT_IPV4, size);
> >>  }
> >>
> >> +#if IS_ENABLED(CONFIG_IPV6)
> >> +static uint32_t batadv_hash_dat_ipv6(const void *data, uint32_t size)
> >> +{
> >> +     return batadv_hash_dat(data, BATADV_DAT_IPV6, size);
> >> +}
> >> +#endif
> >>
> >>  /**
> >>   * batadv_dat_entry_hash_find - look for a given dat_entry in the loc=
al hash
> >> @@ -393,6 +403,11 @@ static void batadv_dat_entry_add(struct batadv_pr=
iv *bat_priv, void *data,
> >>       case BATADV_DAT_IPV4:
> >>               choose =3D batadv_hash_dat_ipv4;
> >>               break;
> >> +#if IS_ENABLED(CONFIG_IPV6)
> >> +     case BATADV_DAT_IPV6:
> >> +             choose =3D batadv_hash_dat_ipv6;
> >> +             break;
> >> +#endif
> >
> > mh...I was just wondering: for the hash functions it would be nice to r=
e-use the
> > same "array approach" that you used for the printing format.
> >
> > So we would have an array of function pointers to reference rather than=
 having
> > this switch block...What do you think?
> >
> > I think it would be possible to do this for many other "variable" param=
eters if
> > required.
> >
>=20
> Should there be a struct that contains all of them, like:
>=20
> struct batadv_dat_data  {
>   char *format;
>   signature *hash_function;
>   .......
> }
>=20
> And after that the array with the initialization for all types.
> Or should they be declared as arrays that have nothing in common? Like
> just adding a new array for the choose functions.
>=20

I guess you replied to the same email twice.
However, the idea of 1  array of structs is nice! I like it :)


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--tbn31orTZdSAVHoc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIbBAEBCAAGBQJRph+6AAoJEADl0hg6qKeOlKgP9R79kxf0HkO6vuM2yFxFfjNg
S2ulvqlWohNDnyqzdm24Rc/WOqeD3qKISjbst8dgIRllI29ONflKeBIWp4NKe4rA
809FUBxgFvQmWVg7RBhK+Qe9fCIqikg2heGdebwP+gQj0ys/p/MzInhVqUnVEF2y
U9jO1nQFFA0NTrrREZtlVltkj7anhb1+fqPojaOXmfj7jgn8PsQCOcpyZ3Z5dWxK
PxbYAXz936t6TtDO6BaY2OTVM2GjfEoyowRzvB79l9WOsYTItJxIz3UqjnSZt9Q+
d44KSv17yJsKDqQoAnZ0EcG7pWiDrv+LVlE+FuZnK/nfuo9CL9I7TsDezwdnrcpe
NCsxdmAnSBCeHEL+LbCPX61APchKKg24wlZSMgw3vmObuWFtJYkLRhDKQyH0xe/v
j/CnxFv9wDcXrU5P+1O3qWbHe3XFRK5rUIjY0B8PhoSqkGZQtQY7E5iVZQce0Tz1
MTrE6Ls/AsrTHZ57FIjKf55pexnFFHuKj1ZRE4Gyx6l5UUdDMT0tTg0dPQlBy3Oz
Afd3He0eaTEvdEmJb5cfUjI/nd5w57iGESiP2Sk/eWBWz5vcL92IwaBhGnt6Lc/t
MtQXB15zMsVDGHAlU+2UGMgCuDxFcA5AJ85NiUr4pdlCQ5YUyn/YN8NX89X2sQ7Q
PDICA92OEumTcSuHHcA=
=R1io
-----END PGP SIGNATURE-----

--tbn31orTZdSAVHoc--

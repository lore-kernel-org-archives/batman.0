Return-Path: <ordex@autistici.org>
Date: Wed, 17 Apr 2013 14:58:33 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130417125833.GE20819@ritirata.org>
References: <trinity-97d57b03-203f-4915-9bec-fcae5d01e618-1363490537768@3capp-webde-bs08>
 <1363495498-17830-1-git-send-email-linus.luessing@web.de>
 <1363495498-17830-2-git-send-email-linus.luessing@web.de>
 <20130330131602.GC4024@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VywGB/WGlW4DM4P8"
Content-Disposition: inline
In-Reply-To: <20130330131602.GC4024@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Fix general protection
 fault in batadv_tt_global_del_orig()
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


--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2013 at 02:16:02PM +0100, Antonio Quartulli wrote:
> On Sun, Mar 17, 2013 at 05:44:58AM +0100, Linus L=C3=BCssing wrote:
> > On shutdown a race condition where we access a just freed global TT hash
> > might occure. batadv_orig_node_free_rcu() callbacks might have been
> > scheduled (especially during the shutdown procedure) and unfortunately
> > batadv_tt_global_table_free() does not wait for them to finish first
> > before freeing the global TT hash.
> >=20
> > This potentially results in a general protection fault in
> > batadv_tt_global_del_orig(), called via a batadv_orig_node_free_rcu()
> > callback, which tries to access the just freed global TT hash.
> >=20
> > This patch tries to fix this by waiting for any just scheduled
> > batadv_orig_node_free_rcu() to finish via an extra rcu_barrier() call
> > before freeing the global TT hash. And by moving the TT freeing call to
> > the end of the batman cleanup routines.
> >=20
> > Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>
>=20
> Acked-by: Antonio Quartulli <ordex@autistici.org>

NACK.

This patch is solving one problem but creating a new one:
by using rcu_barrier we avoid the crash but we will leak memory, because
batadv_orig_node_free_rcu()->batadv_tt_global_del_orig() will access an emp=
ty
global table and so will not be able to free the global entries.


Patch
("batman-adv: avoid race conditions on TT global table by counting referenc=
es")
is fixing the problem by redesigning the TT clean up routine.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--VywGB/WGlW4DM4P8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRbpx5AAoJEADl0hg6qKeOOiMQAIQ59CD7JKyC21RKIcE0s5Rc
wfeGH2WUaoqueKrCIrU+ajWKI+0VreNQPpXQ6X9NMA+yUyo7NNNaP0WgI6ax73CK
+W5MPmwYCQ+ViBxC/BGU6j9R2AHEQb6I5Xa0PErtPZIX2pWqYMNlfMkCZproBGy0
Tzcy8Ge3D08+Z0iTGH8qj8xfY38OHDwVQFdEctl4FSvLRNok5DjuIknEtf+8Zbxh
Ww8oHIylQMMUcg7G1/mO9m6GQiLr0v4yTyvPvy4m7AsX+vaxEI5prDB9Wqzp9GxV
KL2HZMNTBH8EaDJ+smRTh7767wmfj+j+WLqrKYT6IAsU/rgktJAabaNujS0C2z/Q
SGOQWlGwwhs3tROaYYxvPasr2Rez/RU+EH3NnqWVTDs4Yp5oNIP2rvznE0Ouxrpp
C+B3NFx6V3XYUasXEIbcl4YGb9K3cK56EmLRKJdC5MV+i1FjKLv0uLU822t52eq8
37UPI1uAn/b+QVMHowhZ/FD47zVPrUz1mUKaV0qm6i92N2ZFEUnUiuujA60eHzmX
ORHfnSf2tORGm92WTTjDUhrXtjlIG0nsDPTtsvG9+uWDGJNzrGCU8+YEzI1LStci
n2VSPWx7lPCvUUxGYsv5jGKT/0rXg//wiqQKGN3uNGKUPLNBfrxrrTE0wlZBBV3L
pg428bwc6UvBnzvot0Le
=kSfc
-----END PGP SIGNATURE-----

--VywGB/WGlW4DM4P8--

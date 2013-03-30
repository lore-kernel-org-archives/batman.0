Return-Path: <ordex@autistici.org>
Date: Sat, 30 Mar 2013 16:09:07 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130330150907.GE4024@ritirata.org>
References: <1364654967-25455-1-git-send-email-ordex@autistici.org>
 <201303302301.29913.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BZaMRJmqxGScZ8Mx"
Content-Disposition: inline
In-Reply-To: <201303302301.29913.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: do not silently ignore wrong
 condition
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


--BZaMRJmqxGScZ8Mx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2013 at 11:01:29PM +0800, Marek Lindner wrote:
> On Saturday, March 30, 2013 22:49:27 Antonio Quartulli wrote:
> > @@ -669,7 +669,7 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_p=
riv,
> >                 if (batadv_compare_eth(neigh_addr, ethhdr->h_source) &&
> >                     tmp_neigh_node->if_incoming =3D=3D if_incoming &&
> >                     atomic_inc_not_zero(&tmp_neigh_node->refcount)) {
> > -                       if (neigh_node)
> > +                       if (WARN(neigh_node, "too many matching
> > neigh_nodes") batadv_neigh_node_free_ref(neigh_node); neigh_node =3D
> > tmp_neigh_node;
> >                         continue;
>=20
> I wasn't aware one could throw the warning right in the if-statement but =
for=20
> the sake of readability, please don't do that.

We already do that in hard-interface.c:92 and WARN() has been designed to r=
eturn
the value of the condition passed as argument
(http://lingrok.org/xref/linux-net-next/include/asm-generic/bug.h#94).

There are many places in the kernel were this is done the same way.
Actually this "connects" the warning to the action taken into the if block:

if "we are in trouble" do this to repair.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--BZaMRJmqxGScZ8Mx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRVwATAAoJEADl0hg6qKeOdM8P/3l2/GLXsFNzBvNpalpQnlLm
fhYVLJlnpy0z7eMvr3oPVdCQ5Dw7nFDhkTkT8QbHBpnMd+s7/LCOYAS4Z7i5MGkP
PUG9BRr7wQex1AIwj4W925Rl5I+WbmeHlFLgKI03fDjLJM6CFzXGdHi0GjQUCD1m
7df07ih+y6pX+vn9ytyPqYsoWboD++6qX+i8cnrFQXc5/9WhehxfDvcSiCvaQI62
QTIF6GnS/Wv/hxqojlsJd2zupnceTWL2AFbT9QptpND67kTyMHtotRnQxhAiyo1m
OGaBl8M25OTfB0hPh2YV+nwUStYQ3Vpsn7tQBDt5Qfs6P/BkofaC6Y93cPqPJWHH
RxJxDAft+7OpRhRvF061UrKwx37aWB5+Z5gKfXwHLheWIRRMx+EH0saVVnvCa+J1
WkZriAgNPsXHSlz+jVOl+N+HFmi4LilGz0NMQNgDMn703o2lsanDZ5/WEhGEXLbK
sJDaEaP4iSV6LbB8aeIk9Z75/vDDzwtgi0TqDgLX1gFEN2D7iiGcI+64zypksQ9a
OgETMpp+Tsu6gm0FTOhnMNHoA33Uha4iZy9ju/RQHx7iFa5Xh44yuUDVEqzHPYHl
pm4A0hIvbrmddAHR1u8SivgZ/CnIrle7caizOPJJixXSmyjaMAt2TxPuQ3I7GgR9
/SBgDaqcnyOu2smdb9Pp
=wgga
-----END PGP SIGNATURE-----

--BZaMRJmqxGScZ8Mx--

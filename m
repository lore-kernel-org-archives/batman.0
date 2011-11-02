Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 2 Nov 2011 12:07:39 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20111102110739.GB6355@pandem0nium>
References: <1320015072-10313-1-git-send-email-siwu@hrz.tu-chemnitz.de>
	<1320015072-10313-8-git-send-email-siwu@hrz.tu-chemnitz.de>
	<201111011147.12470.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
In-Reply-To: <201111011147.12470.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC 07/11] batman-adv: add broadcast duplicate
 check
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 01, 2011 at 11:47:12AM +0100, Marek Lindner wrote:
> On Sunday, October 30, 2011 23:51:08 Simon Wunderlich wrote:
> > +struct bcast_duplist_entry {
> > +       uint8_t orig[ETH_ALEN];
> > +       uint16_t crc;
> > +       unsigned long entrytime;
> > +};
> > =20
> >  struct bat_priv {
> >         atomic_t mesh_state;
> > @@ -185,6 +190,8 @@ struct bat_priv {
> >         struct list_head tt_req_list; /* list of pending tt_requests */
> >         struct list_head tt_roam_list;
> >         struct hashtable_t *vis_hash;
> > +       struct bcast_duplist_entry bcast_duplist[DUPLIST_SIZE];
>=20
> These are 200 bytes you are adding here. Any specific reason not to alloc=
ate=20
> it?

No specific reason, however I could not think of any reason to allocate lin=
k it:
 * bat_priv is kmalloc()d anyways
 * we will always need this structure once the patch is applied
 * we need it only once per bat_priv, no sharing, no lists etc
 * external allocation would require a few more lines plus sanity checking

no problem to change it, but I just could not think of a good reason why - =
maybe you
have one? :)

best regards,
	Simon

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk6xJHsACgkQrzg/fFk7axbTLgCgruHyuxBmSesNbStM5PbPOa0P
SZ8An0BR5q6KdQj4a3KO1rejGCepSTlv
=HlS6
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--

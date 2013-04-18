Return-Path: <ordex@autistici.org>
Date: Thu, 18 Apr 2013 15:19:02 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130418131902.GG20819@ritirata.org>
References: <1366109189-17384-1-git-send-email-ordex@autistici.org>
 <trinity-654eb65a-c1c3-48f5-9a73-23614f415e71-1366225529049@3capp-webde-bs26>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kA1LkgxZ0NN7Mz3A"
Content-Disposition: inline
In-Reply-To: <trinity-654eb65a-c1c3-48f5-9a73-23614f415e71-1366225529049@3capp-webde-bs26>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/2] batman-adv: avoid race conditions
 on TT global table by counting references
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
To: =?utf-8?Q?=22Linus_L=C3=BCssing=22?= <linus.luessing@web.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>


--kA1LkgxZ0NN7Mz3A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2013 at 09:05:29PM +0200, "Linus L=C3=BCssing" wrote:
> Hi Antonio,
>=20
> Looks good, I like the idea of using refcounting for the tt global hash. =
That will indeed nicely remove the ordering dependancy I introduced with my=
 patch earlier.
>=20
> > @@ -844,7 +897,17 @@ int batadv_tt_global_add(struct batadv_priv *bat_p=
riv,
> > =20
> >  		if (unlikely(hash_added !=3D 0)) {
> >  			/* remove the reference for the hash */
> > -			batadv_tt_global_entry_free_ref(tt_global_entry);
> > +			batadv_tt_global_entry_free_ref(bat_priv,
> > +							tt_global_entry);
> > +			goto out_remove;
> > +		}
> > +
> > +		/* increase the refcounter for this new "reference to the global
> > +		 * table represented by the global entry. If the increment
> > +		 * fails remove the entry from the hash
> > +		 */
> > +		if (!atomic_inc_not_zero(&bat_priv->tt.global_refcount)) {
> > +			hlist_del_rcu(&tt_global_entry->common.hash_entry);
> >  			goto out_remove;
> >  		}
>=20
> Looks like there's a spin-lock missing, we usually need to do the rcu-lis=
t-adds/dels within such a lock.
>=20
> Also the ordering looks a little different compared to what we usually do=
=2E Usually we increase all the refcounting first and add things to the lis=
ts in the end. Changing the order should remove the need for an hlist_del_r=
cu/spin-lock in the first place.

Hi Linus,

thank you very much for the review.
However, after having properly fixed the "RCU coordination" in the clean up
path, this patch is not needed anymore.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--kA1LkgxZ0NN7Mz3A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRb/LGAAoJEADl0hg6qKeOaLwP/iykd5VGF7391+w3ykw/mrEa
5DzdGUmQ6Hd0i8JCmol6Azy3fNptMtizXlJsOLBEmP+aRhcxCzZ0j9ImY0kZc9Ys
ckYTDv/poKF7IOAQ9++LnbyWiupxnpGdaUJLqk3S1kfEUE9O2BgwzkOEVSupA0Pn
m4FD6Vdnz+HGu/LosYQ5T7glc42CfDglF34ngUjrJE42815BoLqplvZkZoxAgowz
6fAZ79gLyD2DT/+2gAp/piauwqAyrs/TIKzGxhmClE/xs3asLCL3OXad2X3oKJ9O
fbyT3aIUuC8OkuacjZ28p9PKoPVD5x1dygi9qPXa6BC95924ECZjAfutoCoEZXE1
pTMNX5kLT78H/xX5euKiOo8THcwkMoowuuxXSSqv7ftDaIC5uPhJFQft1rC2h3A0
DSjlwCkCI3iq+E7ndzUz+zAOdiQAmeriS2zlmuU5wk9I7Na0V+qBKnjeT9BMC0md
/Upo+HuavlJygYKH6MClc3Ax4y86pgKDTyPLcQapLeWSOY1Pk7s5OE85Q5xG2hsI
6hktXb1V22cn0N9+NHxghO8ToSpEdY2GzQYUnaOhMY/YoJ/8DOggyHuag76AVuFc
uFGZQhov4LAUs86HNYSfmZMcys1bb//XU4ZnsyF6EaGdPrHhq12qlM7bxZOMNHx9
1LhwUZ76l5QBHRY4OdM4
=O/xK
-----END PGP SIGNATURE-----

--kA1LkgxZ0NN7Mz3A--

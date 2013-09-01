Return-Path: <ordex@autistici.org>
Date: Sun, 1 Sep 2013 10:05:43 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130901080543.GA1871@ritirata.org>
References: <1377790385-24720-1-git-send-email-lindner_marek@yahoo.de>
 <20130831183829.GT2896@ritirata.org>
 <201309011248.44874.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <201309011248.44874.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: limit local translation
 table max size
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


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 01, 2013 at 12:48:44PM +0800, Marek Lindner wrote:
> On Sunday, September 01, 2013 02:38:29 Antonio Quartulli wrote:
> > > @@ -717,12 +762,6 @@ static void batadv_tt_tvlv_container_update(stru=
ct
> > > batadv_priv *bat_priv)
> > >=20
> > >  	tt_diff_entries_num =3D atomic_read(&bat_priv->tt.local_changes);
> > >  	tt_diff_len =3D batadv_tt_len(tt_diff_entries_num);
> > >=20
> > > -	/* if we have too many changes for one packet don't send any
> > > -	 * and wait for the tt table request which will be fragmented
> > > -	 */
> > > -	if (tt_diff_len > bat_priv->soft_iface->mtu)
> > > -		tt_diff_len =3D 0;
> > > -
> >=20
> > Why are you removing this? We are not going to fragment OGMs and in this
> > function we are preparing the TVLV to send within one of those.
>=20
> Upon reading this function a realized this "tt_diff_len =3D 0" mechanism =
is=20
> buggy. For instance, the changes_list list is not purged but keeps growin=
g=20
> until it magically fits the ogm diff again. Or checking bat_priv->soft_if=
ace-
> >mtu isn't terribly accurate either. The more I looked the more my head=
=20
> started to spin. Suddenly, I was convinced we don't need the check anymor=
e=20
> because we have the fragmentation but you are right - it won't help here.=
 I'll=20
> add the check again but be aware that it is broken.

Right, there is a bug. We should purge the list in any case, even if tt_dif=
f_len
is 0.

Yes, checking tt_diff_len against bat_priv->soft_iface->mtu is probably not
correct..shall we check it against the mtu of the primary interface?
Anyway, this is outside the scope of this patch.


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSIvVXAAoJEADl0hg6qKeOBjYP/iuvT6R2gE212FKSLpoTCI7b
UxEVBKnKMTZkR3Wo6k2NTiiflEMj6mTIUy7ychDT5vAgT17Eh6FPo6CXvD7kiAoa
MGnNHfpBHnLbuSY2TOpaNqNCpk/o59gyiQZN8wA5AzuCcKjaHLimb9mb2pFx+Hru
SLJlAXNJWHZ5RJNv/ps5aOrYTCaye79d9H0iD8cl+eCG/Gm4LFnRUBCAhD5BkFXg
bnbpimC77lka1p0pYaevNX16Ne6ym2EQY1LNgS6hpRxyQd5bjuM8vROxYvcKD+SI
f0si+myqgtR7zBbJ+1BRgh7IEIXiJf789E6J+FfZ4uprpZTXXlvxqqfA89JKQrWn
cv3rbvbh1QiPHWxkfxOMfyLlm37sIG6+vq+tQNnnpjqEVPPPW0cBxuT8wuh9TL7d
eRyL6nCBO74LifysHYUC2Oli/aRamY28zYYBxDMb0dOr/PBCOrm0cnK0b/XGB/zk
IBzzZgOZDbqcQMRIkn1Bdp4C6H20QKwDwLFgiypkFnFNhYEcvhNssozDg84gHeih
na4kZqm6MaR0hj6iuphNevOARPAJ7IU26Q5cO7googbjakfqcgLAmls0PSZ10Fll
BS3VlI/nYP4LkmPGpqtQbQzXZuULPJppN/hDbtpL6ipgjdVP6plvsq0XsDePQLJ2
u9mcOw9a8u0mm6oP1xhW
=o4fh
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--

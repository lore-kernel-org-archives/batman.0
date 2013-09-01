Return-Path: <ordex@autistici.org>
Date: Sun, 1 Sep 2013 19:04:29 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130901170429.GC1871@ritirata.org>
References: <1377790385-24720-1-git-send-email-lindner_marek@yahoo.de>
 <201309011248.44874.lindner_marek@yahoo.de>
 <20130901080543.GA1871@ritirata.org>
 <201309020049.03364.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
In-Reply-To: <201309020049.03364.lindner_marek@yahoo.de>
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


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 02, 2013 at 12:49:03AM +0800, Marek Lindner wrote:
> On Sunday, September 01, 2013 16:05:43 Antonio Quartulli wrote:
> > > Upon reading this function a realized this "tt_diff_len =3D 0" mechan=
ism is
> > > buggy. For instance, the changes_list list is not purged but keeps
> > > growing until it magically fits the ogm diff again. Or checking
> > > bat_priv->soft_iface-
> > >=20
> > > >mtu isn't terribly accurate either. The more I looked the more my he=
ad
> > >=20
> > > started to spin. Suddenly, I was convinced we don't need the check
> > > anymore because we have the fragmentation but you are right - it won't
> > > help here. I'll add the check again but be aware that it is broken.
> >=20
> > Right, there is a bug. We should purge the list in any case, even if
> > tt_diff_len is 0.
> >=20
> > Yes, checking tt_diff_len against bat_priv->soft_iface->mtu is probably=
 not
> > correct..shall we check it against the mtu of the primary interface?
> > Anyway, this is outside the scope of this patch.
>=20
> Checking the primary interface is not enough either. You would need to kn=
ow=20
> how much space is left in the OGM itself (assuming nobody else is going t=
o=20
> occupy it before you do). All registered tvlvs and their content have to =
be=20
> taken into account. As well as headers and other stuff ...

Looks like an interesting problem :)
Moreover, assuming we prepare a "correct OGM" it may be the case that the m=
tu is
changed later (after preparing but before sending it).

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSI3OdAAoJEADl0hg6qKeOk78P/R1A4pbrjZ+RnMmxzsTS56Xr
8Di7Q89maJpaw7UEz8V2Hyqb4h2ik67AlmhmsrxlUHPVG0mTqnKmI/Y3fW83w0Ix
cs38h8guZ3iNS6vW2uU9NHHGujQlC3mE8G0MQFUX3md6maHGgNuzeR6iBKv5Rdlt
tP70omDWZ4dzfa5IbXCgij0IEolPIRPEJlEZkYKoKq6RDlGdfejgi8+yqULFkp25
Aq9DsZOuhQUos51pWOjvUo1l8NsKtWNumHc45U6eXabAd35sh/1hpuiUEFF0gOjf
b4NsFYSfqyoG+mPgoFBoEkCYAcqG+RKmUOJ5SVtJd/JWKM9zacugKuYI/utFfU/s
pYtFjmYhnD0rsMsUQONWoSa9CU8IKsXZukZzfLnijGI47obyO5UQNYBLfKkw26qe
OBMdW3sKdzsjHhiFq4bQBRmRiuTA9MCJ373FcoSgpfJK5GDzTk/WonK7CJm7+EcQ
JpJzth09uZlMeMWoltpvJIMAq5ROyAVoDBeWNwBvKsyGTeXkv+/uldOVfJIvDbfC
IJVlhVYy/2+d0slcgAtK5/Sf44tbb+am7+xhDVkeGVStV36fuSytd/wMxVPWWdcC
tLJ0T15AUirHutkctLIK3Pm+0jm3yyXTu7noVxAHD4DeOGNb0CjWDmhbwbYn3vjJ
m7+AmfpZHtd58GKqUJBS
=kvhB
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--

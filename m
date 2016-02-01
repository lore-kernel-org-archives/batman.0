Return-Path: <a@unstable.cc>
Date: Mon, 1 Feb 2016 10:15:49 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160201021549.GM22112@prodigo.lan>
References: <1454257280-19649-1-git-send-email-mareklindner@neomailbox.ch>
 <1454257280-19649-2-git-send-email-mareklindner@neomailbox.ch>
 <20160201004623.GK22112@prodigo.lan> <8558486.MmMlQ1Pu2K@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TYjWXklH5JTzT8n9"
Content-Disposition: inline
In-Reply-To: <8558486.MmMlQ1Pu2K@voltaire>
Subject: Re: [B.A.T.M.A.N.] [PATCH next 2/3] batman-adv: convert wifi driver
 throughput to multiples of 100kbps
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


--TYjWXklH5JTzT8n9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 01, 2016 at 09:39:33AM +0800, Marek Lindner wrote:
> On Monday, February 01, 2016 08:46:23 Antonio Quartulli wrote:
> > On Mon, Feb 01, 2016 at 12:21:19AM +0800, Marek Lindner wrote:
> > > Fixes: 5c324517 ("ELP - compute the metric based on the estimated
> > > throughput")>
> > >=20
> > >
> > > Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> >=20
> > Maybe before merging this patch you add a one line commit message here
> > saying that expected_throughput is supposed to be expressed in kbps,
> > therefore this fix is required ?
>=20
> As we haven't sent the offending patch upstream yet, you can simply merge=
 all=20
> 3 fixes into "ELP - compute the metric based on the estimated throughput"=
 and=20
> be done with it. This patch isn't for stable ...

Sure, but I was talking about our repository, just to have a better
understanding of this patch in the future. But if you think we don't need a=
ny
description it's fine.


Cheers,


--=20
Antonio Quartulli

--TYjWXklH5JTzT8n9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWrr/VAAoJENpFlCjNi1MRHCsP/jW3WAhlr77hY69YbYhG56eT
Ockd83kl3c2mHBDP64uzFTXY90BfmwrPFcdKhJf6mnvT7yBJWZvsGMiMFKxwCM0r
MlFq67Y/06qhVqc9HTRZ5FdBeWN0Z5fSmAmte5eKhvg2MJECZK58iURLwnrm1tac
W9PbpKAjKCe8STE7pO0Uu7DD2khbs6n9T3uTILNoIoUneUwATEy+pWeZu3Q47bT7
x9u2ohEYmf2kAHJ9JCJiStB/klhNARUmbKvdfMLLE2Wo2uZwyDaPT48J6rAW9P3O
QDn089KNdDTJqsFUecWkVK2R9oiF8d45eFRFp7FGDOjJqRLSemD7SiIb0vz2jH0f
AWX79+gZiU5fSdgpa9ZnWgKRiVcbSafqlI3MBxCNAUAKS4bOnBO3pH5rdyxeL/zA
FfwUkiEnCy+X5+1HLUrJSSzraadKqn2CfGeYqwX4qCq/3QBFpsUo76VVGtMoVtyb
smF/rZWck0VHMa19VOOH412JHzeP3/CI89KC0Wuzh88cD90LVLjkFDj6xJrIHJxA
65C1h1O2JER2XtKhGWBqWI4BvXRGZCGDSn/ddgbfSE9gm/tMDXjMs6C40d9wNjvV
hm6LdBpm8ED+V2DQqLg+WRpav+rYcjseYlo/PRZVZYggtNnmrvW/8k4Ha2pt/sRm
VoqQx0z8BImKTgwjINTQ
=Wl3p
-----END PGP SIGNATURE-----

--TYjWXklH5JTzT8n9--

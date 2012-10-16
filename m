Return-Path: <ordex@autistici.org>
Date: Tue, 16 Oct 2012 08:07:20 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121016060720.GG7023@ritirata.org>
References: <1350244981-14026-1-git-send-email-ordex@autistici.org>
 <1350244981-14026-2-git-send-email-ordex@autistici.org>
 <32156311.f7ZhntrIpV@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="xHbokkKX1kTiQeDC"
Content-Disposition: inline
In-Reply-To: <32156311.f7ZhntrIpV@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: export compatibility
 version via debugfs
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--xHbokkKX1kTiQeDC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2012 at 02:09:23AM +0200, Sven Eckelmann wrote:
> On Sunday 14 October 2012 22:03:01 Antonio Quartulli wrote:
> > Different versions of the batman-adv module may use the same compatibil=
ity
> > version, but this is not understandable at runtime (the only way is to =
parse
> > the kernel log and fetch the batman-adv advertisement message on loadin=
g).
> > The user may want to know whether two nodes using different versions can
> > communicate or not. For this purpose the module has to export this value
> > through debugfs.
> >=20
> > Reported-by: Moritz Warning <moritzwarning@web.de>
> > Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> > ---
> [...]
> > +/**
> > + * batadv_compat_seq_print_text - print the compatibility version
> > + * @seq: not used
> > + * @offset: not used
> > + */
> > +int batadv_compat_seq_print_text(struct seq_file *seq, void *offset)
> > +{
> > +	seq_printf(seq, "%d\n", BATADV_COMPAT_VERSION);
> > +
> > +	return 0;
> > +}
> > +
>=20
> seq is not used? Marek also segfaulted after reading this.

You, know..when you really don't know what to write in the kernel doc...!!
I'm going to change it :-)

Thanks Sven,

p.s. please reboot Marek

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--xHbokkKX1kTiQeDC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEUEARECAAYFAlB8+ZgACgkQpGgxIkP9cwf2lgCXb1Iu2/tFnLWGgd3qMbUvZVil
kwCfdJpulCZFz+zyb3TolozgkdHEvE0=
=odKH
-----END PGP SIGNATURE-----

--xHbokkKX1kTiQeDC--

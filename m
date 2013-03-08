Return-Path: <ordex@autistici.org>
Date: Fri, 8 Mar 2013 11:14:02 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130308101402.GM1400@ritirata.org>
References: <CAP5XTDP_8pCJA8uXpQoMNExiVaCvmBCmkKT_aDErk0qYk7-pmw@mail.gmail.com>
 <20130301110809.GC20607@ritirata.org>
 <CAP5XTDMV9dQucnRpe-fHvKUt-E3RKzEPQcNruG--fA8BnCv7UQ@mail.gmail.com>
 <20130301114300.GE20607@ritirata.org>
 <CAP5XTDNVPDVD_CXUScqc2D8D4+Xh7NFn=4YM6c8aBmjF7Lbi8A@mail.gmail.com>
 <CAP5XTDNdnZ_-BYJ+1ZtXdoBbh1kD0yD+=Cibs3GG4-yyZbSRzg@mail.gmail.com>
 <20130308093341.GL1400@ritirata.org>
 <CAP5XTDM1qdoUM8bhvL1xbWEvurA38SxN2ET4=uQ+vgQ_p_orvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8m/hfNLtAhX2NvnO"
Content-Disposition: inline
In-Reply-To: <CAP5XTDM1qdoUM8bhvL1xbWEvurA38SxN2ET4=uQ+vgQ_p_orvg@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Implement DAT for IPv6
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


--8m/hfNLtAhX2NvnO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2013 at 12:11:42PM +0200, Mihail Costea wrote:
> On 8 March 2013 11:33, Antonio Quartulli <ordex@autistici.org> wrote:
> > On Fri, Mar 08, 2013 at 11:22:37AM +0200, Mihail Costea wrote:
> >> Hi,
> >>
> >> I have created a patch for this, just that is quite big (~ 450 lines
> >> the whole patch, with signature, etc). It doesn't contain complex
> >> changes, just small changes from __be32 to (unsigned char *), a new
> >> parameter to functions in order to give the IP type and added
> >> comments.
> >>
> >> I've tested it with the snooping mechanism I added for IPv6 and it
> >> works ok (the snooping mechanism is not in this patch).
> >>
> >> What I wanted to ask is: it's ok to send a patch this big to the maili=
ng list?
> >> I don't see how I could split it more because all I did is changed
> >> most of functions signatures and edit the code to support this
> >> changes.
> >
> >
> > The common rule is "one change per patch" meaning that if you can logic=
ally
> > split it (e.g. 1) add this 2) use this there and there 3) improve that)=
 it would
> > be better to send more than one patch in one patchset.
> > Remember that each and every patch must compile.
>=20
> I think I could split it into 2-3 parts logically:
> 1. Add the enum for IP types and add generic functions for comparing,
> calculating hash
> 2. Add generic debug message
> 3. Modify batadv_dat_entry  and all other functions to support both IPv4/=
IPv6
>=20
> Some functions from 1./2. might not be used from start, but only
> later, when 3. is done.

Well, looking at the code it is easier to judge :)
Feel free to send your RFC/PATCH to the ml.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--8m/hfNLtAhX2NvnO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRObnqAAoJEADl0hg6qKeOnSEP/iCDdYUlJSy+/TIIWzo2S6kZ
A7s56cE/r7pZ31mUN4ZN5VjckRzNCuHb2tjoE+tcsprbzhfU3KIxOYlqnUhuVOVj
4KVFcdErxu3/+MezcXTjPJWLlGlFcR2IA3Wjsv0s8rtzkqNKvEuCmFKyFauHXgGF
Qv9RMFZQoT88E2W8fGp8ryqJwlJIzfDR67SqN8Ps9NbdVHJ7q97ujTdSedNGZBJP
1FXNTymS95hVmT+k/AS03hWNjO2fykm40RkY1R8EPE25yhShfVhgE7c3OcWN8lCT
uSifx2ihDhFtRsnKoLPwHKF7zJFX4U+Cu3dasOPfIjwsDcEFhGvkARqYOxEiZQM7
LHcmfWDVWpNq9YcgiTKaq0pM3vxnfMtg41V7A1r8wJMnw1fWUOZXh9KQtD1unYcD
JwaaNCtydyP91zys6o0Pr3Gouc9O/O1o5lTi4RZEdyXy7WNIvJvX4c34jEoG3CTb
q4W+qVJkLNyHYJIPz3slj/RdzoF0ueaMEKbdPtcDt8NJrP1M/9ZRaNJhQYA8ipv9
w761jL8pBBvyA5roLoOQedfGQOiNc3hV97XmPaDAM4zhO0b8qtcc3l+06hSdYFTP
F/JRZ8tilTQEViLSGSUo34LKq10xpKwHZClkDHzPibrY05ZOJLlphaasFbS2QDiE
T4tm7eQHLb+O3nZ4BNfe
=mL0t
-----END PGP SIGNATURE-----

--8m/hfNLtAhX2NvnO--

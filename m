Return-Path: <antonio@meshcoding.com>
Date: Wed, 11 Sep 2013 08:46:21 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20130911064621.GJ3979@neomailbox.net>
References: <20130810110303.GA849@ritirata.org>
 <CAP5XTDMWzo8S086mdmHpgKnGCVWtiJvdHWA=KHa5gFV0H_D5QA@mail.gmail.com>
 <20130810203604.GF849@ritirata.org>
 <CAP5XTDOq8qwsD1b7DcsYb3p5sGwnDE301cLuP-_fnYLE+cz5yA@mail.gmail.com>
 <20130909145322.GA3979@neomailbox.net>
 <CAP5XTDPCRj0H3djYsg2pHLDHqSPUqp6faciUF8gpDCOcSp1bRw@mail.gmail.com>
 <20130910053835.GC3979@neomailbox.net>
 <CAP5XTDN4Bzkk4Ek083CJ8nhCqr27BOmfDPsFdCXeFLka-gX9nQ@mail.gmail.com>
 <20130910210146.GI3979@neomailbox.net>
 <CAP5XTDOM-rv02mCHZfMeZhziE6CwAEGNy-S1qsznvxFdXo_3sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HB4mHL4PVvkpZAgW"
Content-Disposition: inline
In-Reply-To: <CAP5XTDOM-rv02mCHZfMeZhziE6CwAEGNy-S1qsznvxFdXo_3sQ@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] [RFC 1/6] batman-adv: Generalize DAT in order to
 support any type of data, not only IPv4
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


--HB4mHL4PVvkpZAgW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2013 at 07:33:41AM +0300, Mihail Costea wrote:
> >
> > this is normal when you have multiple patches: if a fix in the very fir=
st patch
> > of a series creates conflicts with all the following ones, you have to =
adjust
> > them all (this is what the "git rebase" helps you with).
> >
>=20
> I haven't used it before but I will try it now.

git rebase is essential to make changes at a patch series. It helps you mak=
ing a
change in an initial patch and propagate the change to the rest.
This may also be why you are experiencing much difficulty in doing this
operation.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--HB4mHL4PVvkpZAgW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSMBG9AAoJEADl0hg6qKeOuS0QAJm9qN8VYQBrOqSo9A85Qop7
TWgrB+VFC00vN0ofHj7lJaD/yqCyM8kBnnpoDWTqf+KQ0Pb7mqk7dOucq1wvaJee
joBeIwX706vFlgSj1qnSKnCdVkHkzEw1L6EdaUe0Y1ZdLCxqVpPTwnsM6hHwjcFG
jgrqjUJXIyw6CveL7KofEyIUhy+/DHMD6VlkVKtKMMPOgHLenGEPqOYoUJMle4fU
NtyPycAQdOqylHKqSPpqk9FpO8KJ7Vpbj1RM5lv13nnKT/+k4iHDwe+sEvlKDjJX
UOEqpRU6mZSFA8FbPRes2qfLHiibUlci4epUHn2r5mZvg0Z6GyHI3j6cA74avIuB
0sq/nmL4fjWM8fja6GnZQj8qQmCBsiQ5KQdkjM8OLnkGVZQpDkymOLJqTPXgOxMl
KHSE91WwOONVkz2sNoedUyctLA+rTFBOHLwlFJyE8fqChHs2CCoauDFsgumCCG/t
PhmPbHD2927hjw4ioGeTe/4nqQS0X9LT52a+XFguEhCRN/2sy4fSibPDe3hk7UOj
NaPp3gWyP3x1y82zotDZHE5DhVZ1td/az+Zlsi4qqLrixhjVN16pF1ZTGZGnSEG7
tie/nl9j6hda3mhMsHbmbmC4D9ul1AdvcFOReVXLYs9T0xVSpdaaKw07gWzKlSEh
tqGYKYDwiJmkHTr3CXTf
=jU7h
-----END PGP SIGNATURE-----

--HB4mHL4PVvkpZAgW--

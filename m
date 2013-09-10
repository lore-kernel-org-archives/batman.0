Return-Path: <antonio@meshcoding.com>
Date: Tue, 10 Sep 2013 07:38:35 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20130910053835.GC3979@neomailbox.net>
References: <1373242365-763-1-git-send-email-mihail.costea2005@gmail.com>
 <20130810110303.GA849@ritirata.org>
 <CAP5XTDMWzo8S086mdmHpgKnGCVWtiJvdHWA=KHa5gFV0H_D5QA@mail.gmail.com>
 <20130810203604.GF849@ritirata.org>
 <CAP5XTDOq8qwsD1b7DcsYb3p5sGwnDE301cLuP-_fnYLE+cz5yA@mail.gmail.com>
 <20130909145322.GA3979@neomailbox.net>
 <CAP5XTDPCRj0H3djYsg2pHLDHqSPUqp6faciUF8gpDCOcSp1bRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline
In-Reply-To: <CAP5XTDPCRj0H3djYsg2pHLDHqSPUqp6faciUF8gpDCOcSp1bRw@mail.gmail.com>
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


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2013 at 07:35:34AM +0300, Mihail Costea wrote:
> On 9 September 2013 17:53, Antonio Quartulli <antonio@meshcoding.com> wro=
te:
> > On Mon, Sep 09, 2013 at 05:05:47PM +0300, Mihail Costea wrote:
> >> Hi Antonio,
> >>
> >> Is it possible to send the new model for the generalization as a patch
> >> first (the part without IPv6), or maybe everything as a patch as once?
> >> Having 5-6 patches to rewrite every time something changes makes the
> >> development harder.
> >
> > Which patches do you want to merge?
> > If they are ready it is better to send them as PATCH to the ml and then=
 base
> > your work on top of them assuming they will be merged at some point.
> >
>=20
> I took a small rest last week and now I'm redoing everything.
> I was thinking about sending the first part for merging (the one with
> generalization the DAT).
> That is the one that needs most rewriting every time because it
> affects the most existing code.
> The rest I think I can send them together.

I understood. Well, the problem is also that this period is a sort of
"transition" because batman-adv is getting changed in some of its most impo=
rtant
part
and we would like all the "new features" that are not essential to come aft=
er
these changes.
We still need to merge two (or two and a bit) patchsets before we can start
merging other things.

This means that before your patchset gets merged we have to wait a bit more.
I think it would be better to do this:
- for a while you don't care about rebasing on top  of master
- when you have a some code ready to be reviewed you can put in on a remote=
 git
  repo that we can check (e.g. github?)
- we/I review the code so that we make it ready to be sent as PATCH
- when these two (and a bit) patchsets are merged you can do the final reba=
se
  and send them to the ml for merging.

What do you think?
In this way we same some painful rebase cycles, but we can continue prepari=
ng
the code.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSLrBbAAoJEADl0hg6qKeOta8QAIt/zu4E+dnpC5qvzvrM+Z8d
+YJO/TrRjPNiw7Ppaft9ASCah9FcwkB49t8cs+1mbblhVD004F+U5aa+5rQ87dxM
ZOgbeg925nr5aeSBoWEEBucM1Dc88XkYtHyuSh2KPiadpOQYq6xexsN/SJZ56L4R
4MZCFeCfYWOQP3mY/VQaKh78qUz5XEe3ffKpKAdgaxxL7xi9gLbCDSqAeyByFgCg
D2HapGXwk+R5YGjqrYPMItp+Qmimu2fqx7Xp9qDd9bqj4r5nUt/S+I+hA1ym4arZ
ojZj1B5JGJBQDnxebYYQ8nzwSPuIU7WfeEhHrMB7IDv49U428cWkn7xBiVuzY6KC
nxgf/UPES2zZ7kFi/QbDYqPGSf4UQ+QFsusvbYZxeAmTtZp0AHPPPsAMRcS7ZncQ
Via+bdzddehGxFmXnCPjC9y1xZ5BNXTZplki2MX+k0EEq7V/NFFc3QuQViVWEXlu
TPmJLoAudRKE2Ql2xwv7Au6G9utysX83XoXH7a+1VdLDPR7WtpIJ4Yl/D4fPPSYz
b0QpSvvOCtSLVwmKnBy9QDM2TZr2iYlfFnukskyEw2mR9ncGGAP8oSVviJziQP/4
g533s+EbqluewG7MoUkpFXf1zEzPMYie+mMmzQYIKSDmb/SpVC1OlA0zcFRAgGX+
V32YQ7z8byh448rSJYAB
=LSIi
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--

Return-Path: <antonio@meshcoding.com>
Date: Tue, 10 Sep 2013 23:01:46 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20130910210146.GI3979@neomailbox.net>
References: <1373242365-763-1-git-send-email-mihail.costea2005@gmail.com>
 <20130810110303.GA849@ritirata.org>
 <CAP5XTDMWzo8S086mdmHpgKnGCVWtiJvdHWA=KHa5gFV0H_D5QA@mail.gmail.com>
 <20130810203604.GF849@ritirata.org>
 <CAP5XTDOq8qwsD1b7DcsYb3p5sGwnDE301cLuP-_fnYLE+cz5yA@mail.gmail.com>
 <20130909145322.GA3979@neomailbox.net>
 <CAP5XTDPCRj0H3djYsg2pHLDHqSPUqp6faciUF8gpDCOcSp1bRw@mail.gmail.com>
 <20130910053835.GC3979@neomailbox.net>
 <CAP5XTDN4Bzkk4Ek083CJ8nhCqr27BOmfDPsFdCXeFLka-gX9nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="H4SyuGOnfnj3aJqJ"
Content-Disposition: inline
In-Reply-To: <CAP5XTDN4Bzkk4Ek083CJ8nhCqr27BOmfDPsFdCXeFLka-gX9nQ@mail.gmail.com>
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


--H4SyuGOnfnj3aJqJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2013 at 03:45:44PM +0300, Mihail Costea wrote:
> On 10 September 2013 08:38, Antonio Quartulli <antonio@meshcoding.com> wr=
ote:
> > On Tue, Sep 10, 2013 at 07:35:34AM +0300, Mihail Costea wrote:
> >> On 9 September 2013 17:53, Antonio Quartulli <antonio@meshcoding.com> =
wrote:
> >> > On Mon, Sep 09, 2013 at 05:05:47PM +0300, Mihail Costea wrote:
> >> >> Hi Antonio,
> >> >>
> >> >> Is it possible to send the new model for the generalization as a pa=
tch
> >> >> first (the part without IPv6), or maybe everything as a patch as on=
ce?
> >> >> Having 5-6 patches to rewrite every time something changes makes the
> >> >> development harder.
> >> >
> >> > Which patches do you want to merge?
> >> > If they are ready it is better to send them as PATCH to the ml and t=
hen base
> >> > your work on top of them assuming they will be merged at some point.
> >> >
> >>
> >> I took a small rest last week and now I'm redoing everything.
> >> I was thinking about sending the first part for merging (the one with
> >> generalization the DAT).
> >> That is the one that needs most rewriting every time because it
> >> affects the most existing code.
> >> The rest I think I can send them together.
> >
> > I understood. Well, the problem is also that this period is a sort of
> > "transition" because batman-adv is getting changed in some of its most =
important
> > part
> > and we would like all the "new features" that are not essential to come=
 after
> > these changes.
> > We still need to merge two (or two and a bit) patchsets before we can s=
tart
> > merging other things.
> >
> > This means that before your patchset gets merged we have to wait a bit =
more.
> > I think it would be better to do this:
> > - for a while you don't care about rebasing on top  of master
> > - when you have a some code ready to be reviewed you can put in on a re=
mote git
> >   repo that we can check (e.g. github?)
> > - we/I review the code so that we make it ready to be sent as PATCH
> > - when these two (and a bit) patchsets are merged you can do the final =
rebase
> >   and send them to the ml for merging.
> >
> > What do you think?
> > In this way we same some painful rebase cycles, but we can continue pre=
paring
> > the code.
> >
>=20
> I understand, but it should be done similar? Like multiple patches?

multiple patches is always the way to go when we have more than one change,=
 we
cannot mix them all.

> The idea is that I might add some patches and then find a bug that was
> in an old patch.
> That means to find the patch with the bug, resolve it, and re-patch
> everything after it.

this is normal when you have multiple patches: if a fix in the very first p=
atch
of a series creates conflicts with all the following ones, you have to adju=
st
them all (this is what the "git rebase" helps you with).

>=20
> It would be easier to do the changes directly on the existing code
> than restart everything from scratch.

restart everything from scratch? I did not get this.


> I'm not sure if this is what you meant by using github.
>=20

for using github (or whetever else remote repository) I meant that instead =
of
rebasing on top of master every time you have to send the patches to the ml=
 for
review, you could upload your code on a remote repo and have us reviewing t=
he
code on there directly.
In this way you save the pain of respinning all your patches on top of mast=
er
every week..

I hope I clarified your doubts.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--H4SyuGOnfnj3aJqJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSL4i6AAoJEADl0hg6qKeO5+oQAJdt0N47TKxLKo8MAP3SrXp4
h/5pLgJdjX0gbf/r7HUH3aCJTcWePGyLMKWUIU/63PRquFSOQLnZQlVd/+9XREE0
RR2Sx3174COByLytWFnWqwG6nF9a+c4pmzNNx40cJxAVrCgWW3EtVLvJOljnlx+Z
bg4Pp1Z7yx4HkWFy1/Ene0CutF21AzmxN5YYN3wkAYcOZOfVhVblwM8be6eICSUg
0HZR2MYBKF27kG4qElszXt8Dce/ZkT5XxlVSrdPKXBIsPQYi29WXzo7q18khGIs/
OS4jL0nomUlrpJyjZRVB63BDKU4Xed0ub1nGOlR5CJhgLrLXN41wijQ5LMvR9Hu8
xaQDjztelCtsGYV038Ka6pa7oULQ6HccFlX3dVF/naItGro2wCycoLw/3wUc0vil
49CtNPD2ovF/xaxrtC+z39rrSdFYck7Kl2dSWj5f1j9x/kW8fNVX0h4Xrq0xOjJY
JkuwEBcyhsHjAiB9q57ZQZ6CnPZHB+6Y9C4O9NuE/YYL1cxOfCIWHf+VoIVLokVw
Q33YxAFv1GKdtdVjIqYTpt1EqRCkNfWwbbkewZoRS3KMHQN82NyE8m2vt2KvOJBg
AFOdlhjXIcMpTcxBNPHrPdR/MmrdMD1n+FGFCafPd/qLppggDk8F1aHu2VgULNoJ
iS7mOHRhUFKCH91tSXKG
=h/86
-----END PGP SIGNATURE-----

--H4SyuGOnfnj3aJqJ--

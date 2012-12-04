Return-Path: <ordex@autistici.org>
Date: Wed, 5 Dec 2012 00:01:26 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121204230126.GZ27828@ritirata.org>
References: <1371478.oVHDQkQ7OX@sven-desktop.home.narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="oIKd4Ysag+ysiDHn"
Content-Disposition: inline
In-Reply-To: <1371478.oVHDQkQ7OX@sven-desktop.home.narfation.org>
Subject: Re: [B.A.T.M.A.N.] RFC: Removing one indirection layer for patches
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


--oIKd4Ysag+ysiDHn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sven, list,

Thank you for your effort in writing this email

On Tue, Dec 04, 2012 at 10:50:08PM +0100, Sven Eckelmann wrote:
[...]
> So, what happens when something gets rejected or has to be reworked? Yes,=
 some=20
> people have to run around and do a lot of magic. These things will end up=
 in=20
> next (because this is were Antonio is working when he sends patches to Da=
vid)=20
> and all the new stuff in master has to be rebased later on top of the new=
=20
> things in next [did I just loose most of my audience or is this snoring c=
oming=20
> out of my PC?].
>=20

no, not yet :) maybe your fan is running too much.

[...]=20
> The big question is: Is this extra waiting time for new feature patches r=
eally=20
> useful in the current situation and does batman-adv benefit from it in a=
=20
> special/irreplaceable way?
>=20

the added value I see in having this extra time is the that we can spend so=
me
days in testing it, running it on nodes and trying to find bugs. But, to be
honest, I don't know if out there we have people really doing this on a
daily/weekly basis.

> My personal observation is rather negative. Most problems are detected by=
=20
> people using the release and by people checking the patches (on the=20
> b.a.t.m.a.n. mailing list and on netdev... this includes "i am really rea=
lly=20
> angry about what you did" David). But of course, my impressions could be=
=20
> slightly biased. I think Antonio can give more insights about it because =
he=20
> has to squash all the stuff together.
>

well, if I got you correctly the problem here is "only" about time: with the
current method we "wait" more time before sending patches upstream, while in
your suggestion we will immediately (well we could still wait some days in =
order
to let the build tests do their optimum job and double check the code - bec=
ause
yes, I re-read each and every patch before sending them to David..strange e=
h?
:D).

So, you would like a mac80211 like process, I think.

> Here just a calculation for a new feature patch:
>  * Send to b.a.t.m.a.n@lists.open-mesh.org at the beginning of the first =
month
>  * accepted by Marek in the middle of the first month (had to be resent o=
r so)
>  * will be part of next in the middle of the third month
>  * will be sent to David in the middle of the third month (uh, fast Anton=
io)
>  * will be send to Linus by David at the the beginning of the fifth month
>  * will be released as a separate kernel module in the middle of the fifth
>    month
>  * will be released in a kernel at the beginning of the seventh month
>=20

you meant weeks here? It sounds like a birth :)

> Antonio already showed that he can handle adhoc pull requests very well.=
=20
> Therefore, the idea would be to remove the two month extra waiting time.=
=20

I hope you still meant weeks here..or am I missing something?

> Here=20
> are just two random branch names:
>=20
> * next - new patches are excepted here - so it is something like net-next=
 for
>   batman-adv. Antonio will gather some patches and then sent them to Davi=
d.
>   Davids reaction will come heavy and hard... but the effort for an react=
ion
>   is reduced.
> * master - bugfix gathering place. So it is like net for batman-adv. Patc=
hes
>   will end up really fast in Linus' tree.
>=20

To be honest I thought the same some time ago, but I think there was a good
reason to have it like it is now. I exposed my thoughts to Marek (? I can't
really remember) and he explained me why it was nice to have a pre-incubati=
on.

> But I would still say it is a good idea to create releases from next beca=
use=20
> more people will test it and therefore it is easier to get bugfixes to Li=
nus'=20
> instead through the stable queue. .1 releases from master can still be cr=
eated=20
> when necessary.
>=20
> So, why bringing this up now? We currently have 12 Patches in master and =
Linux=20
> 3.7 will be released soon. So switching the patch strategy will not break=
=20
> loose hell. And as a nice side effect: it is not too tragic when=20
> C.A.T.W.O.M.A.N. is not merged right now.
>=20
> But what would it mean for the next release? Hm, the next release would b=
e=20
> created from next, but then we propably have to use some tricks. Right no=
w=20
> master is too far ahead because it has the role of next+1. We would have =
to=20
> move the patches to next (simple merge) and reset master to the release.
>=20
> Further .0 releases would just be made on next and then master merges the=
=20
> release. Additional fixes in master can "simply" be merged in next.
>=20
> Let the fight begin...


Ok, as I stated before, this mac80211 approach is fine with me. I like the =
idea
of a direct flow that goes to upstream without a waiting time in our
pre-incubation repository.

However, I'd like to hear about why we have this
strategy now from the people that decided this (Sven maybe you were involve=
d in
the initial decision too?), because if it is such, I think there is an adva=
ntage
somewhere. So before losing this advantage just because "now" we think it is
better way B, I'd rather prefer hear all the other people opinions.

The advantage I see is that, if we make a mistake and we send a fix, we can
still merge the original patch and fix together before sending it to David.
I think this give us a not negligible margin of error. But maybe we became =
good
enough to get rid of this margin? :)

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--oIKd4Ysag+ysiDHn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQvoDGAAoJEADl0hg6qKeOcH0QAJUgm2VMewumzG6NllJotQub
vcaHuHs18q02H/BWc7DjN1zKm/VUe3ZDI1piFOwpPrlGN2qg9RVmcX7Z3sK04ekg
zapB2RT1LeyFSFTkhCROtqFLyp3+PL5mF8K1f68MBeuO5nHOk2okgv2+9WeJdpTr
Hjc5KulKaIvx4WHD9wRWY51WZJz4AnHnBm1CIR5OFw90IEk4HddkGoOhR7JfytvY
DI7curoM0qEydGrsTFXD4kGUHB3Fq8oqC4DsZqyrgFz0NwiJIpCEEbxArlUNVhTM
cYFW/fK9piuB4ErfuXyBXp25KQvFKsJWhZnzQH+NPHPVUCWMq1CPpJqMfQT7mJG5
Xabpp8J/WxK99soqxZZphkl77UN+IA62v65ZePQjssS45dbKJG7dA/qkopvF2UAE
/F6xhLenCqseSKDOz9MBiAp7O5UCe7Bq7JF/MVJ2DXyv4g6UE/26hfe4GiSzUGe7
9pk74Z+L4nCx5o0X+aoqqJDFy52+hUOdKS8rpjM6vbiX8jIq+IdTyCe3SlqY7Qfi
kkRA4sx5tiKO8WHqpZOakq6u36mxFvSgep5t3HcAIbEGI/1j2oTepm9kCdCrO97C
wYpFoWHexI558Ambz0wGKZORCv21JoZ15Ovgf/YElQA0LTI+5fTytGN1C8BrDAWx
Ms2netoc/AZ/IvGfGEg4
=ZKZe
-----END PGP SIGNATURE-----

--oIKd4Ysag+ysiDHn--

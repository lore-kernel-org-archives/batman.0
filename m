Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 9 Jun 2010 14:06:03 +0200
References: <201006091612.46925.lindner_marek@yahoo.de>
In-Reply-To: <201006091612.46925.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3607513.U9TWQGNASW";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201006091406.10152.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] release cycle
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>

--nextPart3607513.U9TWQGNASW
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Marek Lindner wrote:
> Due to various reasons these minor versions (0.2.1 & 0.2.2) contain much
> more than just bugfixes. Individual features & major changes have been
> backported from the trunk. This has the advantage of adding new features
> faster instead of holding them back for months but on the other hand might
> introduce new bugs at the same time. How to move forward from here ?
[...]
>  * To reflect the new & changed nature of the release, the version
> numbering has to change a bit. The following releases (after 0.2.2) will
> look like this: 0.3, 0.4, etc. We thought about adopting the linux
> numbering scheme but it might lead to confusion as you can use a new
> batman with older kernels.
[...]
> Comments ? If nobody objects we would start pretty soon following these
> guidelines.

Personally I don't see why the numbering scheme is useful here. So just sum=
 it=20
up:
 * ~4 releases a year
 * continuous flow of features/additions
 * no short and precise release goal for version like 1.0 (only something
   like "everything should work well")

I would guess that version 1.0 or 2.0 or whatever would not happen in that=
=20
evolutionary development model. In that situation I am a big fan of numberi=
ng=20
like YYYY.R.B - YYYY is the year of a "major" release, R number of release =
in=20
that year (starting at 0 as we are trve people), B is the number of release=
s=20
for that major release (0 for the first release, 1 for the first bugfix=20
release, 2 for the second bugfix release - this of course only happens when=
 we=20
would have a stable branch).

This was also in discussion when linux was changed to a more evolutionary=20
development model with 2.6.xx - the discussion stopped somewhere when someb=
ody=20
noticed that some build scripts for some important userspace applications u=
sed=20
the linux version number to decide what code paths should be used and that=
=20
they could break if the version numbering scheme would be changed. Some=20
persons started to generate some formulas to convert the YYYY.R.B to someth=
ing=20
like (2+Z).(Y%BIRTHDAY_OF_LINUS).XXXX - but i think nothing useful were=20
generated in that discussion - at least nothing better than nazi analogies.

Linux has also the problem that the version number must be known quite earl=
y=20
(at the beginning of a merge window). So for example the merge window start=
s=20
for the fourth release in the year 2011 at the 24. december 2011 and the=20
release tarballs would get released on 2012-02-29 then it would get the=20
version number 2011.3.0 (2011 started the merge window; release .0, .1 and =
=2E3=20
already appeared in the year 2011; it is the first release of 2011.3. and s=
o=20
no bugfix releases until now). When the sixth bugfix release would be relea=
sed=20
on 2012-06-23 it would still be called 2011.3.6

So it is maybe a good idea to use also the year when start to develop stuff=
=20
for a new release (aka right after a release happens) to have the version=20
number always well defined during a development phase.=20

So I see following as benefit:
 * It doesn't look like we are something as release goal for 1.0 (aka a big
   step forward)
 * it doesn't look like it is in some pre release state
 * the version numbering scheme should also work in 100 years
 * we don't get the release 0.403.0 in 100 years
 * version comparison functions of package management systems still works as
   it is strict monotone starting from left to compare each part separated
   by a dot
 * we have already defined a part for the stable releases

Problems I see:
 * it is more common for distributions of bigger software packages to use t=
he
   year in the version string (texlive for example)
 * the YYYY is "huge" compared to the rest of the version string
 * /please insert problem you see here/

>  * We keep the 3 months release cycle containing new features. All new
>     features go into the trunk first and when ready can be staged for the
>     upcoming release. This way, we won't have major releases anylonger but
>     rather a constant flow of new stuff.

It is still open how the patches in trunk gets prepared for maint? I had al=
so=20
a smaller discussion with Marek about the problems, but there were no final=
=20
decisions.

A small real world example (little bit shortened and changed to explain stu=
ff=20
better):
 * maint is a branch of trunk when we used procfs for all configuration
 * trunk gets gw which uses procfs for configuration
 * trunk gets patches to change everything from procfs to sysfs
 * trunk gets bonding which uses sysfs for configuration
 - sysfs patches get backported to maint
 * trunk gets patches to change parts of sysfs to debugfs
 - debugfs patches gets backported to maint
 - gw patches should be ported maint

So all backporting steps are really backporting steps as they cannot easily=
=20
applied on maint. Different other patches touched their code and maybe thos=
e=20
are available also in maint and sometimes they are not in maint (sometimes =
it=20
is not a merge conflict you see in your version control system, but a confl=
ict=20
you would see during the compilation or when you try to use it). During tha=
t=20
backporting steps are many possible ways to merge the conflicts. Maybe=20
somebody adds/removes a newline, changes the order of independent codelines=
,=20
does something slightly different in maint as he would have done to create =
the=20
same result as we currently have in trunk and after some more iterations tr=
unk=20
and maint diverged a lot.

This is nothing hypothetical as it already happened in our maint an linux=20
branch (involved people were Marek, Andrew, me and maybe also somebody else=
).

A solution would be to use patches rebased by from master on top of maint i=
n=20
my master-rebase repository. But I must know which patches should be applie=
d=20
to maint to get it rebased at the top of the rebase branch... and the actua=
l=20
author must check the patch before it gets applied as I only guarantee that=
=20
the end result (when all patches are applied to maint) has the same files=20
(content-wise) as we have in trunk.

Best regards,
	Sven

--nextPart3607513.U9TWQGNASW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMD4OsAAoJEF2HCgfBJntGrPoQALPRvJLdnGIZbG9+ukEYsTG0
Hk+QyoAUVsdWlFSQ0HuA5JfxdXQFazrue5Z24eSix3Hc0sV+lf1iYOr+FCogF2wz
S2CUoTHhVDOPlzCEDI52wCJsfrRxJLpqKKRmJ6m/bPmNV8lVPSdxIT9osmruwT3m
iGlX7kZIowk3FTFML81eEj4rU+JH6Cr6nq3k68s9ReKAW/MOBxL9SNaVYy5G/hxe
dp6c/IizNca4T7zoDVKytlhrp/sczilJ4V69s4DWYBICUFyg+wSOEPqltKnl/la5
4iZ5u622q2Eg70ekaQj+1+p/jV3v9Ifkxmim8w0OyynWqjXSoYwRQ35RQHjco3HH
9J/mizeXgdYSonOQJj9VwfRcs3lAxcqVn2PBrc9X+rql+nMfsvAuL6GnAhRJIXEe
sbJXpzTViPhP6xjPyxkvDQ2pKJ73a4Upel4AfKwXeTZbmIdLoK2e3+/g+twQ/6Ur
9hTX0cUI6TZYH+gmGUC7LGBjlXIBnFBZ5utQPPKNOU/+Vu3IoMH482CacqNBe37i
cO541gMbHIyBbpBjvp+jik4kDVhRx2HdrX/mbaxcfIfxBCzpCo7ps1zDY1qaYCzT
xqNqL6vuM/gzpvml55ETWQcANNoj32zSusMDEZdG/Nu/CTGnl25drkagCQdhIuk+
7XJpbK1jJdFzm9PkVjDl
=vS4W
-----END PGP SIGNATURE-----

--nextPart3607513.U9TWQGNASW--

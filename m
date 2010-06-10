Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Thu, 10 Jun 2010 21:37:52 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100610193752.GA3718@pandem0nium>
References: <201006091612.46925.lindner_marek@yahoo.de>
	<201006091406.10152.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <201006091406.10152.sven.eckelmann@gmx.de>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

the year numbering scheme would be fine with me, currently i can't think of=
=20
anything which would speak against it and it would represent our evolutional
model quite well. I would vote to apply it.

best regards,
	Simon

On Wed, Jun 09, 2010 at 02:06:03PM +0200, Sven Eckelmann wrote:
> Marek Lindner wrote:
> > Due to various reasons these minor versions (0.2.1 & 0.2.2) contain much
> > more than just bugfixes. Individual features & major changes have been
> > backported from the trunk. This has the advantage of adding new features
> > faster instead of holding them back for months but on the other hand mi=
ght
> > introduce new bugs at the same time. How to move forward from here ?
> [...]
> >  * To reflect the new & changed nature of the release, the version
> > numbering has to change a bit. The following releases (after 0.2.2) will
> > look like this: 0.3, 0.4, etc. We thought about adopting the linux
> > numbering scheme but it might lead to confusion as you can use a new
> > batman with older kernels.
> [...]
> > Comments ? If nobody objects we would start pretty soon following these
> > guidelines.
>=20
> Personally I don't see why the numbering scheme is useful here. So just s=
um it=20
> up:
>  * ~4 releases a year
>  * continuous flow of features/additions
>  * no short and precise release goal for version like 1.0 (only something
>    like "everything should work well")
>=20
> I would guess that version 1.0 or 2.0 or whatever would not happen in tha=
t=20
> evolutionary development model. In that situation I am a big fan of numbe=
ring=20
> like YYYY.R.B - YYYY is the year of a "major" release, R number of releas=
e in=20
> that year (starting at 0 as we are trve people), B is the number of relea=
ses=20
> for that major release (0 for the first release, 1 for the first bugfix=
=20
> release, 2 for the second bugfix release - this of course only happens wh=
en we=20
> would have a stable branch).
>=20
> This was also in discussion when linux was changed to a more evolutionary=
=20
> development model with 2.6.xx - the discussion stopped somewhere when som=
ebody=20
> noticed that some build scripts for some important userspace applications=
 used=20
> the linux version number to decide what code paths should be used and tha=
t=20
> they could break if the version numbering scheme would be changed. Some=
=20
> persons started to generate some formulas to convert the YYYY.R.B to some=
thing=20
> like (2+Z).(Y%BIRTHDAY_OF_LINUS).XXXX - but i think nothing useful were=
=20
> generated in that discussion - at least nothing better than nazi analogie=
s.
>=20
> Linux has also the problem that the version number must be known quite ea=
rly=20
> (at the beginning of a merge window). So for example the merge window sta=
rts=20
> for the fourth release in the year 2011 at the 24. december 2011 and the=
=20
> release tarballs would get released on 2012-02-29 then it would get the=
=20
> version number 2011.3.0 (2011 started the merge window; release .0, .1 an=
d .3=20
> already appeared in the year 2011; it is the first release of 2011.3. and=
 so=20
> no bugfix releases until now). When the sixth bugfix release would be rel=
eased=20
> on 2012-06-23 it would still be called 2011.3.6
>=20
> So it is maybe a good idea to use also the year when start to develop stu=
ff=20
> for a new release (aka right after a release happens) to have the version=
=20
> number always well defined during a development phase.=20
>=20
> So I see following as benefit:
>  * It doesn't look like we are something as release goal for 1.0 (aka a b=
ig
>    step forward)
>  * it doesn't look like it is in some pre release state
>  * the version numbering scheme should also work in 100 years
>  * we don't get the release 0.403.0 in 100 years
>  * version comparison functions of package management systems still works=
 as
>    it is strict monotone starting from left to compare each part separated
>    by a dot
>  * we have already defined a part for the stable releases
>=20
> Problems I see:
>  * it is more common for distributions of bigger software packages to use=
 the
>    year in the version string (texlive for example)
>  * the YYYY is "huge" compared to the rest of the version string
>  * /please insert problem you see here/
>=20
> >  * We keep the 3 months release cycle containing new features. All new
> >     features go into the trunk first and when ready can be staged for t=
he
> >     upcoming release. This way, we won't have major releases anylonger =
but
> >     rather a constant flow of new stuff.
>=20
> It is still open how the patches in trunk gets prepared for maint? I had =
also=20
> a smaller discussion with Marek about the problems, but there were no fin=
al=20
> decisions.
>=20
> A small real world example (little bit shortened and changed to explain s=
tuff=20
> better):
>  * maint is a branch of trunk when we used procfs for all configuration
>  * trunk gets gw which uses procfs for configuration
>  * trunk gets patches to change everything from procfs to sysfs
>  * trunk gets bonding which uses sysfs for configuration
>  - sysfs patches get backported to maint
>  * trunk gets patches to change parts of sysfs to debugfs
>  - debugfs patches gets backported to maint
>  - gw patches should be ported maint
>=20
> So all backporting steps are really backporting steps as they cannot easi=
ly=20
> applied on maint. Different other patches touched their code and maybe th=
ose=20
> are available also in maint and sometimes they are not in maint (sometime=
s it=20
> is not a merge conflict you see in your version control system, but a con=
flict=20
> you would see during the compilation or when you try to use it). During t=
hat=20
> backporting steps are many possible ways to merge the conflicts. Maybe=20
> somebody adds/removes a newline, changes the order of independent codelin=
es,=20
> does something slightly different in maint as he would have done to creat=
e the=20
> same result as we currently have in trunk and after some more iterations =
trunk=20
> and maint diverged a lot.
>=20
> This is nothing hypothetical as it already happened in our maint an linux=
=20
> branch (involved people were Marek, Andrew, me and maybe also somebody el=
se).
>=20
> A solution would be to use patches rebased by from master on top of maint=
 in=20
> my master-rebase repository. But I must know which patches should be appl=
ied=20
> to maint to get it rebased at the top of the rebase branch... and the act=
ual=20
> author must check the patch before it gets applied as I only guarantee th=
at=20
> the end result (when all patches are applied to maint) has the same files=
=20
> (content-wise) as we have in trunk.
>=20
> Best regards,
> 	Sven



--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkwRPxAACgkQrzg/fFk7axZWVgCgiOnaE6lB/CceqxwadmGUEf/b
cfcAnAviFCgbFhoAgrxJ9jW9Hdk1e0zw
=Fu6i
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--

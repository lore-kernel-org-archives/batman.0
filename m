Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 19 May 2013 12:40:07 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130519104007.GA16497@pandem0nium>
References: <D7180917-EB69-44B0-99A6-1F81BC911125@jluehr.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <D7180917-EB69-44B0-99A6-1F81BC911125@jluehr.de>
Subject: Re: [B.A.T.M.A.N.] On compat version 15 in the Freifunk-KBU network
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
Cc: Bonn und Umgebung Allgemeine Mailingliste zum Freifunk =?utf-8?B?S8O2?= =?utf-8?Q?ln?= <freifunk-bonn@lists.bonn.freifunk.net>, Freifunk =?utf-8?Q?L=C3=BCbeck?= <freifunk.luebeck@asta.uni-luebeck.de>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello yanosz,

On Sun, May 19, 2013 at 10:52:01AM +0200, Jan L=C3=BChr wrote:
> Hello folks,
>=20
> I'd like to give some thought's for the upcoming batman-adv release, espe=
cially on compat version 15. This somewhat summarizes my discussion with T_=
X on the wireless community weekend (WCW -- 2013-05-10 - 2013-05-12). As so=
me of you may know already, we're running a small freifunk network in weste=
rn Germany (K=C3=B6ln-Bonn-area) - about ~100 nodes in total; ~40 are onlin=
e at the moment.
> It's not my intention to bash on batman-adv in general or to start flame-=
wars (like: batman-adv vs. olsr or something else) - I'd like to provide so=
me statement on the impact of the upcoming protocol changes.

Thanks for your feedback. Yes, we are preparing a compat bump (actually for=
 a long time now) and it's good to discuss it. :)

>=20
> 1. The upcoming protocol change appears to be painful - we have no suitab=
le migration strategy.
> Compat version 14 and 15 will be incompatible. Nodes will loose mesh conn=
ectivity (to older nodes). Since we cannot upgrade all nodes at once, we'll=
 have to run different networks in parallel.
> In fact, we're running two networks at the moment (compat 13 and 14). We =
aren't able to upgrade the existing compat 13 nodes in the next months - by=
 that, we'll probably have some compat 13 ones for at least 1/2 year. There=
 is no way of telling newer nodes to use compat version 13. Since some "sup=
ernodes" (dedicated servers) are part of the batman-adv cloud, we need twic=
e the servers as well.
> Upgrading to compat version 15 will require a huge amount of work: New in=
frastructure (servers) must be deployed and nodes meshing with each other m=
ust be upgraded in parallel.

We are very well aware that a compat change is a huge burden especially on =
community networks, which have
more troubles to reach all nodes. But the compat change was designed to sto=
p "bumping" the whole network
all the time but upgrading/adding features individually. More on that below.

Btw, it's interesting that you use compat version 13  - only one release ha=
d that included, and we are
on compat 14 for quite some time ...

[1] http://www.open-mesh.org/projects/batman-adv/wiki/Compatversion
>=20
> 2. Backwards-compatilibilty doesn't seem to be a design target.

Actually, that is one of the main design targets. We are aware that with ou=
r current packet type design,
we cannot change even parts of the protocol without breaking compatibility.=
 This has bothered us for quite
some time and we have worked on solutions to prevent compat bumps as good a=
s possible. We have introduced
different means [2,3] to be able to add new features, change features, let =
sub-features update their
protocols (by using TVLVs) without breaking the rest and ensure compatibili=
ty on their own [3], route even
yet unknown packets on their own [2], ... Actually the TVLV thing is pretty=
 similar to other protocols
(e.g. IEEE 802.11) which use that to ensure backwards compatiblity for year=
s. The goal is to keep the
compat bump stable for at least a decade now, if not longer. No guarantees =
of course, but this compat
bump is made to CREATE backwards compatiblity. :)

Note that the compat bump is not released yet but still only in our develop=
ment branch.

[2] http://www.open-mesh.org/projects/batman-adv/wiki/Packet-types
[3] http://www.open-mesh.org/projects/batman-adv/wiki/TVLV

> Looking at other routing protocols (BGP-4 - for example) - they provide d=
ecent ways for protocol extension while still providing backwards compatibi=
lity for the version specified 7 years ago. Looking at batman-adv a lot of =
protocol changes have been introduced in the past years - but no backwards =
compatibility is there. Eg.
> - There will be no flag for using compat 14 version in newer version of b=
atman-adv - if 15 is out.
> - Nodes using 14 and 15 cannot mesh.

It is right that compat 14 and 15 won't be compatible. Backward compatibili=
ty will start with compat 15,
and keeping them compatible will not be worth the effort.

> Since batman-adv depends on the kernel (old batman-adv versions won't bui=
ld with recent kernels) using 14 will not be an option in a few months: If =
some router hardware requires recent Kernel / OpenWRT releases version 14 m=
ight no longer be used.

I think it would be possible to maintain older releases of batman-adv and a=
dd compatibility code for
newer kernels. We are doing the same now to provide compatibility for older=
 kernels [4]. We would
be happy if someone (you?) would take over that job, I guess it would mostl=
y mean to test new kernels
and add a little bit of compat code like we do for the old kernels. You are=
 welcome to contribute
such "stable" versions. :)

[4] http://git.open-mesh.org/batman-adv.git/blob/refs/heads/master:/compat.h

>=20
> 3. Conclusion
> -> Freifunk KBU will not use compat version 15 in the foreseeable future

This is your decision, as you want.

> -> We're aware, that we cannot use version 14 in some months
> -> At the point, when 14 becomes unusable (introduced into OpenWRT Kernel=
s / release we need -- or Debian), we will almost certainly discontinue bat=
man-adv and go one with sth. else. (Due to kernel deps it's easier to run b=
atman-adv / olsr in parallel than two different version of batman-adv)

I don't see that by releasing batman-adv with the new compat version, sudde=
nly your network breaks
- in Debian you usually keep the same kernel for YEARS, and in OpenWRT you =
can just keep the batman-adv
package at the desired version number. The only problem you might run into =
is that newer kernels might
not work, as stated above.

> -> We'd by very happy if someone forks batman-adv to provide modules for =
recent kernels still using version 14

As stated above, someone needs to maintain these compat codes. No "fork" is=
 needed, we can "officially"
host and support that in our git repositories and servers (e.g. having one =
or multiple "long term releases").
However, please be aware that waiting for "someone" might not help, contrib=
ute yourself or (actively) finding
someone who wants to help with that might be better. :)

> -> Maybe, some future version of batman-adv addresses backwards-compatibi=
lity. Maybe, in 2018 we will have a look at batman-adv again - noticing, th=
at batman-adv remained stable (or migratable) over the last years and start=
 using it again. Maybe, batman-adv will fit our needs, then.

You are free to use whatever you want. I think I've made a clear point that=
 this compat bump is designed
to address the compat issues we had. What you roll out then is up to you (p=
ersonally I'd be interested
what you'll use instead) - but I guess you'll miss a lot of very nice featu=
res of batman-adv. ;)

Cheers,
	Simon

P.S.: Note that I'm talking about "we" and "us", but this is pretty much my=
  personal opinion and no
      official statement of the batman-group whatsoever. :)

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlGYrAcACgkQrzg/fFk7axbgmgCfQRMKOachyZ5Y8tj3OaSJqofZ
ZIAAoOmMCqTpRLIGHSSOWzt0qAa4fDa7
=PckZ
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--

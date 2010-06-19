Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 19 Jun 2010 02:49:36 +0200
References: <1275852501-28523-1-git-send-email-sven.eckelmann@gmx.de>
	<20100619000333.GC1128@kroah.com>
In-Reply-To: <20100619000333.GC1128@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2813280.gNEAKAHq46";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201006190249.39204.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Staging: batman-adv for 2.6.36 (renewed)
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
To: Greg KH <greg@kroah.com>
Cc: gregkh@suse.de, b.a.t.m.a.n@lists.open-mesh.net

--nextPart2813280.gNEAKAHq46
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Greg KH wrote:
> On Sun, Jun 06, 2010 at 09:28:12PM +0200, Sven Eckelmann wrote:
> > Hi,
> >=20
> > here are patches targetted for 2.6.36. These replace all patches send to
> > you for 2.6.36 in mails following
> > 1275850985-27105-1-git-send-email-sven.eckelmann@gmx.de due to
> > conflicting changes for 2.6.35 from Dan Carpenter and Javier Martinez
> > Canillas.
>=20
> I could not apply the following patches for some odd reason:
> 	2, 3, 4, 7, 9
>=20
> I applied the others.
>=20
> So you might want to resync on the my staging-next tree and see what
> went wrong.  Does it have something to do with the other batman patches
> I have in my staging.current tree to go to Linus?

You forgot(?) to apply the patches

 * Staging: batman-adv: return -EFAULT on copy_to_user errors
 * Staging: batman-adv: fix function prototype

With those patches it works like a charm. And at least the second one is=20
extreme important for 2.6.35.

You said (or at least a script use by you) that you have them in=20
http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/ ..=
=2E=20
if that is some kind of aggregation from staging.current then yes - we depe=
nd=20
on them. That was the reason why I had to resent all the patches (that's wh=
y=20
there is a "renewed" in the title) - to allow you to apply them on top of=20
those other two patches.

I wanted to sent you some more patches a hour or two ago... had to be delay=
ed=20
to find out what is going wrong here. I will sent them those need also the=
=20
patches mentioned above.

Let's hope that this explains everything. :)

thanks,
	Sven

--nextPart2813280.gNEAKAHq46
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMHBQiAAoJEF2HCgfBJntGq0sQAJ3Muf6tahV4TTkCDGHN/3uo
uxS/MvA4j1ViETanOfVcFSmrEXM6wea2RVZymXDp5hmxKBzrzGDHZXnq4ak2jCg4
j0qAYTbgCFU18603bq1oFsGjMPaCNDC4YsKsIIAOwLkNFUZDjsKG4A53gqm7dkpp
t503bdN1/HY5sG3HVqp6+dwppDPwdweRjdsXCKSPlPjdsb6cvXAd8ac+BtWD/xfg
KrQdpHbPz9jAofPXWA81LNcBPOwWMDg3AT9k14nCW+y8bwSsCaMEd10NCRa0+bCC
RlUpB820ZzMfJot7BSKnKCypa2Cil/o90G88sH5DDchL5SQeLy6HWJ0DqNaGgZXm
3NWMe2pbaxz6dU/RA1dD0ObwjkzhPTQ5eGs1YrmWkmduml7w0KuT2xBKx44e16pA
pFzEcX2fvPfwHLaHuWwGeIX9kPC6qLsP7M8MAT6Xn8DFn1tShZRoYnbVF/3hHWqU
H4D32JMglA0TyRKfXnJlYYxIx/FXcIjCIat6qfhIGDpuiIxMKa+a7zCuOHCDMzVR
oEMrFnWNjPYYQFZYBS1r8qHFFtjUwACfD6AIdrvwwOe6bdaWcDc1yFd++7K6JImE
1smgSkuTlPa3lhG/s+g1HDnKtlRpSk5bu7hsvwsLgrCT4Ztq9Vezk0TDiFD0La9o
BX9OafnohBhlwCdrCsoo
=1dM5
-----END PGP SIGNATURE-----

--nextPart2813280.gNEAKAHq46--

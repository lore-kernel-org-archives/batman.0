Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 3 May 2010 12:30:38 +0200
References: <201005030828.08856.lindner_marek@yahoo.de>
	<20100503080301.GE10849@lunn.ch> <4BDE91F3.4010209@aon.at>
In-Reply-To: <4BDE91F3.4010209@aon.at>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1665012.eWVtpSm6as";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201005031230.45286.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] sysfs compat
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

--nextPart1665012.eWVtpSm6as
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

=46ranz B=F6hm wrote:
> Also all Atheros based systems with binary drivers from Atheros itself
> or SDK's from third party vendors only work with particular (quite old)
> kernel versions. Perhaps you are able to build with newer kernel but
> it's much more difficult to get support from the chip manufacturer this
> way.
>=20
> Using open source drivers instead is not always an opinion because it's
> very hard to comply with radio regulations and get your product
> certified. This is why I think it's somehow also important for BATMAN to
> support older kernels.

Yes, commercial support is a big problem. The atheros driver (targeted for=
=20
2.6.15) can be ported to with reasonable effort to a kernel supported by=20
batman-adv. But as you stated above the upstream support maybe will be gone=
=20
afterward.

=2E..do we really trust devices running really old kernels? There must be a=
 well=20
educated and hard working support team behind that kernel to keep it workin=
g.=20
Not that bugs come over time, but bugs are found over time and must be fixe=
d=20
or otherwise some people will have more fun than you with these "features".

So we have different possibilities, but the most important one should be th=
e=20
requirements of the actual developers. Both Marek and Simon use batman-adv =
on=20
different kernels and have special requirements on kernel versions they mus=
t=20
support.

We can use openwrt as extra information what should be supported. Currently=
 I=20
see kernels from 2.6.25-2.6.34.

To come back to the security consideration: Usually the kernel folks suppor=
t=20
the last kernel only with security fixes and other bug fixes. This isn't=20
sufficient for people which run a specific kernel a long time (distribution=
s=20
for example). As result of these requirements a specific kernel version is=
=20
maintained longer than others [1] ("LTS" if you want to name it in ubuntu-
style). So the lowest kernel version number here is 2.6.27

I am not sure if we really want to check kernels of specific desktop/server=
=20
distributions because they aren't our real target audience and kernels of=20
distributions with a really long support time tends to have more in common=
=20
with every other kernel but not with the vanilla kernel with the same versi=
on=20
number.

Best regards,
	Sven

[1] http://www.kroah.com/log/linux/stable-status-01-2010.html

--nextPart1665012.eWVtpSm6as
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL3qXOAAoJEF2HCgfBJntGUAgP/07mYeRsuqNjMJ6roZhrwKNO
PwgPo2sH3cBkLuWXzLt6Mho4gLsFyn7n71DmbTINolam8U/GivE9buzn/GhLNtbi
Zla1RmLc2ghtnhFf31IuiP3MNjk5QELIsRdJtUkM0BegOtrDT+uO/iCQNanM777F
flZ2uuHfD+AP5fsoV+2Wej9OL4zm01VTB36uDZzarbag9bkWW6FZQuQbf76zt6wO
QH0RwYvuejF2W1y+fML/YWaBFMCpLzjCJ2pd6uieG8wlfGL2cBykfRoFideSSaXy
mdvmFgG8bpatXrmrBANG3pxNFi9vT1UeZApIgxErjFiyoUpKynSo2ZK6VwM31dLC
ksOfAcF8YRqbspNgmJiSZSvz0Qkng9lpcIppuYeZZViueUBahmFC2Bpi30AP0sKO
YnDkwsmTkaejLIy+s4DslHdlyf7D6efIfAAxwkqoNB02j2zvBIdjMvTxWxy0Hn0Z
twLiUL1wMnX7SuWG8OWB8GOMW7At3ZhQ3KKim5SpChS49BDvcDMWr7mmqde/to9X
mQsLTRu36IHi/pS5Sl18fBxgmgDGsJVmm6I/DjiEXEhwxo7Yr3ucBdDc7sCl0BB2
Cbu+RCWTQ0BksAeoZol6PXJmlq11RHZ5j8DVSPWyHV0WJC9rkIcs12ZpRPmDYo2A
xCnm5iWMOcfo6+ysSTz9
=S4i0
-----END PGP SIGNATURE-----

--nextPart1665012.eWVtpSm6as--

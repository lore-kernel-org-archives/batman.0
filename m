Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 20 Dec 2010 21:31:52 +0100
References: <201012181801.14616.neumann@cgws.de>
	<201012201317.52706.sven@narfation.org>
	<201012201909.53042.neumann@cgws.de>
In-Reply-To: <201012201909.53042.neumann@cgws.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4446362.F4muRGDWQJ";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201012202131.53928.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] New BMX website at www.bmx6.net
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
To: Axel Neumann <neumann@cgws.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart4446362.F4muRGDWQJ
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Axel Neumann wrote:
> On Montag 20 Dezember 2010, you wrote:
> > Please take a look at git://git.open-mesh.org/ecsv/test/bmx.git
> > I don't say that it is the holy grail of svn-to-git conversation, but I
> > think it could be a better conversation than your bmxd.git
>=20
> I am kind of git newbie. You are right and I see what you mean. Finally I
> decided to simply fetch the bmx-0.3.x branch from the repository you
> mentioned and offer it as a bare master branch at
> git://git.bmx6.net/bmxd.git .
>=20
> Is there a one line command you used to create this? Essentially I used:
> git svn init http://downloads.open-mesh.org/svn/batman/trunk/batman-
> experimental/
> to create my former repository but obviously this missed some initial
> commits, full names,...:-(

No, not really. I tried different things in the past, but none was really a=
ble=20
to create an useful export. For example the batman-adv repo was created usi=
ng=20
following command:

$ git svn clone --minimize-url --follow-parent --use-log-author -A \
  /home/batman/batman-adv-sync/batman-svn-git-sync/.git/AUTHORS \
  --no-metadata http://downloads.open-mesh.org/svn/batman/trunk/batman-adv/

But your history is a little bit more complex. For example git-svn will not=
=20
resolve the symbolic links - but also svn-all-fast-export wasn't able to=20
export all those things correctly when I tried it. My solution was to write=
 a=20
simple exporter with a static mapping [1] which was optimized for the needs=
 of=20
open-mesh.org. It is a little bit hacky, but at least it solved all problem=
s=20
quite well.

Best regards,
	Sven

[1] http://gitorious.org/git-conversation-svn

--nextPart4446362.F4muRGDWQJ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJND705AAoJEF2HCgfBJntGsTwP/ihkm4RCK2PMLmQYJFCPnWDX
S88Trkr5ITM5YKlr0NONJo2mFga+cFwq/ZuxD4E4r5GnPCyOFvgVC9RnmMSyXs6/
grVYpkvS2YxP2CngF01//W0kVVtLbqoGqx6LpPJ4uzvMad84/GmnVP81vrfaDCsJ
F7eDC5bG8NCPAqvo5vjHgCCmlj1ubVoDifJZii8ZEbi7MdYLGy2xgBojYZQcD+c5
tLLcCms1l39pc2MLmU2iHrynyeVwDDtl2S/e4xZd3tEAPzjPz2n+4U0PHbew7ON1
9j3lvkatdC310XljClyT6aX1zE1UFT2QTsTIje7JRItkfP5uCULi6+YRZt6lrap+
9YlvFbzmgVyP6jkIQdmNG/jCOvp5DJdOc4dEGm4b74jire5c0xgy1fxOyE/uT8qn
gpiJDNxhEMaxJfPJvmiMcrKWbhqXt5hbg1hXiv0kYYQY1EHijNSWKrvdj1pinxA6
wu2/WVM8eDpNczzL9ZQFzgCraMF3NcJCB8AM47EY65xf3+YWbU0UF6erZ6Kr1mth
PvcNNDOqaerOLm7Lk3kK2gxGxUul4hYD8Bgr9YXnHAmkykNenzc2XjOLVtCcJDgl
qsL98/OpgQnzyyfaILfm/VXQnrrVbI7jG76w0WYv3vhq+OaeEoinT8R28cFcX1Fw
w4469iCJL4xYkwcSLq5y
=j55v
-----END PGP SIGNATURE-----

--nextPart4446362.F4muRGDWQJ--

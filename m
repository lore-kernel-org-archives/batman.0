Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 19 Jun 2012 14:12:30 +0200
Message-ID: <2048665.pIykhMOWh9@bentobox>
In-Reply-To: <CAOq9pc52q=p6fnBHWZDionhhAfHgh=oELaHSPO_GErgaDsKagA@mail.gmail.com>
References: <CAOq9pc52q=p6fnBHWZDionhhAfHgh=oELaHSPO_GErgaDsKagA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1994435.jyJagM1fMK";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] batman-adv: NS-3
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


--nextPart1994435.jyJagM1fMK
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 19 June 2012 13:44:37 sebastien bindel wrote:
> Hello everybody,
> 
> I'm a student who implementing batman-adv in the NS-3 simulator. But I
> have some questions.

Just my opinion: I don't know about every implementation, but most of them
were buggy/incomplete and had not many things to do with the reality. So keep
an eye on verification and validation. Modelling and simulation can only work
when done right and many people forget to check their results in an validation
step (validation, validation and again validation).

And you should be aware that you are shooting at moving targets.

> First : To determine if a link is unidirectionnal or not you use the
> Echo Quality ?

More or less

http://git.open-mesh.org/?p=batman-adv.git;a=blob;f=bat_iv_ogm.c;h=1dfe0e497c2e170490e5536a8cbbb0c05b03e0ef;hb=HEAD#l841
http://git.open-mesh.org/?p=batman-adv.git;a=blob;f=bat_iv_ogm.c;h=1dfe0e497c2e170490e5536a8cbbb0c05b03e0ef;hb=HEAD#l878

> Second : To remove entry in originator table you use a garbage collector
> like in Batman III ?

Yes

http://git.open-mesh.org/?p=batman-adv.git;a=blob;f=originator.c;h=fc1ce26ac6275fde1148f06ac9647cf44a2d310a;hb=HEAD#l36
http://git.open-mesh.org/?p=batman-adv.git;a=blob;f=originator.c;h=fc1ce26ac6275fde1148f06ac9647cf44a2d310a;hb=HEAD#l270

But keep in mind that the content of the originator table has MIA entries does
not mean that we still sent stuff to them and only recover after these entries
were removed.

And removing them from the originator table also doesn't mean that an
originator isn't referenced by other structures. This means that the
data structure of an originator can be removed a lot later.

> Third : Why in local and global translation you use roaming, why not
> just remove and add the node ?

http://www.open-mesh.org/wiki/open-mesh/2012-05-13-translation-table-in-a-nutshell

Kind regards,
	Sven
--nextPart1994435.jyJagM1fMK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJP4GyuAAoJEF2HCgfBJntGnLQQAIzGXcx29a7YXlbVIuMzE3mh
cLnrYLkEq9rz2+xoDjuMGu+rWpH2Xs0KQQKmwJ/g6pNdvgfOxuRFbvIg/Lf5+3dz
Ebbhw2lWA4+oDSmKMPIHoFtbftNQvWwkNsufx49DYLLLhlYZ0MBvUwzwjPfeP/F+
/J5HIVZPC1LlVmsTc6plu0CRxb0hT2bS5jvQsZLB40LcoUE7nC7zd0hffbKddf/u
nI7MAJq80ximw3BBtDdZyHOwF8XSAJMVsno3S0GTjl6ndCE+at+xYQ+uM9KFd9eK
xrTjyP9a/jrpAmO8vkfiZ1PUMxLOmpQjFgRehnVrq2MnRRs6dBYX/mZD1HENgTR/
Kr5QAi8Gf8gx7T8neah1p6iOKlBs7iLMOrFD8k/K6sQQJnYT7k7qj05aNgeR6W0K
rBVio8SEHV8e65KBsRFpua2aIOi2mJ+uNuV5Z0AmVEPv2eP5gspJ+6B6kqKeGLEn
vFylUAnm9Wj56mIo4Yb7miiTZ1IDtbxF3pydZFGVoJET0oL1RsVdPGnDYYKAl/sF
nIMsyVdUoFaYFPSyrXQvydKhOF/aMXHkjsyv65UdeiNVnt3J+mjBaTV9+VfhaH8j
3bz+mUom/XtScih0BwzavX41grPqNnldNFwjC2M4poGcgOduCKjHQ08C78lrGi90
c8tru6D4h4RQs7aUZz+1
=oSOG
-----END PGP SIGNATURE-----

--nextPart1994435.jyJagM1fMK--


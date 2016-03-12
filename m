Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 Mar 2016 08:40:57 +0100
Message-ID: <1658500.AjLX8FMN5Q@sven-edge>
In-Reply-To: <3184844.OveG4HdA7g@sven-edge>
References: <1456867148-31883-1-git-send-email-andrew@lunn.ch>
 <20160312044236.GS13448@prodigo.lan> <3184844.OveG4HdA7g@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12461504.BCFGuuSzIe";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/4] batman-adv: Handle parent
	interfaces in a different netns
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart12461504.BCFGuuSzIe
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 12 March 2016 08:34:35 Sven Eckelmann wrote:
> On Saturday 12 March 2016 12:42:36 Antonio Quartulli wrote:
> > On Sat, Mar 12, 2016 at 12:37:17AM +0100, Sven Eckelmann wrote:
> > > [1]
> > > https://git.open-mesh.org/batman-adv.git/commit/fb7b5eb8c81969dc8bea356d
> > > 0
> > > a3f0b5e72d2da49
> > 
> > Sven, what is the README there for ?
> 
> It serves different purposes. It makes sure that the directory is created by
> git on checkout even when there is no patch in the directory. It also makes
> sure that the Makefile dependency glob for compat-patches/* is at least
> generating one dependency.
> 
> But it should also be used to define the rules under which a patch in this
> directory is acceptable (of course, the rules are not yet defined - so I've
> just used a placeholder for this draft). The requirements for such a patch
> should be really high because patches tend to fail when the code or the
> surrounding code is changed. This is also the reason why I've combined the
> critical code to really small functions which avoids more patch chunks for
> more places in the code.

And maybe it should also describe how to generate patches for this directory

   git format-patch --abbrev=7 -U3 --diff-algorithm=histogram --no-signature --format=format:'From: %an <%ae>%nDate: %aD%nSubject: [PATCH] %B' -1

Kind regards,
	Sven
--nextPart12461504.BCFGuuSzIe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW48gJAAoJEF2HCgfBJntG9BgP/jAx8Zb6B8Flkl5qjGssulCd
2gDG96DmFvJsrUdNT3gd8oE8AyfDASYGuSYMicVm4SnevT555X+cmkNhyZiVcSbY
ym84CnzclcRrDpB5KL/pY1E4ee1kTjBpfmv2GMy8Ldrvx1nXTQwtkRaKWH3kIZu1
KS+78VKrpR0erLUmAB86iACEP9bRt5Q91ILF3dyAaXw/Sl8wy/ICbtafZpc2t88p
KQfMo9YzUXgTp+wrZHLUxpsG1HMyTogPeeGu6s74SgP1DZcv2lfqPdbSmxdR5eHM
3uKfmd0MSHB2UBfdY0Mo8v0zYRCDsCpg+8a9QuWUarIOdU+cXkb/bUagYe6SEXVn
KUEfdKmb7eF1vqNviKn7olYtP+F3n/zZaPum7iZH75b0chCQV7eHsq19Eyee6Fmr
YWF6raKi78tMjHudeiuLK5ib8UElyq1oTUqaB3BZqalY0PxmwoSDyINUZAP3WaJt
C/c3493wZBCrPGmBkgSF/qKxBmhnf3+9HGwZsaoGuGedOVV5+D9DWhSbH0sjJL+d
zCeHaPv1TQg/Fp7rFYA4dB+OFog5NKJj7Fi6GIlQjl2e48wHgk118op9l25HZP3G
WuSwDXW0jOASBkkxxNf6oozLAznfi2M/tpyU+bwzMU94T9DOkCz81SX9DRdy/4j5
FaiTDB2tSv2F6MgIzzuF
=3wfQ
-----END PGP SIGNATURE-----

--nextPart12461504.BCFGuuSzIe--


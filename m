Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 Mar 2016 08:34:35 +0100
Message-ID: <3184844.OveG4HdA7g@sven-edge>
In-Reply-To: <20160312044236.GS13448@prodigo.lan>
References: <1456867148-31883-1-git-send-email-andrew@lunn.ch>
 <7555039.bGjIxFaJ0h@sven-edge> <20160312044236.GS13448@prodigo.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12678189.bn9fdzfJit";
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
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart12678189.bn9fdzfJit
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 12 March 2016 12:42:36 Antonio Quartulli wrote:
> On Sat, Mar 12, 2016 at 12:37:17AM +0100, Sven Eckelmann wrote:
> > [1]
> > https://git.open-mesh.org/batman-adv.git/commit/fb7b5eb8c81969dc8bea356d0
> > a3f0b5e72d2da49
> Sven, what is the README there for ?

It serves different purposes. It makes sure that the directory is created by 
git on checkout even when there is no patch in the directory. It also makes 
sure that the Makefile dependency glob for compat-patches/* is at least 
generating one dependency.

But it should also be used to define the rules under which a patch in this 
directory is acceptable (of course, the rules are not yet defined - so I've 
just used a placeholder for this draft). The requirements for such a patch 
should be really high because patches tend to fail when the code or the 
surrounding code is changed. This is also the reason why I've combined the 
critical code to really small functions which avoids more patch chunks for 
more places in the code.

Kind regards,
	Sven
--nextPart12678189.bn9fdzfJit
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW48aLAAoJEF2HCgfBJntGweUP/3i69EP6rvQwExSyWP1A5AU4
jM1mWkO7pgCZ7dvkAkVfPyIviyZvMuw1YdmqcZxYAdjlNi0VWD7WvF8YTzxbfYy5
Pi7uflDVUCBepjckmcuFdIdGQjpQ7s4Esa4X8eabMRgX5A0D46Pm0xOyinYB1P3X
g3HpAblVYolNzpi20M3aQRRQHOIvuoM+vxGChuxns3I9OJ9FdbNA4LfHliCeN7ii
L3r7df75iNnVXWvz4maxP9G8Vh9jeX12qY4M3zoMZ2FU1pcPJOJwOwtzYlFs1WTJ
VIA8G2kF7Jtv6NtXty+1We3kuCUq3mPZYUhfFDC3D1sVQuShoWHec/pEc9vdKsKs
fSJbQTnjTS4HZk6taIrSlHpu0zTNYrMvMnaGgJ33TrTiUBqavn7vOJYNKQ/o0R7m
S6CkJB31cMRZ93cs3YB7drqF/obtvDgQKB9BX0oRH5Ffjtz0UAeA+SvKp2kaWfmK
Jx7uSxybMZMq0DKitGoZSIFGyR+Fk4lm1ZhFy1AWUHjrb1mp1ffAY7fAVJoARhDC
Vee7pXOckXqcziW2+xKeh3fHBCWqQn9ZsaHdrEgIp6Yw3y17upWxyo4BYlPajb1v
xXMCV0K4ms7RMNql5FbZsuV0NXaI+IqjHkJDaSQh8t+Nhmk/2h3GhuiBqdL/LY6r
SeosA+CmjB5y/MiLarLg
=MKdD
-----END PGP SIGNATURE-----

--nextPart12678189.bn9fdzfJit--


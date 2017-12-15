Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Fri, 15 Dec 2017 11:32:05 +0100
Message-ID: <2907097.8HHYkPN8Gn@bentobox>
In-Reply-To: <CAF=yD-KwdPiq7n-ANipF-U56yS85fJbUG7-LPWVBOxGQGYW07g@mail.gmail.com>
References: <20171205143514.4441-1-sven.eckelmann@openmesh.com>
 <5212497.opIP8sI45N@bentobox>
 <CAF=yD-KwdPiq7n-ANipF-U56yS85fJbUG7-LPWVBOxGQGYW07g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2987305.6oRyL08EOE";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC v2 2/6] batman-adv: Rename batman-adv.h to
 batadv_genl.h
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
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Network Development <netdev@vger.kernel.org>, Jiri Pirko <jiri@mellanox.com>, LKML <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>

--nextPart2987305.6oRyL08EOE
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 6. Dezember 2017 11:58:14 CET Willem de Bruijn wrote:
[...]
> >> > ---
> >> >  MAINTAINERS                                        | 2 +-
> >> >  include/uapi/linux/{batman_adv.h => batadv_genl.h} | 6 +++---
> >>
> >> This and the previous patch changes uapi. That might break userspace
> >> applications that rely on it.
> >
> > I am not aware of any application because all (alfred, batctl and some gluon
> > integration) of them currently ship their own copy because distribution didn't
> > catch up. And this is also the reason why I want to do it now - not later.
> 
> That assumes that you know all applications, including those not
> publicly available. It may be true in this instance, but it is not
> possible to be certain.

I've just talked with Simon. Because you have a problem with these two 
changes, he suggested that I should drop these two patches and merge packet.h 
with the uapi batadv genl header batman_adv.h

Kind regards,
	Sven
--nextPart2987305.6oRyL08EOE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlozpKUACgkQXYcKB8Em
e0Ywyw//SDo/DofSQqXel1MhXacXuw9d9KPa3Y0zopXUpGVdXo4Jes2V/Xt2tw2L
6DFSMJSbbFH99bqJWS509Wyw9IACCBgQw+XNDmxs42BD5OZw+IJkY/uK+PHYxGmz
UALXCAYmOlSn7qUQEAd4Fp3Ed6IHHOb8YwKOXKq0kCJbfvy+5Slk91WaiOevhqpZ
iAz0whR+Pt4rJaFRjpANuz4WF0BLlc8s66A80rZN3ESWlLLXl/5J7V9Peete+eGM
WaXIXdkmQ4DBmBrXRjiBeyLjOENzIAhahXhywRaDoxASmDx/RpIufszKPjcy0O/E
Tgh2H72KR7ed1LNN57H1vAxkyNujkVyspCssI6IzPvOWN6cupNnwxDGescqmQahy
uzSg6rYb/pbTIHsMgWCVUEzDWfOayfjJ5M1aT26XCVjlP0ah+cbZJOyEhWVLr5JN
qIX152x95tS3Ew8fQsTEcDJSAbsDhMjx3wtziqKnF2KQQ1rz1Mtm0otxgBGLbLDh
HZrgRasEO2w/uLGQG2SGNVJvN4iuDNbMmagiaGtb5eH+DZc8R+SNA6Ue5MIzHZlY
CsE/dBCK7HX0UhnMPjiIp2wgota0j8KA7W5PRcK712EmsJt1Ob5RRsdvy7WiPWu4
PDiLWoY+y5c7p4xCbfiCKuCwV5X1opZuPgtgRqATaJK3rBL3OX4=
=iQqz
-----END PGP SIGNATURE-----

--nextPart2987305.6oRyL08EOE--


Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Fri, 15 Dec 2017 12:48:39 +0100
Message-ID: <1780732.fBLghQceHc@bentobox>
In-Reply-To: <2907097.8HHYkPN8Gn@bentobox>
References: <20171205143514.4441-1-sven.eckelmann@openmesh.com>
 <CAF=yD-KwdPiq7n-ANipF-U56yS85fJbUG7-LPWVBOxGQGYW07g@mail.gmail.com>
 <2907097.8HHYkPN8Gn@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2987314.yNFMV7ihjb";
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

--nextPart2987314.yNFMV7ihjb
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 15. Dezember 2017 11:32:05 CET Sven Eckelmann wrote:
> On Mittwoch, 6. Dezember 2017 11:58:14 CET Willem de Bruijn wrote:
> [...]
> > >> > ---
> > >> >  MAINTAINERS                                        | 2 +-
> > >> >  include/uapi/linux/{batman_adv.h => batadv_genl.h} | 6 +++---
> > >>
> > >> This and the previous patch changes uapi. That might break userspace
> > >> applications that rely on it.
> > >
> > > I am not aware of any application because all (alfred, batctl and some gluon
> > > integration) of them currently ship their own copy because distribution didn't
> > > catch up. And this is also the reason why I want to do it now - not later.
> > 
> > That assumes that you know all applications, including those not
> > publicly available. It may be true in this instance, but it is not
> > possible to be certain.
> 
> I've just talked with Simon. Because you have a problem with these two 
> changes, he suggested that I should drop these two patches and merge packet.h 
> with the uapi batadv genl header batman_adv.h

No, this is also bad because batman_adv.h is MIT license and packet.h is 
GPL-2. So what other name would you suggest for packet.h? batman_adv_packet.h?

Kind regards,
	Sven
--nextPart2987314.yNFMV7ihjb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAloztpcACgkQXYcKB8Em
e0ZiFw//QaPYCzX3/xVyCkkNaZsM5KCDsbFJYMBWXUu3BKHeG+QoHFCsu6yNkBzq
bEZJ+2Nh8vJIW1ddTBhhdLPPG7VyrDyoeXpst6LNG92AVH0gR2Ok9f6wObxfonDU
E2wStoKOZHbX/0LyFqD9WqK9UoHeAlMD0uAedVZZcC2JrcSldkClPuo3lZHCOt9p
SWaqDebqXHRk4BQPz9f49u+bFvZHNIEIy15Qe71zjhlzpmou5dq0R4MyHfCKWtEk
EpMxgSkXrZCpvBinqnkeTtUo11bbe9oQDnkosBQHGQnHJWIFEaakegOE/QxLnm/H
3nei7FmY6x2EvAUbquvNnzU0JdgqhSsMMENFEWT2dR8G1Y/90VyOxtwQuN4Ugaci
jVZGjTPrW9DzGBNlylRpF2ts9omqIEYKGpv93nRMjraPHRdvm6Wtax1hDx/TVgjC
fc2ntzKpg2y6JASJfhzfgexJT5fC43TtjQF0UFDBwccTbocJFKZ5TJSyOiabqsss
dDEhzAWibIZBJf24sFB8YRCm0w+XUOZfMRHqMqE9b1555QZgDGVZI6J57y7bfQUZ
Q7DBtCoTHBentI5AKYtDUuTSPP5Jl6ig6pq5jwlkAsCsGeLsEZURqgqB6AZw10j9
cDrv9XDhqm1PXEQqU5/2RejjUNdSUdQgmKgjUPvYD7AX+GTuymA=
=16a6
-----END PGP SIGNATURE-----

--nextPart2987314.yNFMV7ihjb--


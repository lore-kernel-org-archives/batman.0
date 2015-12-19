Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 19 Dec 2015 23:19:12 +0100
Message-ID: <4650990.dzNuZYpWV8@sven-edge>
In-Reply-To: <56753ACE.1070302@unstable.cc>
References: <1448901241-30844-1-git-send-email-sw@simonwunderlich.de>
 <1831238.xY0O8bfIys@bentobox> <56753ACE.1070302@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7885245.OZSt7uS4RG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint] batman-adv: fix lockdep splat when
	doing mcast_free
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
Cc: Simon Wunderlich <simon@open-mesh.com>

--nextPart7885245.OZSt7uS4RG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Saturday 19 December 2015 19:09:02 Antonio Quartulli wrote:
> On 19/12/15 17:32, Sven Eckelmann wrote:
> > On Saturday 19 December 2015 09:04:05 Linus L=FCssing wrote:
> >>> From: Simon Wunderlich <simon@open-mesh.com>
> >>>=20
> >>> While testing, we got something like this:
> >>>=20
> >>> WARNING: CPU: 0 PID: 238 at net/batman-adv/multicast.c:142
> >>> batadv_mcast_mla_tt_retract+0x94/0x205 [batman_adv]() [...]
> >>> Call Trace:
> >>> [<ffffffff815fc597>] dump_stack+0x4b/0x64
> >>> [<ffffffff810b34dc>] warn_slowpath_common+0xbc/0x120
> >>> [<ffffffffa0024ec5>] ? batadv_mcast_mla_tt_retract+0x94/0x205
> >>> [batman_adv]
> >>> [<ffffffff810b3705>] warn_slowpath_null+0x15/0x20
> >>> [<ffffffffa0024ec5>] batadv_mcast_mla_tt_retract+0x94/0x205 [batm=
an_adv]
> >>> [<ffffffffa00273fe>] batadv_mcast_free+0x36/0x39 [batman_adv]
> >>> [<ffffffffa0020c77>] batadv_mesh_free+0x7d/0x13f [batman_adv]
> >>> [<ffffffffa0036a6b>] batadv_softif_free+0x15/0x25 [batman_adv]
> >>> [...]
> >>>=20
> >>> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> >>=20
> >> Fixes: 5b95c427d187 ("batman-adv: Annotate deleting functions with=

> >> external lock via lockdep") Acked-by: Linus L=FCssing
> >> <linus.luessing@c0d3.blue>
> >=20
> > I am confused why this should fix a commit which is there to find s=
uch
> > problems.
> Am I wrong or also the commit message is misleading? Looks like it is=

> "fixing" a bogus lockdep check...but as far as I can say this patch i=
s
> making sure that the lock is held in that particular point.

No, it doesn't say this anywhere. It says that it fixes the "lockdep sp=
lat"

> If we want to "fix the lockdep" then we should remove the
> lockdep_assert_held(), but I don't think this is the goal of the whol=
e
> discussion.

No, the lockdep check should not be removed because a lock is necessary=
 for=20
other situations when this list is modified as explained earlier [1]. Y=
ou have=20
multiple concurrent calling contexts for this function (hard_if_event w=
ith=20
something like mtu update + something like batadv_iv_ogm_schedule) whic=
h=20
require exclusive access to this list. Right now it is just protected b=
y a=20
weird "named" lock (from the translation table and not from the mcast).=


And no, the solution here is not to add a special codepath which (for n=
o sane=20
reason) requires no locks or synchronized frees - even when this seemed=
 to=20
have become the new trend in the batman-adv codebase.

Kind regards,
=09Sven

[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-December/013=
876.html

--nextPart7885245.OZSt7uS4RG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWddfgAAoJEF2HCgfBJntGa3sQAMG+4AmQ5otj/qOZsKbfRds0
O1dhcGgv7kN2Sq/FFEVFnthzfjzCpjm/KFd65Ni/flHm9c7wjMYveIclV9QxrF3U
Cfl43ONR/NB5cmGeVKizQ5pKR1LY8BocUfDJZ8inpFMK2zddMKEhgwwE+xsFuR6p
VsJw3ylzHMzet/YpSf0v66SIDDUzWL1WhQK/266IglCqtOgT7eoTlGpKBFZoFwmy
d96K2uXQfWWL66oa2UJzzPPmiCzlBU4CB1TjXNl8HUPvXu85vZHqZfKWVqQ92OXq
2hUfAmvQm1KHV0+CQIzW7Bor6SBmxT48HU/5K1ll6NYzj2OCKqKq3MoDuxxLHSKR
UA/LPhIIvDEyrNLdgF02R3vsznLbs72jgZ2t3sOaT9MitThJ3O58ssD+EmeQMJja
h026ufP1hDCkdO+oqdpy5NyV1lCqQoMIyxqHk8bBHjcjWh9k7uKp1SVrq0H6chMc
F7ZaE3HhEsHthkwNwtJ1e0IGzafQhrh+cKJXjoFhL1R2gV14GtMugayWU75HhT/f
XLgN6ThXow3pWi5PVbwwLG6b/bymi088CWso62xTJ3IRbsT+JTcvHhs4XacdbLAS
AtGA7zMKAVLDIjh9ITYfYrPrjhKJalYgaZt6GMFyH1uudkO7oUGefmmrQH1Wvcde
uWdTB5loxAouAS2rsDmT
=spI5
-----END PGP SIGNATURE-----

--nextPart7885245.OZSt7uS4RG--


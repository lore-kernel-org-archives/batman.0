Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 20 Apr 2016 09:02:19 +0200
Message-ID: <2521671.9Fin875K0z@bentobox>
In-Reply-To: <20160420023640.GB13247@lunn.ch>
References: <1456867148-31883-1-git-send-email-andrew@lunn.ch>
 <1812177.9NXi5yCt0r@prime> <20160420023640.GB13247@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart14912020.8zSfoXafh3";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 4/4] batman-adv: debugfs: Add netns
	support
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

--nextPart14912020.8zSfoXafh3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 20 April 2016 04:36:40 Andrew Lunn wrote:
[...]
> I agree about debugfs. As i already said, i've played with netlink and
> netns. I changed my debugfs patch, so that it only creates files for
> the default netns. For all other netns, debugfs operations become a
> NOP, and you need to use netns.

Ok, so you already have some new patches. I will therefore mark the current 
patches as "Changes requested". The alfred/batctl patches will be marked as 
rejected because they would have to be replaced by something else. It is not 
about that I think they are bad but just because a different approach is 
preferred.

Kind regards,
	Sven
--nextPart14912020.8zSfoXafh3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXFyl7AAoJEF2HCgfBJntGLEcQAIvcYQ7gIp7RAvieEmqro1Se
sD2q8oWlG8/piDlLkU3QiHC7vVjNadLmuqpUe5aR0H//+tBSmtC03h3nnDCiDZ+k
wJvVqEfWCt+AdNuY+bJIBqRlgvcjGIMJNS76RnnCoNhYojrw9lbk7X/pTg/UB9Ay
yWjojTeJCHc6sZYEse6IkPTYf/WUBj4y1fp4wKDg73hfuRHwWrxPgGyTcLCl5nPg
cSyHXE1GWQUPivQZMG3Ex7vDawwFEM2XMXgipL2E6s/W+1J2Nr9Z4tI+N/FQ8X1t
TIouVBFbqnztdsec3fC7/6ETenk+faOV/BReFu13wM7yGjXyBKh1G7yztdKAk5O4
4Puutsg+nJfgNlHylwU3ICoEdhlkALkEm6P2IesvR6olS9gszh3Kqv+jQW3aok77
kR+iJ4EvXKFu+BBIf0e6uslwOyzLgzFMyUy56OGmBH5yII+OT55ZuQmoIMwU25Qe
3qcpsKpxTmHG405TI4GQHJkuWbCxlU42JOEOpEi0xKgjZBf1g43qMhb2W+v69GHp
EKQpEzlMMjeeA7xqk2jdVKwnfOKzWZbeRZY3ZKatfe0PCx0LSLmyIVuDHh63lX9l
zmjgikKfP0MQzelhTI76ZEkwe6K7dXSOLGeiHxO1eis0L5yMEtuLWMDcImDrrqm1
z0UuoxvApAKaPjmUveBE
=crHl
-----END PGP SIGNATURE-----

--nextPart14912020.8zSfoXafh3--


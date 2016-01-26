Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 26 Jan 2016 14:25:48 +0100
Message-ID: <2491450.9MRC2rtVoA@bentobox>
In-Reply-To: <20160126125314.GA25892@prodigo>
References: <1453312110-32683-1-git-send-email-andrew@lunn.ch>
 <1453312110-32683-4-git-send-email-andrew@lunn.ch>
 <20160126125314.GA25892@prodigo>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2449541.0MIbegyrYn";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/4] batman-adv: Handle parent interfaces
	in a different netns
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

--nextPart2449541.0MIbegyrYn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 26 January 2016 20:53:14 Antonio Quartulli wrote:
> On Wed, Jan 20, 2016 at 06:48:29PM +0100, Andrew Lunn wrote:
> >  /**
> > + * batadv_mutual_parents - check if two devices are each others parent
> > + * @net_dev - 1st parent
> > + * @parent_dev - 2nd parent
> > + *
> > + * veth devices come in pairs and each is the parent of the other!
> > + *
> > + * Return true if the devices are each others parent, otherwise false
> 
> Andrew, minor style issue: you should put the ':' after the word Return.
> Please check the other comments in this file as example. Sven recently changed
> all the comments to be coherent with this style.

It is not about being coherent but about kernel-doc being able to parse it.

Kind regards,
	Sven
--nextPart2449541.0MIbegyrYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWp3PcAAoJEF2HCgfBJntGZbgP/jGHQdxSavyFW1BGdaua01Yr
nNzEhvEgf7Bw8Oawz4tF5xARHoVbZZbJwuO6vX/5mMPL58ZAVmzL5xV2A1rrOJzE
/R0r7zkeYYiWmaEgBtaoW0UECsVPVb5DQumj+gsdsp8vb67d8ektZwQPpuNPcWlJ
ESLTGyq6CqLp9qwqvf+arTJA9lj8oXCIDo8oyYWEoOuXE9FiRM9j+0y82BxtYLJK
qp/YDh3/KXb7U9tUJpl3STbrvlI2J69Ae9fmshwBdLUwHII8GQdLvsaSoQozN6ts
6/6mVnPX3NCzQtc7+aAZd1aI47p7cMsK9C7YWJQDzc/v3peywsY2j5DX1ND/DbjA
ScM4oFP3++DVzn+SNMcNeYit9LHUc2Zityk7V+fUWEZn98FJEIJuzLAer3ac33v/
i5z/FPjEt+W2fkZwDNVd8YvfzoHGnosFhz2kTM8ZkfCY4dg8WYqZSx+JdPQcJ+Zy
Lw2BKnjW5etyOKB2RzBxiy2fPg1RN7KlZgMspKb9MU1ZjfVTHxK7IOx3+bk/V+qM
LF3eRILc7wPV91GYWEO7KeawtVEBWHpJHIy42YMn05l3KpUSe8i/OaN4p7DGnB4t
vlbubnuoY+J7Jwfi89lXWp5kuhKvcItd4SNNBTaShIS65N1sRF1AZBhy+ZqQ6z7W
Z8P4nXh+fXV/gP3Q+tqz
=gueU
-----END PGP SIGNATURE-----

--nextPart2449541.0MIbegyrYn--


Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 07 Jun 2016 14:22:34 +0800
Message-ID: <1849136.LrSZmxXkLW@voltaire>
In-Reply-To: <2131546.qoGWqglCpc@bentobox>
References: <20160525152736.9031-1-a@unstable.cc>
 <20160525152736.9031-4-a@unstable.cc> <2131546.qoGWqglCpc@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1771030.MBdKjPYlVU";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 3/6] batman-adv: statically print
	gateway table header
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

--nextPart1771030.MBdKjPYlVU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, May 31, 2016 19:50:46 Sven Eckelmann wrote:
> On Wednesday 25 May 2016 23:27:33 Antonio Quartulli wrote:
> > To make it easier to search through the code it is better to print static
> > strings directly instead of using format strings printing constants.
> >
> > This was addressed in a previous patch, but the Gateway table header
> > was not updated accordingly.
> >
> > Signed-off-by: Antonio Quartulli <a@unstable.cc>
> > ---
> 
> Reviewed-by: Sven Eckelmann <sven@narfation.org>

Applied in revision f8fa1cf.

Thanks,
Marek

--nextPart1771030.MBdKjPYlVU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXVmgqAAoJEFNVTo/uthzA3sYH/AnbmqmYpQWMEiiv9pA/+lPl
oRP8uEJ3XTDLXmQamESqmmubFjM3QpWHJkadg7pKK4uQ/qDRHrdqH9C5sM9a5G1q
P5fD+nBIKT1w7RDqi5CsLQykrOfqk33euGd6yi+Oj7748Um01nH1fXqgjNenCmY6
oS2/6Wn3GQMPVWd/WFuRlrcH+MvfCUGA/zlROXcsMOIHqdvZYj5Xd7TA4INWXt0j
arhQKfzSRTkpPfXc1qLhmBYlNLEJkdKflQc+95cXl9lQ99rdz1iZGmckbajZqK+I
pc4V2TyQGT8CSAhJJ18LgNZOQlBYOuSOoPxRp2ZBmoEjIARsBgfiJvWB4tXgnWI=
=42Oq
-----END PGP SIGNATURE-----

--nextPart1771030.MBdKjPYlVU--


Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 May 2015 00:11:52 +0200
Message-ID: <1941799.temDJMhclT@sven-edge>
In-Reply-To: <20150516221537.2a6fad9a@i3.local>
References: <20150516221537.2a6fad9a@i3.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13018165.ATJUBWEdeP";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Patch which fixes a uint32overflow ;
	fix algorithm which was unintented changed on 2014 update
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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


--nextPart13018165.ATJUBWEdeP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 16 May 2015 22:15:37 Ruben Wisniewski wrote:
> Changelog
> 
> * fix overflow of uint32-value while multiplying
> * restore algorithm to origin calculation which expect kbit/s values
> 
> Signed-off-by: Ruben Wisniewsi <ruben@vfn-nrw.de>
> ---

Please read
 http://www.open-mesh.org/projects/open-mesh/wiki/Contribute
before submitting patches.

And please also include the commit which caused the regression. This makes
it easier to find out which kernel versions must be patched in case the
problem is critical. Here is an example how this information should be
included:

 http://git.open-mesh.org/batman-adv.git/commit/210a3cb5a5e09f0067386fd07b3a7a843fcf66c5

Kind regards,
	Sven

--nextPart13018165.ATJUBWEdeP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVV8CqAAoJEF2HCgfBJntGd4AP/iGf1MMmga3QVwd5+m6sx5pM
wT+Y5X+cHy2WzDByLtFXGDQ5tBFoM1WiitbveLann2fde9mGNQGoZ90ttxPefpE8
EPFZIhZwlmvaBElAEVzhRwSXfDeoaPCJdcyVu6HOVTAd94f5ZVscv85efbTExq+1
ilHHBk0VzarBhHRAlC3rFyDjHqykm564ZBgrXK9zzptsBqHz8ZvkksjHoUK0Nqgp
6gRmAXVdciTb23Fbj5yed1CIhotSzrnjJc/HJlAtcCQhepOl22FdO9rKUijPMx0M
P0V9wxTwfX0EP64CLbx0YEg71m+X1Pn+QXN2cjNxxRAC18NYAcoQeY0HpfqebWRI
nXr8qEQ9uyTA67s5HSEhSlBGSOn3okpyrT9eEu7atH0rblXjEaVVmTUb6xB7IG3x
itwudObv0T0p+pQELQUuqwarlkW5rcFgsOUsPPmtJzSxPzyT05MuR0mrblBosebz
pCWW6u9GnpUcaqovb9XFDHImRE8PTJw5gPGNdsW5V7OMrFNpwUyufMBB57MO9ei+
7eJAu3ksLKC14zvBg0r8Zw5iVOV+jCqlrA+bczQyKprv5XCCHmBfkUuG43K5/vks
Khv8w5mGbUD0i3F4IB3mi4xB1/q1tWCmZyF7p3KknrVpW0qV4s9qaj2RAgy0+N9q
clZYy1Shg/cYOJ4lafJT
=IUxI
-----END PGP SIGNATURE-----

--nextPart13018165.ATJUBWEdeP--


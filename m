Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 26 Nov 2012 10:40:07 +0100
Message-ID: <2094937.nutMCHjP7e@bentobox>
In-Reply-To: <20121126093309.GB22729@ritirata.org>
References: <1353867811-8452-1-git-send-email-sven@narfation.org>
 <20121126093309.GB22729@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1516776.d638hlgyCm";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/5] batman-adv: Use common Jenkins Hash
	implementation
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


--nextPart1516776.d638hlgyCm
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 26 November 2012 10:33:09 Antonio Quartulli wrote:
> On Sun, Nov 25, 2012 at 07:23:27PM +0100, Sven Eckelmann wrote:
> > An unoptimized version of the Jenkins one-at-a-time hash function is
> > copied all over the code wherever an hashtable is used. Instead the
> > optimized version shared between the whole kernel should be used to
> > reduce code duplication and keep bugs at a single point.
> > 
> > Only the TT and DAT code must use the old implementation to guarantee the
> > same distribution of the elements in the hash. The TT code needs it
> > because the CRC exchanged between the mesh nodes is computed over the
> > entries in the hash.
> Hi Sven,
> 
> I don't fully get why we can't use this new implementation in TT. What's
> wrong with the CRC computation?

The in kernel implementation will create a different hash sum -> tt entries 
will end up in a different bucket -> CRC will be different (please correct me 
about the last step... just had this problem in the back of my head).

Kind regards,
	Sven
--nextPart1516776.d638hlgyCm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQszj3AAoJEF2HCgfBJntGOaYP/0aI4vV+nQpxFfeFsUqHTOoP
q8RxXcoQy1pVGo+qPirV5MjaUJVU2mRP4O5XjFJtwrvvq2G9aOnf6VYsdqr0QKRf
kctQLwGiH8jIdulDtuN6WiLbWQUsxEAVonI4x/sjy4s6v1Lz09Q4fjMRbGSgHic2
yuupKjR+ncvd6R5fREtVh+h7n69bJkjPJVJBNPFPQVElRdeqJcI8hi0IJW86Kknd
4Xq6TbMu6jntgIsFAXM2nK7NWjUXwk9DVCNtYB9To1cqCRYaqy7YMMF9NskFZb8c
H2mO4PEfskPa/Xp9wykf/5jLcFc8irrYczl6mPgJ3k6BShTODHwIdMAESXbGmwtl
dJzC5uzCl9e6VcP4GHZKUXIMm0eDptoR6wh/WS9i5burwE2yslFDcJ34rPmxvIpU
uzAh1mK4iE42pDN1nHY6OOgfCWz+Tgik0rG/JLgc6k7y4XkNmEsSdTtRwSEvCDkI
betOn43ihOfreP0HQ7up4kHi4n2oYVaU+PWUgT32HeUJ9DKI+b6hl1OZBPT9rpjG
O1UdqRCSQQFh3+HmQ8Qfc77+ybTiKQRAQe2veOcpR3z/jx6TfgTuX5WuEOQa+Gnb
xLBRkFJphL3V8oMg1Uqw0zCLaRTE/3911yQX8rr2inV1I5wu8TQ8SwBeevZUxiz0
L5pGGwNdR1quPY5l5V09
=9DE4
-----END PGP SIGNATURE-----

--nextPart1516776.d638hlgyCm--


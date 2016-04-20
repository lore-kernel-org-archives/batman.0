Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 20 Apr 2016 13:39:01 +0200
Message-ID: <63530210.JnDNrLx53s@prime>
In-Reply-To: <20160420023136.GA13247@lunn.ch>
References: <cover.1458231707.git.mschiffer@universe-factory.net>
 <3565172.dz0c0eMaPu@prime> <20160420023136.GA13247@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8164710.XM4ZBEgVBS";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC v2 0/5] batman-adv netlink query API
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

--nextPart8164710.XM4ZBEgVBS
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hey Andrew,

On Wednesday 20 April 2016 04:31:36 Andrew Lunn wrote:
> > > The following files are still missing:
> > > 
> > > * gateways
> > > * bla_claim_table
> > > * bla_backbone_table
> > > * dat_cache
> > > * nc_nodes
> > > 
> > > Obviously, documentation is also a TODO. Comments about the API design
> > > are
> > > very welcome...
> > > 
> > > Regards,
> > > Matthias
> > 
> > Hi Matthias,
> > 
> > thanks for reposting this and sorry for the long silence. Since we have
> > the
> > namespace work from Andrew now which would require netlink support, I
> > think
> > its a good time to integrate this. :)
> 
> Hi Simon, Matthias
> 
> I picked up your patches and played with them when combined with my
> netns patches. All works well.
> 
> I also started on integrating the user space code with batctl. I've
> got as far as integrating netlink user space code for what you had,
> and i added gateways, and started on bla_claim_table.
> 
> I'm on vacation this week, and i'm not likely to be reading emails
> again this week.
> 
> I should be able to post code next week.

Cool! Thanks a lot for picking it up, I'm looking forward to your patches and 
will make sure to review them. :)

Thanks again,
     Simon
--nextPart8164710.XM4ZBEgVBS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXF2pVAAoJEKEr45hCkp6hz4gQAJTN0AxCJlXC7vbZK8HOBrvY
u0D+ELqOWOkLoi2ifrORPsuc9eZ9hzH0wJ+1qcxah6kzqdfNcTtQ25LnyrQvBP0U
xQFyyaqroKYIc1QQzaptC7djCKsUgX5x2XQsQHJXp2Q/myM+Utt24rtFd2TvUeq+
/dM9LyL3WkiEXopiNgQTAMBWCW6ubpqiph7I8QN7/2MHqdRfjLKysl12fTnLarG2
IJ8b8bSBHFIIj916j1r0p49xuj7LdjGzb6XbjW2PUz5OB/+woEv3pXsoOZmyuoC1
qD7pQadE/qJY1EvC9lXZTFEQb+WJaF8T1QJHE3s+HtA32L8Ar1jhs0JsPJsfhBJk
Db3v/6CmomW7KrMdTdKg1smarapCCL0IaZ23SXaLOeYG/7PZMdpQJUlQwgocliXe
yjIfFz+ohckIhkPtV/PEmSjuiI9P3ApOuEBnANivM8olBOX05v33TtSuI9+PYcZh
Nps2upc9r/x+WVefiguf7RZXrhOw3E7VfK8w8K7bgg44tAz+SK0Y/kRitVU0qOTr
ucRbkvm3qqwklngClejLbyxVOck/5pefMAnJIvASw5MOSAOQ3jgLLSaTsop6OIPn
8dVZONgQqhUNwPGdcVx7xWdvpLYbhKwAbFbycXAFej0K6mN56mOyklF4Tw0Pmf7d
TRaXpvexANfhWOtxgXrv
=bTr6
-----END PGP SIGNATURE-----

--nextPart8164710.XM4ZBEgVBS--


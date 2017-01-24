Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 24 Jan 2017 17:09:39 +0100
Message-ID: <1860403.1ETbzszp8C@prime>
In-Reply-To: <1485272132.2398.4.camel@sdl.usu.edu>
References: <1484884864-7315-1-git-send-email-jhaws@sdl.usu.edu>
 <1899098.CrQhkxgaNY@bentobox> <1485272132.2398.4.camel@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1624737.IpWfhFjuPn";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4] alfred: IPv4 multicast distribution
	support.
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, Jonathan Haws <Jonathan.Haws@sdl.usu.edu>

--nextPart1624737.IpWfhFjuPn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, January 24, 2017 3:35:33 PM CET Jonathan Haws wrote:
> > > @@ -273,10 +276,15 @@ static struct globals *alfred_init(int argc,
> > > char *argv[])
> > >  			return NULL;
> > >  		case 'p':
> > >  			sync_period = strtod(optarg, NULL);
> > > -			globals->sync_period.tv_sec = (int)
> > > sync_period;
> > > -			globals->sync_period.tv_nsec = (double)
> > > (sync_period - (int) sync_period) * 1e9;
> > > +			globals->sync_period.tv_sec =
> > > (int)sync_period;
> > > +			globals->sync_period.tv_nsec =
> > > (double)(sync_period - (int)sync_period) * 1e9;
> > >  			printf(" ** Setting sync interval to: %.9f
> > > seconds (%ld.%09ld)\n", sync_period, globals->sync_period.tv_sec,
> > > globals->sync_period.tv_nsec);
> > >  			break;
> > 
> > This doesn't seem to belong in this patch.
> 
> 
> Yes, that is correct.  I must have fixed that formatting when I was
> going through everything else.  Would you like me to take it out of
> this patch?

Yes, format fixes should go into format fix patches preferably, not into 
patches adding functions. :)

>[...]
> > > 
> > > +
> > > +	interface->netsock = sock;
> > > +	interface->netsock_mcast = sock_mc;
> > > +
> > > +	return 0;
> > > +err4:
> > > +	close(sock_mc);
> > > +	return -1;
> > > +}
> > > +
> > 
> > You only close sock_mc on errors but not sock?
> > 
> > And please chose something better [1] than err4.
> 
> 
> I see why you'd want me to rename the goto - however it was chosen to
> differentiate between the err goto in netsock_open.  I called it err4
> since it is for the netsock_open4() function dealing with IPv4.  Would
> err_ipv4 be better?

Why not just using err? Since its a different function, I don't see why not 
re-using the label. Actually I would prefer that ...

Cheers,
     Simon

--nextPart1624737.IpWfhFjuPn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAliHfEMACgkQoSvjmEKS
nqGtCBAAro7Zqo3k0b3D6726x5UNbLAhEDwVHo2+A3XUNb7wk5XW0iz59IXUkxbe
tGLfDA3AdLS7OfAsne64Pwsui8/9dXDK8Wmtp2absvGzcFH9gcUF1lSqpec523lH
IapnW4L2d5SpgkNFC9gFTRadYsOmn4KXpRDWtRiPw98iGfue3K6Q+42lJfCgfsxb
7xwq6W8jS60/e7fwLzOoPgwKi0gUBRWlh25/Pvhjyyh1oH0gFkrUrRtt1InnflrQ
FHAMMUfmeq2FzJxWkqnb91upkc2kq0R99rb3LROgjzywK79dtqMjVqmtz13x+7S3
55qVYCdazqnIRyTyau5vyWGoPMIXzAobrqUwBZDUWrMFAAcn/82+poFV8LWwfOtU
Ylsep1DuYFNl1F1fAV1j/YJ3tZbkKcWLev8orQoQekp9Dfq5dc6Uzc5LN/o4UYcW
nX6OqA+2qmahVXvomGb67H5ta6/gUyeAKuNrfTCYIBMosu9gDZ0aDHB9yv3LI98D
Urn276pO/KF8iEoK2DqR6CgF0hE/ccNnMgqpqgJ3obqop8vGR0FQ72n5eNBrS8XS
Ue/OH6aiInbQPF9NhzWyQvJhMA7pdbRsCxvBbhPuhFg3eve/diqsDPPBEIPGilZm
7MYPm4myBpJfd+oBDO4loMGxjYhuH2GpUHahnPvvtFkwNwCsxao=
=pfiC
-----END PGP SIGNATURE-----

--nextPart1624737.IpWfhFjuPn--


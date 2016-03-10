Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 10 Mar 2016 16:09:18 +0100
Message-ID: <26995374.rRgDESDE4R@prime>
In-Reply-To: <20160202022512.GE12673@lunn.ch>
References: <1453953196-29943-1-git-send-email-andrew@lunn.ch>
 <23082646.VzubcaWY7q@prime> <20160202022512.GE12673@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart56064770.1KDuAo0AFg";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/3] alfred: Mount debugfs before
	reducing capabilities
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>

--nextPart56064770.1KDuAo0AFg
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Andrew,

On Tuesday 02 February 2016 03:25:12 Andrew Lunn wrote:
> On Fri, Jan 29, 2016 at 01:14:53PM +0100, Simon Wunderlich wrote:
> > On Thursday 28 January 2016 04:53:15 Andrew Lunn wrote:
> [...]
> > > @@ -160,6 +161,9 @@ static struct globals *alfred_init(int argc, char
> > > *argv[]) {NULL,			0,			NULL,	0},
> > > 
> > >  	};
> > > 
> > > +	/* We need full capabilities to mount debugfs, so do that now */
> > > +	debugfs_mount(NULL);
> > > +
> > > 
> > >  	ret = reduce_capabilities();
> > >  	if (ret < 0)
> > >  	
> > >  		return NULL;
> > 
> > Can't we remove the other calls to debugfs_mount() ? I see 3 more calls in
> > alfred ...
> 
> Yes, the other calls within this binary are probably failing, due to
> reduced capabilities. I can remove them in a v3 patch.
> 
> 	Andrew

Are you still planning on sending a fixed patchset? :)

Thanks!
    Simon
--nextPart56064770.1KDuAo0AFg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW4Y4eAAoJEKEr45hCkp6hJd0P/iLt/6W76x4fiptNgSnapQet
UBQ0k2DjLkjWvViJ05M7FtXBRmIvUAzq7tjGoETuVcMKB7h3/uAU9XWID8viNt1v
ISlRf4g4s+CKRkXBydaAvdA2o57vIyrA7CuxJzRTbCXypL/GYzvuuIglpvTW+3pd
kedWdoB87WN2L2iOQh7g5k2Pt/OeP9/L7F/QfXgCvCpzTvXvRWfT9JFz0xH+6F+o
oYhP6na7cCyhhWuFn3uF9sr+TxLKfbbUe2BTYDc4kthu3eGoJFIoUMY6gC3S/t3Q
db1z0oEEhuZa6BcFSYwnyZKYxxjZkQ9xaq1M1kL1jJ8Pr357KUVbOHLZsCU21mDp
845z6N4CjE+IfBQ7K2cCVP7T2LunsnmZMx7WeWQZGqN7oSt4SQeovzfZeK4zzxMq
P0a4TsWu2OV8uuobiUEXoc0jWX+7DkzLAtdPnDHliPZyvjyEDsjgR1eXMXTOe2R8
TAFfqX1JZ5X1B3H95aCdXjAOt5aOORR1rIM5pMTFg8t0/Wj/z5HfpW++TDDN9H8p
CCiuC4B1onGzI++xU+W4Rxd8OX3ssGci5ue99NZMsM4aLuYdfMXTR/c6DyKA8i6E
lTyPPRi5xk4yJIPk0oNqElU7ElepuNcT6Whv2TA0gkc9Oc2VWPjnks8H0KEkCvhK
hWn7/1yY2ZVlxNxikU4R
=iyzT
-----END PGP SIGNATURE-----

--nextPart56064770.1KDuAo0AFg--


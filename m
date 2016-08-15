Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 15 Aug 2016 17:09:52 +0200
Message-ID: <2969743.vKtXFVpVX2@prime>
In-Reply-To: <1471273146.4556.6.camel@c00941>
References: <1469738596-10972-1-git-send-email-jhaws@sdl.usu.edu>
 <2051990.AEtJ42fJkW@prime> <1471273146.4556.6.camel@c00941>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2222581.Z2kqzSEd1b";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: Externalized synchronization
	interval
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Cc: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart2222581.Z2kqzSEd1b
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, August 15, 2016 2:59:05 PM CEST Jonathan Haws wrote:
> > > ALFRED_INTERVAL is now externalized via the -p option (synchronization
> > > period).  If specified as option, user supplied interval is used,
> > > otherwise the default interval of ALFRED_INTERVAL is used.
> > 
> > [...]
> > 
> > > --- a/server.c
> > > +++ b/server.c
> > > @@ -372,7 +372,7 @@ int alfred_server(struct globals *globals)
> > > 
> > > 
> > >  	while (1) {
> > >  	
> > >  		clock_gettime(CLOCK_MONOTONIC, &now);
> > > 
> > > -		now.tv_sec -= ALFRED_INTERVAL;
> > > +		time_diff(&now, &globals->sync_period, &now);
> > 
> > 
> > I believe this at least deserves a comment, or must be made more clear in
> > the 
 code.
> 
> 
> This change simply does exactly what the previous code did - subtracts
> the interval from the current time.  It utilizes the existing
> time_diff() routine to account for nanoseconds.
> 
> If you need me to resubmit with that language in the commit text or in a
> C comment, I can do that.
> 
> Thanks!

I was staring at your code and time_diff() which was implemented for an 
entirely different purpose, and concluded that you could be doing the right 
thing ... ;)

But yes, please re-submit with a comment explaining that, or restructure 
otherwise to make it more clear. time_diff() was written to get a difference 
of two timestamps, not to subtracts times from each other, and that confused 
me.

Thanks,
     Simon
--nextPart2222581.Z2kqzSEd1b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJXsdtAAAoJEKEr45hCkp6hmoUP/1EKQ3W0aM6a3vCzUGqVgiwb
oEVTO9aV9kLESZJ8ekCsZEnfuJ3PMJeyEblLzuVkqsSSccKXjaulty3N2lTLwLne
7/vCsotY8V1vl1afq8hi6/03Z949oaEy7DF1jmY6oDVOQa000t79wbp1gtzSKYSx
Hn62NhGxkUMsiRo8ho5CXp9wvFOkLSHpMXm/sIHxNeVgRRlwAivD/XhBpMFUVZrs
jISV8lA1xnyTnO0ts2pCrZ4EKJg3acuD6HcTPxwH1Q6qnOF0jk7xKAcfOKfhg3mL
v44BDNdDW357zS1ZeZ5q4f9UvXzYW/RlGwg3iEw+QkyQwJPDUqt3KhGhboi/Z85c
XAIHjzv8z3o5WEEJN89Jgd50K0ydu+lkrata/NNRb4M/0GGGx9dvndJDx3q3+uIr
51aqYxpUBv5fjsW0gYqVwq+A/vgbN8ok+xMx5bkVoAg06DFC5Lt+i5yOgYlm1u3n
I+EXWFYub1gIEZNU9FXxYOInab3z/6GzV9xN6QI+2Pe/YabejJhQ2wacAZaHiDc1
0IS55ntggIHg4Le3fvx4nusxzypWb8ZQQjXrsdeJDCl9hdO0+1q7EDksFcZB9osN
EsBhvDeimQMGOY2vb1f6rCBgQddYnm61VJnJLVKuwxdML4GbTKpaz+CeHiEI8pQq
LEUQHgfkIWofojP0kbpY
=OpnM
-----END PGP SIGNATURE-----

--nextPart2222581.Z2kqzSEd1b--


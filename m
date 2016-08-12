Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 12 Aug 2016 10:20:41 +0200
Message-ID: <3133024.CixFyg0uHR@prime>
In-Reply-To: <1470859151.4736.17.camel@c00941>
References: <1469738596-10972-1-git-send-email-jhaws@sdl.usu.edu>
 <2339296.p0oRt0exUO@sven-edge> <1470859151.4736.17.camel@c00941>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1546794.XZGupMXkr5";
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
To: b.a.t.m.a.n@lists.open-mesh.org, Jonathan Haws <Jonathan.Haws@sdl.usu.edu>

--nextPart1546794.XZGupMXkr5
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, August 10, 2016 7:59:12 PM CEST Jonathan Haws wrote:
> > > +			printf(" ** Setting sync interval to: %.9f seconds (%ld.
%09ld)\n",
> > > sync_period, globals->sync_period.tv_sec,
> > > globals->sync_period.tv_nsec);
> 
> > [...]
> > 
> > > -			printf("announce master ...\n");
> > > +			printf("[%ld.%09ld] announce master ...\n", 
last_check.tv_sec,
> > > last_check.tv_nsec);
> 
> > [...]
> > 
> > Are these two things just relicts from your testing code?
> 
> 
> Yes and no.  I left them in because I figured they were useful additions
> to the main code.

Hmm, I'm not sure if I like the format, but I guess we can keep it for now. :)

Cheers,
       Simon
--nextPart1546794.XZGupMXkr5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXrYbZAAoJEKEr45hCkp6hhTUP/0qLml6K8hfEwrpm6xdahjXj
IA01AIQi2Zn9QHnsc5R9P4aB+xP7zm7uxuVmUwWMQr8op5vBK9FjkmMOMpPFnocy
bBAuBR/hbfVgi+Zyw7sNfpS+G2ggFNTUbrGuy4I+pXhOhNyXbRPElib6onVQvyPN
0TwiyzvAbafCPI+GE5hcWxdFUYJ1bz4FPI+YOUcmWFNPu3WzzjRnZh69ttxdHtjA
jq6Iu++CnXMczJ38Y5ByTC9LbHaWn6tYjxH5e39Cfyso087zBBopNAAw1klqqVeT
kJ+7y3R7x7VMqZKXkWs5zHTKIWzKmuvJB3kqaLAnkJNxCQ1cRWZZT7+n9Us1Yhxj
AgB+vC8EnC8OyJ1Lxe9Rkiam2pGmiBb7Seo1groXqRIdMywVLTfEYE6glHddT6hx
hvVWxdeGpSzklPq0fsjWvD8mz7K6LDLMUycBKfI+Cmvgb9tjo2P/mH5ofcNOuUN0
A9cTX6cDqJGIYqWLtXF1PgbPxPDJV1isbI1Zk284UNOolaWtc6UJGVwUe2LBqVcR
zoYrthH28LuK5r2zDjoIxXTwjriiQrrlAXWe+g3W3cKrMwTZjMLR91FIhgm3E8tn
oljaa6U03sANoWd8DhfEYDCXGcb0+Ws1zzQYCQ7auZOiuw6d/rMEW6JoI95mJ5xA
f+aQ6LWsc6rZIfwcxcG2
=yb5g
-----END PGP SIGNATURE-----

--nextPart1546794.XZGupMXkr5--


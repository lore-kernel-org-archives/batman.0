Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: can't find logged information
Date: Fri, 07 Feb 2020 18:07:38 +0100
Message-ID: <1851274.gzzsXW5Q3G@prime>
In-Reply-To: <60314915-68db-93c4-c35f-0a593015c7ba@coolheads.com>
References: <24aa48bb-8f52-78be-28df-98ec2e2a054b@coolheads.com>
 <1594276.uRpPO4E4fP@prime>
 <60314915-68db-93c4-c35f-0a593015c7ba@coolheads.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8548500.x2kMUfdS7Y";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: srn@coolheads.com
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart8548500.x2kMUfdS7Y
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, February 7, 2020 5:59:27 PM CET Steve Newcomb wrote:
> On 2/7/20 10:52 AM, Simon Wunderlich wrote:
> > Oops, you are right, we have actually removed that command in 2019.2. You
> > can use one of the two following commands:
> > 
> > cat /sys/kernel/debug/batman_adv/bat0/log
> 
> The cat method works.  Thanks.  Wow, with all the debug info selected,
> it's a torrent of stuff.  (Which I expected.)
> 

Awesome

> > (will be removed in the future when debugfs support is dropped
> > 
> >   trace-cmd stream -e batadv:batadv_dbg
> 
> Uh, *which* of the two above commands will be dropped?  Should I add
> trace-cmd to my menuconfig to retain access to the logs?  I haven't
> added it yet.

the /sys/kernel/debug/batman_adv/bat0/log file will be removed in the future. 
So yes, add the trace-cmd 
> 
>  > By "works" you mean you get useful outputs where the timeout is not
> 
> increasing or similar? can you still "batctl ping" to one of your neighbors?
> 
> You are far ahead of where I am.  I meant only that I was getting what
> appears to be useful information, not that I have interpreted it.  It
> will take me a while to figure out how to read it.  I would be grateful
> for any hints on that, and I'm already very grateful for the help you
> have provided.
> 
> I haven't been using "batctl ping" to cue a reboot; I've been using
> "ping".  I'm not sure what difference it might make to use "batctl
> ping"; it seems to me that if I can't "ping" a node, after 3 or 4 trials
> over a period of 15-20 seconds, I'm no longer in touch with it in any
> usable way.  When that happens, as long as I don't reboot the gateway,
> everything just stays offline.  So it's better to reboot.
> 
> By the way, at least one user is using the mesh for landline telephone
> (Google Voice) service, so I'd really like to stabilize it if I can.

So in iw station dump and and batctl neighbor table, there is a "last seen" 
field or "inactive time". Usually those fields should be < 5 seconds or so, if 
they rise then it means this station has been lost somehow.

The difference between batctl ping and a regular ping is that the batctl ping 
is actually implemented INSIDE of batman-adv, so it will be used to ping a 
certain mesh participant. Therefore batctl ping relies on less "moving parts" 
such as correctly configured IPs, MAC address translation, etc. If batctl ping 
works but regular ping doesn't then we know something on the Ethernet 
transport part is off. The other way around (batctl ping doesn't work but 
regular ping does) is pretty much impossible unless the user does something 
wrong. If batctl ping to a neighbor doesn't work, it's likelythe Wifi layer or 
something else is exhibiting problems or batman-adv is not set up correctly.

Cheers,
       Simon

--nextPart8548500.x2kMUfdS7Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAl49mVoACgkQoSvjmEKS
nqFR0A//Qqk2RMpRlhDIO7lIhrYwKR0YTlAPTsVkF1z9JWWyS58DqY2ap/WjJA1o
U//py/75hk8Kcudy+PzAI/jPq6bkZLuZnabG16y58Qo+IOA4LAwPtKqkLUcOtvDx
tiY7nIXFbTXUMS1Kx4ihTJCQucFBa8UaczvmcQjFkz7kRHwXtY/crhE8FoNHMZY/
15eORkT0OHqci5Len4JgZdzzrkca0Ukbs5nUskVr1avsl+yavErQ2gkrKMrFsZLS
b9JUSL8sq5gUPD9f9BzOtoj7kB9mWh8qmSJFFSgB01qIoG6/2moXhKop6D+9nRJS
Bgf+kJsqnt0jUWEgHyv1YIK4CXUcIIxE0kB3WX8q7eXJ8LAFson8ULswWhjqFXm5
euYcZ4DBX6GUdpWZ72y7jpXrCZl9ouHb8RJOQZnfrSoZjK/u62uAi6A2btog6ffg
iCh+fZM6etNVfWQmb4gpxlPJpq8ojhNOnfgstpMryZqSax7QUVRNudNAlOaClD61
6ph0h86S2wHZMTITHuT4q3P/locwr7Rjh3KhU/QV1MKoQf9ZnVFUzZZJwMbtLI50
nQaKjTBQlOg7mQs5vv+mJ4OFNEagn61amDCID75KeXX3LSMJXhQGqwOpfpe6RUSU
fZT8XmWztfgVOLU0/Z22P8VV/y+6Jb7KB2rxusJFKOmToMgg2Us=
=pgQK
-----END PGP SIGNATURE-----

--nextPart8548500.x2kMUfdS7Y--




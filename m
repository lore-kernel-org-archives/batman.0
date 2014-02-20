Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 20 Feb 2014 18:33:49 +0800
Message-ID: <53576640.B8QRQyvXn3@diderot>
In-Reply-To: <5305CE85.6020201@meshcoding.com>
References: <4F5A043B-6BFB-46F0-9D14-BDF07F2533E0@gmx.de>
 <20140220090903.GF11878@lunn.ch> <5305CE85.6020201@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1904117.NgN9rU9EpP";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Suggestion for routing improvement on poor links
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart1904117.NgN9rU9EpP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 20 February 2014 10:44:37 Antonio Quartulli wrote:
> The missing degradation is the part where I don't agree.
> 
> Just to be sure we are understanding each other, I am talking about the
> scenario depicted in this picture:
> 
> http://www.open-mesh.org/attachments/download/52/triangle.png
> 
> 'A' is the source node and 'B' is our destination. B moves and breaks
> the line-of-sight with A, thus making the A<->B link unusable at all (we
> assume that now packet loss on A<->B is 100%).
> 
> At this point A still receives B's OGMs via N1.
> 
> According to batadv_iv_ogm_orig_update() (in bat_iv_ogm.c) each time a
> packet with a _new_seqno_ is received the global window of _each_
> neighbour for the given originator is shifted by one slot and the
> averages are computed again.
> 
> This operation makes the average degrade because we are now averaging
> N-1 old values and one 0 (with N being the size of the global window).
> On the next OGM it will be worse: average on N-2 values and two 0s. And
> so on..
> 
> Doesn't this mean that the metric is degrading (consider that the metric
> is the average)?

Your explanation is mostly correct - one minor objection though: Values of '0' 
are not considered when the global average is computed (bat_iv_ogm.c line 73). 
The idea being: The unilateral degradation of TQ values without any network 
event will eventually lead to loops.
Nonetheless, the general idea of your statement still holds true: Since new 
sequence numbers keep coming in via an alternative, albeit less optimal route, 
the stale route will be purged as soon as the global TQ window has elapsed 
(default: 5 seqnos). Long before the neighbor timeout has had the time to 
purge the neighbor entirely.

@Andrew: The algorithm always worked that way. In fact, it was your suggestion 
to reduce the global window to 5 seqnos in order to speed it up. 
Furthermore, ELP only improves reaction time on a local basis (single hop 
neighborhood). Network-wide route updates are as slow as before which is why 
we had to devise yet-another-improvement: RIP
http://www.open-mesh.org/projects/batman-adv/wiki/RIP

Cheers,
Marek

--nextPart1904117.NgN9rU9EpP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTBdoQAAoJEFNVTo/uthzAGX0IALoHH5DPka/trh9wQZuP6Lz3
UBME2qJsUT8sh1Wdb3EzDamM9pCrv3PnwbddU5TlFDHdqsNPdwlrYnVms5Hh6DSI
ZcdYgOGjYLRZihLF6MS3phQinD+yOPuNr49Xlzwc57n2BJLKcWt3kBCf5E2pTxhW
Rk3/l5qVS8Bp3wleKZTjzuN0a69osaHXy6ZOiZm2CjFGHwvPdrcbNAfUbyI83jxX
t/Zto50nrnVRzSXtvvvDpBNjbZVWzCYPdAi13t09j9DcTgAjO6bO9Iwx29Hz3s7b
LOhprBBX/QLHS6lPhVBpFcZqdWCy6SXXXtbPma7f7yXV4xen/zOfrPQ+AQ61ng0=
=PFZn
-----END PGP SIGNATURE-----

--nextPart1904117.NgN9rU9EpP--


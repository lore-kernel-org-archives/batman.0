Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 19 Mar 2016 10:19:39 +0100
Message-ID: <2005230.N8INYQKvQl@sven-edge>
In-Reply-To: <20160319084934.GD9971@prodigo.lan>
References: <cover.1458231707.git.mschiffer@universe-factory.net>
 <2088697.nI9sVi8cPN@bentobox> <20160319084934.GD9971@prodigo.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1874079.9toSjhR6tM";
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
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1874079.9toSjhR6tM
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 19 March 2016 16:49:34 Antonio Quartulli wrote:
> On Fri, Mar 18, 2016 at 01:04:50PM +0100, Sven Eckelmann wrote:
> > On Friday 18 March 2016 13:00:54 Matthias Schiffer wrote:
> > [...]
> > 
> > > > What about the "socket" file?
> > 
> > [...]
> > 
> > > Ah, I forgot about that one because it is very different from the
> > > others.
> > > 
> > > I think it should be possible to convert "socket" as well by wrapping
> > > the
> > > BATADV_ICMP packets in netlink packets. Or maybe it would be possible to
> > > drop that altogether and just do ping/traceroute in userspace with
> > > AF_PACKET or similar?
> > 
> > The latter could be problematic for TP meter implementation [1,2,3,4,5].
> > Antonio, do you have an opinion about that?
> 
> Personally I wouldn't mind doing ping/traceroute 100% in userspace.


How can this be implemented 100% in userspace? Lets ignore the 
reply/forwarding part for a second and just concentrate on the initiator of 
the ping/traceroute. It can use AF_PACKET in userspace to send batadv packets 
directly on the hardif. But here comes the first problem... which is the 
correct hardif? There can be multiple and the userspace does not really know 
which one is the one the kernel would use at a particular time. So you have to 
implement the same algorithms in userspace the emulate the kernel part (or you 
may do something completely different). And still then you would have problems 
when the kernel is tweaked and the userspace didn't receive this tweak.

Maybe it is necessary to ask the kernel before sending the ping by asking him 
"hey, what interface would use use right now and what other parameters are now 
required". Similar to what "ip route get 8.8.8.8" would do.

Or am I just overcomplicated things now?

Kind regards,
	Sven
--nextPart1874079.9toSjhR6tM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW7RmrAAoJEF2HCgfBJntGcBgP/RQRHBMVXfJ4egGR6TerL8gC
yAKyddJYayTetJvOjIbfsq9e4I1ofgNt6cC8hb2KGMMdmSUOIEjHhnZ2tdYvfXJ8
Tqe1lyFzhEaJBRQq3C86rXpof+OO69IK0QfWIXRGcBnA+ltIeICWH9s/9VUyDxDm
rDJhoZyReeRTugmtr4brfHuKX/aaIuKRMNwSUJG6KjdytRrd96WTYLXMxZMy79Iv
poj91KISHYbFF/GTGooIr/5NQA0WlPHhVc7EIeG41tqKkWeXVV3F8Ndp4WgbbQYS
E/PPMfOlcZhlDafOjaAMIE01XfvNVXIOLL1Wzk5RDF6/L8lM1kC7uV2dMcHo0Y5k
EugBmtIpImW8u9Facw6pzF9c88bTC3i5M3IV/SGJzlHihecSGDxunS5Yt9J3HJHw
HQKPa7RoM3jssj7v6qaxv7cvwzF2EtfZ8IW2SRcnmpGexFxfpXrqjRQk6N/50ry0
3cF+AV+3w53QZdN7U+LruriNp2BocMb7kiGINI57bSqEG4p6+boF0FWubyedZL1G
0/1sQdLG0bl0s55qGp2/mRCv7LIE5YK0rkn6iV0UGoQ9+32EzZihPNeL/bdNjSH8
/HaXCMeFrLe0FS7QnomtBaxHnHetoMAtVQ95UaQtRnXfVdOT+tRrK8IqmxQeGQK3
VkA+x7IQDmI2FNYBHpq/
=ZNSg
-----END PGP SIGNATURE-----

--nextPart1874079.9toSjhR6tM--


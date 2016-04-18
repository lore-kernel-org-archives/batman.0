Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 18 Apr 2016 16:41:07 +0200
Message-ID: <1812177.9NXi5yCt0r@prime>
In-Reply-To: <20160313154222.GD9674@lunn.ch>
References: <1456867148-31883-1-git-send-email-andrew@lunn.ch>
 <9919433.c4WuAskJuF@sven-edge> <20160313154222.GD9674@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7856567.XIba1DBJm8";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 4/4] batman-adv: debugfs: Add netns
	support
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

--nextPart7856567.XIba1DBJm8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Andrew & list,

On Sunday 13 March 2016 16:42:22 Andrew Lunn wrote:
> On Sun, Mar 13, 2016 at 10:12:07AM +0100, Sven Eckelmann wrote:
> > On Monday 07 March 2016 15:21:07 Matthias Schiffer wrote:
> > [...]
> > 
> > > By the way, the netns support is another good reason to switch from the
> > > debugfs interfaces to a netlink-based interface (as the netlink
> > > interface
> > > wouldn't need userspace applications like batctl to be aware of the
> > > namespaces). I guess I should finally finish the patches I started
> > > writing
> > > for that...
> > 
> > So what is your suggestion here? Should the namespace support for
> > namespaces be rejected and you send in your netlink implementation
> > patches? Or should this patch be merged and be removed (together with the
> > rest of the debugfs stuff) when your netlink support is integrated?
> 
> Hi Sven
> 
> I would expect the debugfs code to stay around for a while, so people
> have a chance to upgrade their batctl and alfred to the new API. We
> probably need one release with both?

we had a phone discussion with Antonio, Marek, Sven and myself how to move 
forward with netlink and namespace support.

We concluded that having proper netlink support would be the more future proof 
option. We would then keep debugfs but slowly phase it out in the next coming 
years. New features would also be adopted in the netlink implementation.

It was also our impression that having the namespace support within netlink 
would be the cleaner approach, although it takes more work because it requires 
the netlink and appropriate userspace changes.

Andrew, what do you think? Would you like to check and rebase on Matthias' 
patchset?

Thanks,
    Simon
--nextPart7856567.XIba1DBJm8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXFPIDAAoJEKEr45hCkp6hvkwQAM2RrAm1qor0FE1ss0SUK9M6
NIITeIQoJUR7sdhv4+2KefAU6wAT0gD4zVKEUTA0hT9DSyZZMyliYjFtsxj37gRS
gJOKoDt6FmIyiTe0EzqrRnJQJMC9sQblcIlah4P0aA4QgdmZIbpeK7gt3Q0dzT8V
pBiOa2jromAIP+ayJw6cQ4BVEFzDKiXvp0GwLLPU5hr4+paAXluCKiJzlFguXg1O
gRHR6dxOA/aILk0d68U7jRvGHBueUFprkku7JRcmthXhUR0miwpYAK1EtbU9AHdz
I2MStbx8/WN3FVCUa6bhM9dzymPNnvVlNG8gvfROKcwpftNNURh6IB4Lr+kFSdKO
vmjCg7jXoM4EzrNYS7XOcALvN76nfqMTkS/p7h55V/0HubGeXfQLb762uBvI5QmR
6KMsoNvgiSuaab11QmKu1ZxDUAQeR/uAR8uLL8YNGQ0hqATdTStUqNYEsHXrKZcn
0Uw9tW4qGTzjYTWDUZco4CjXnay3wYMJXEOy90GE0vRYjekIgF/xS2GBZlgwIIAx
jySYDikshs7aRTDkf3VE0y3/w4GqMyGxJM/Yrf3AV7rIcnATYvyvXghL4qMXQXlw
NP03OrT0vIBwJIYnQ5yEF1U88CqXlrAfYituKsJ5hkF7cku9kJwP5pTdhD4adSnU
cLJ4T+G8H1tZd/OkYrjG
=RCJf
-----END PGP SIGNATURE-----

--nextPart7856567.XIba1DBJm8--


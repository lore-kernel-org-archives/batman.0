Return-Path: <andrew@lunn.ch>
Date: Sun, 25 Apr 2010 21:53:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100425195317.GA3734@lunn.ch>
References: <201004252136.25395.adebex@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201004252136.25395.adebex@gmail.com>
Subject: Re: [B.A.T.M.A.N.] Security & node authentication in BATMAN network
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

> 1. Does BATMAN provide any method of *authenticating* nodes?

> As I've said earlier, sometimes transferred data will be highly
> sensitive (for example: information of patients health in hospital),
> so it's absolutely critical to not allow leaking this information.

For this sort of application you need end-to-end security. That is,
your end devices authenticate each other, probably using
certificates. They then negotiate a key and then encrypt all the
traffic end-to-end. It does not matter if the data leaks, since its
not practical for anybody to decode it. You then don't care about you
mesh, its just an untrusted data pipe from A to B.

You should probably get a good book on security and learn all about
what Alice and Bob need to do.

The mesh itself is not important. You cannot trust it, hence its not
important.

      Andrew

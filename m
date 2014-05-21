Return-Path: <andrew@lunn.ch>
Date: Wed, 21 May 2014 20:18:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20140521181838.GB7725@lunn.ch>
References: <CAEbDFcQh8b8jmTNFGdwG0Me1vV7O-1G=r8F0Ki53=OwhhwgM5Q@mail.gmail.com>
 <20140520140157.GE9873@lunn.ch>
 <CAEbDFcRM68JXcZ=rq2-i05EL4yO8iv5kq3Bf6GaJQuH_LWQRVQ@mail.gmail.com>
 <20140520214134.GB11248@lunn.ch>
 <CAEbDFcQS-f4zRCph0RVyXd9k953DiczGVS4k5TP4vFeio3GhSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEbDFcQS-f4zRCph0RVyXd9k953DiczGVS4k5TP4vFeio3GhSw@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Adding security on BATMAN-ADV
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

On Wed, May 21, 2014 at 10:30:08PM +0530, Krishnathiepan Rasanayagam wrote:
> Hi,
> 
> We are trying to add authentication when nodes join the network. Like
> when other nodes start adding a node in their routing table. basically
> authenticating the node.

So some form of HMAC on the packets between peers, and only accept
them if you can verify the HMAC.

You say here routing tables. So you are trying to authenticate routing
information. You don't care about actual data carried over the mesh?
That is not authenticated?

> We like to do with Threshold cryptography for authenticating.

So you mean you want at least X peers to be able to authenticate a
peer before it is allowed to join the mesh? So how do you boot strap
the system when the mesh is first forming and you don't have X peers?

    Andrew

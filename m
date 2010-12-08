Return-Path: <andrew@lunn.ch>
Date: Wed, 8 Dec 2010 08:29:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20101208072915.GA8875@lunn.ch>
References: <20101207221351.GA19474@Sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20101207221351.GA19474@Sellars>
Subject: Re: [B.A.T.M.A.N.] B.A.T.M.A.N.-Advanced Multicast Optimizations
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

On Tue, Dec 07, 2010 at 11:13:51PM +0100, Linus L??ssing wrote:
> Please see the attached document for details about the algorithm,
> the integration into the current B.A.T.M.A.N.-Advanced
> code and how to activate/use this mode.

Hi Linus, Simon

Nice document. 

However one thing i don't like about it is the use of multicast
group. In the Terminology you define it as:

multicast group: B.A.T.M.A.N. advanced will not distinguish between
different multicast group IDs / IP protocols on layer 3. Instead, the
term multicast group will be used analogously for a multicast mac
address.

This is quite different to the normal usage of the term. In the RFC's
the multicast group is always an IP address in the range 224.0.0.0/4.

When looking at B.A.T.M.A.N. on its own, your definition is O.K, but
when you start to consider the whole protocol stack, it will lead to
confusion.

Do you think you could do a search/replace with "multicast MAC
address"?

Also, the meaning of symmetric multicast group membership takes a bit
of understanding. Once i read section 2.2.1 it became clear, but maybe
that section should be earlier in the document? Also, from experience
talking to people about IP multicast, i know people have trouble
getting the concept you can send a multicast packet without being a
member of the group. Maybe a short explanation of how IP multicast
works, or a link to a good tutorial would be good.

Is this symmetric assumption a problem? Depends one the use case. Your
PIM gateway into the multicast cloud should be a member of the
group. It has to receive the packets from the local hosts, so it can
forward them upstream to the RP, the root of the distribution tree. So
your traffic coming from upstream should be O.K. However if you have a
webcam which is multicasting a video stream, it might not be a member
of the group, since it is not interesting in receiving video streams,
just sending them. So in this use case you won't have any benefit from
your scheme.

The symmetric assumption is a nice simplification to get started, but
i think you need to have a good plan for allowing none members to send
multicast traffic.

Have you considered handing broadcast packets as multicast packets?
Broadcast is just a special case of multicast.

	  Andrew

Return-Path: <andrew@lunn.ch>
Date: Wed, 11 Nov 2009 07:43:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20091111064301.GQ5005@lunn.ch>
References: <200911082144.49637.lindner_marek@yahoo.de>
	<591bc9930911090043mf62cd17tac8033d316002a18@mail.gmail.com>
	<200911092239.01984.lindner_marek@yahoo.de>
	<591bc9930911101917j149b5ba5j666ddded7a0ceeb0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <591bc9930911101917j149b5ba5j666ddded7a0ceeb0@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] batman-adv 0.2 released
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

Thinking a little out of the box here...

So far, everybody has talked about fragmenting so that you can
transfer 1500byte frames over interfaces with an MTU of 1476.

24 bytes are the problem. We could try to compress the packet as a
first stage to solving the problem. If we cannot sufficiently compress
it, then segment it.

There are a few well know compression schemes that could be used, some
generic, so more tailored to network traffic.

V. Jacobson TCP/IP header compression, often used on PPP links:
http://tools.ietf.org/html/rfc1144

There is already a kernel implementation of this which might be
reusable. It may also be possible to extend the scheme to compress
part of the original ethernet header.

There is a more generic header compression scheme:
http://tools.ietf.org/html/rfc3095

The advantage of this is that it can compress more than just TCP/IP
and is decoupled from PPP.

Then there is the more traditional compression schemes, eg LZO etc.
There are a few academic papers available looking at this subject.
The disadvantage of trying to compress the packet data is often it is
already compressed, eg images. Or it is https traffic which makes it
harder to compress.

I would tend more towards header compression. It requires a lot less
CPU usage then data compression and should provide the 24 bytes of
compression we need most of the time. However, as i said at the
beginning, we need to be able to fall back to segmentation when it
does not work, or has to send full header information in order to
establish the compression tables.

	  Andrew




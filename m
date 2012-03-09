Return-Path: <gabriel@kerneis.info>
Date: Fri, 9 Mar 2012 14:46:00 +0100
From: Gabriel Kerneis <kerneis@pps.jussieu.fr>
Message-ID: <20120309134600.GK15059@kerneis.info>
References: <4F4F6D18.3070403@ninux.org> <20120309085636.GA9018@pandem0nium>
	<20120309111203.GE15059@kerneis.info>
	<201203091926.54899.lindner_marek@yahoo.de>
	<20120309120455.GF15059@kerneis.info>
	<20120309123905.GB436@ritirata.org>
	<20120309125741.GJ15059@kerneis.info>
	<74A4488FAEEC56408507A6FECA6909910122184D@SC000647.CHASCOM.INT>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74A4488FAEEC56408507A6FECA6909910122184D@SC000647.CHASCOM.INT>
Subject: Re: [B.A.T.M.A.N.] [Battlemesh]   Battlemesh v5 tests
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
Cc: battlemesh@ml.ninux.org

Andrew,

On Fri, Mar 09, 2012 at 01:09:26PM +0000, andrew.lunn@ascom.com wrote:
> > Consider the following topology:
> > 
> > 
> >        l0     l1
> >     A ---- B ==== C
> >               l2
> > 
> > where --- is a single link (l0) and === are two links (l1 and l2).
> > 
> > Now imagine that the administator wants to dedicate the link l2 to the
> > communication between B and C, for whatever reason.  It is fairly easy to
> > set netfilter rules to that effect, for instance.
> 
> It would be possible to do what you want. Simply don't add the l2 interfaces
> to BATMAN, put IP addresses from a different subnet on the interfaces, and B
> and C can use the link l2 for themselves, and use the bat0 interface for
> access to the mesh subnet.

This was of course a simplified example.

What if there are an arbitrary number of nodes between B and C instead of a
direct link?

       l0        l1
    A ---- B ---------- C  Example:
           \           /   I want to restrict the link l1 to communication
            D -- E -- F    between A and C. (Nice frying-pan, isn’t it? ;-)

I love ASCII-art, I can build arbitrarily complex situations (and we actually
use this kind of stuff with babel on wifi.pps.jussieu.fr). Your solution doesn’t
scale, it only pushes the problem outside of batman.

Best,
-- 
Gabriel

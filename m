Return-Path: <gabriel@kerneis.info>
Date: Fri, 9 Mar 2012 11:59:22 +0100
From: Gabriel Kerneis <kerneis@pps.jussieu.fr>
Message-ID: <20120309105921.GD15059@kerneis.info>
References: <201203070156.51341.lindner_marek@yahoo.de>
	<20120306193643.GM12778@kerneis.info>
	<201203070552.33850.lindner_marek@yahoo.de>
	<7i62egijym.fsf@lanthane.pps.jussieu.fr>
	<20120307144709.GA19891@ritirata.org>
	<7ieht4mnnp.fsf@lanthane.pps.jussieu.fr>
	<20120307171751.GC1389@ritirata.org>
	<20120307221847.GR12778@kerneis.info>
	<20120309085636.GA9018@pandem0nium>
	<CANjd3nd5+8n2frV_FVLbONyAj4An8Rcq=mOu-pVk-3nzp8Kk_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANjd3nd5+8n2frV_FVLbONyAj4An8Rcq=mOu-pVk-3nzp8Kk_w@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] [Battlemesh] Battlemesh v5 tests
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
Cc: Battle of the Mesh Mailing List <battlemesh@ml.ninux.org>

Hi Benjamin,

On Fri, Mar 09, 2012 at 10:17:47AM +0100, Benjamin Henrion wrote:
> On Fri, Mar 9, 2012 at 9:56 AM, Simon Wunderlich
> > Maybe "algorithm" is a big word for a little feature like that. The bonding
> > and interface alternating basically work in two steps:
> >
> >  1) detect that a neighbor is reachable via two different links
> >  2) use the two different links for various manipulations (bonding, interface alternation)
> 
> Hoping over the same frequency should be made costly.
> 
> Do you add a cost if the packet comes from the same wireless interface?

AFAIU, Batman will never send a packet back on the same interface (be it
wired or wireless, whatever the frequency, etc. – they don’t care at all).
Except if this is the only available one, of course, or if the alternative
interfaces have been dismissed for some reason (too low quality, etc.).

They just decide upfront a set of alternative interfaces, and then choose the
best interface that it is not the incoming one among this set, for each packet.
You have no way to declare that two different wifi interfaces interfere, for
instance; it is roughly similar to babel -z1.

-- 
Gabriel

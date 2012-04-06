Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 6 Apr 2012 11:18:53 +0300
References: <201203222250.31309.lindner_marek@yahoo.de>
	<201204052311.09200.lindner_marek@yahoo.de>
	<20120406071729.GA10020@lunn.ch>
In-Reply-To: <20120406071729.GA10020@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201204061118.53394.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC 2/5] batman-adv: ELP - creating neighbor
	structures, updating LQs
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

On Friday, April 06, 2012 10:17:29 Andrew Lunn wrote:
> > Currently, that is not planned. We hoped to keep the compat numbers
> > in sync across the various protocols. Otherwise we all could end up
> > in compat hell.
> 
> Can they be kept in sync? I would assume that IV is becoming more and
> more stable, with more effort going into V. So IV is less probable to
> need an COMPAT increment than V. The three month kernel cycle helps
> with the sync, but it would be a PITA to have to upgrade an entire IV
> net because V have forced a COMPAT increment, but IV has not changed
> and is compatible.

If you check our compat number history[1] you will see that the compat number 
changes when features are added (tt rewrite, gateway flags, unicast 
fragmentation, etc). These features are the same across protocols.

Another motivation to not further grow the compat number world is backward 
compatibility. Larger mesh installations will need to upgrade the mesh step by 
step instead of updating everything at once. As a result we must switch 
towards smoother compatibility breaks in the future otherwise upgrading will 
become a real pain. We have created a wiki page [2] to collect ideas for 
better backward compatibility. 


> The COMPAT_VERSION effectively becomes an indicator of the protocol,
> assuming they are different. However, this is the opposite to your
> idea of keeping them in sync.
> 
> Since there would be no ELP registered for COMPAT_VERSION_IV, the
> packet would be discarded by the dispatcher. However,
> COMPACT_VERSION_V would register an ELP function and the dispatcher
> would use it.
> 
> Making the dispatcher aware of these two dimensions, (MSG_Type,
> Version), puts all the checking in one place and makes the individual
> message handlers simpler.

The dispatcher has to work on a per interface basis to make this work. It 
would need to do the same check we currently have, to verify that a given 
interface wants to have packets from this or that protocol.

Regards,
Marek


[1] http://www.open-mesh.org/wiki/batman-adv/Compatversion
[2] http://www.open-mesh.org/wiki/batman-adv/Packet-types

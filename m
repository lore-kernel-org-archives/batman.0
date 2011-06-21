Return-Path: <andrew@lunn.ch>
Date: Tue, 21 Jun 2011 22:01:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110621200124.GA4137@lunn.ch>
References: <201106211512.34486.sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201106211512.34486.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] One step back
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

On Tue, Jun 21, 2011 at 03:12:31PM +0200, Sven Eckelmann wrote:
> Hi,
> 
> after the last mail of David S. Miller, it was more than clear that I am not 
> the right person to speak on behalf of the batman-adv community.

Hi Sven

You have done great work with git, getting RCU correct, cleanup,
etc. Even if you don't feel capable of speaking on behalf of the
batman-adv community in the direction of David S. Miller, i hope you
can stay around and contribute to the project.

> I have the same opinion about the always changing protocol as he
> does. I first struggled with it after getting the batman dissector
> merged in wireshark, but it is confronting everyone since the merge
> into the linux kernel began. Andrew already told us that we would
> need to get some kind of stable on the wire format and some kind of
> backward compatibility, but it doesn't look like we get there soon.
 
There are some big changes in the pipeline. NDP from Linus, HNA/TT
changes from Antonio, Multicast from Linus and Simon, Linus's GSOC
work, other things i've forgotten....

Here is a few ideas for discussion.....

Explain to David that these changes are in the pipeline. Explain what
benefits they bring. And probably most importantly, try to promise
they will all arrive at once. This might mean delaying some features
for a while, but it will upset compatibility the least. After that,
there will not be any none compatible changes for "a long time". We
should discussion here what "a long time" means, eg 4 kernel cycles, 8
kernel cycles, etc.

At the same time as getting these big changes ready to go, it would be
good to ensure that we have options to make backward compatible
changes during this "long time". I would suggest we document all the
available reserved bits we have in the different messages. Ensure they
are always set to 0 in the current implementation when creating
messages and always ignored when receiving messages. Also, for
messages which are forwarded, maybe it makes sense to ensure that a
well defined number of the reserved bits get forwarded as they are
received and the rest get reset back to 0. Also, received messages of
unknown type are silently dropped. Maybe, unknown messages with a
particular bit set could be forwarded using the routing table, using
an originator address in a well known location in the message.

The point of this is to put infrastructure in place to allow the
protocol to be extended without breaking compatibility. It will limit
what can be added as new features, cause more headaches while figuring
out how to implement something using only this infrastructure, but
will keep a lot of people happy they don't need a flag day when
upgrading their kernel to an incompatible batman-adv version.

Andrew

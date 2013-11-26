Return-Path: <linus.luessing@web.de>
Date: Tue, 26 Nov 2013 05:48:16 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20131126044816.GA5457@Linus-Debian>
References: <525B11F2.5030605@altermundi.net> <5282A184.1020704@altermundi.net>
 <20131112215442.GN3713@neomailbox.net>
 <5282CE44.8000402@altermundi.net> <20131113080404.GO886@medion.lan>
 <20131113080157.GO3713@neomailbox.net>
 <52941BED.9070402@altermundi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52941BED.9070402@altermundi.net>
Subject: Re: [B.A.T.M.A.N.] mad mad batman ...
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

Hi Nico,

On Tue, Nov 26, 2013 at 12:56:29AM -0300, Nicolás Echániz wrote:
> El 13/11/13 05:01, Antonio Quartulli escribió:
> > On Wed, Nov 13, 2013 at 09:04:05AM +0100, Bastian Bittorf wrote:
> >> * Nicolás Echániz <nicoechaniz@altermundi.net> [13.11.2013
> >> 08:59]:
> >>> Am I the only one who has bumped into this (twice)?
> >> 
> >> I have also seen a lot of these messages with an indoor mesh, so
> >> no lightning involved 8-) but with v2013.04 this is gone. (same
> >> network).
> > 
> > this message is the symptom of a loop. The causes can be
> > gazillions.
> 
> Well... it took about a week to finally find the node creating this
> problem. As before, it's failing hardware that caused the issue.

Interesting. Could you be more specific in which way the hardware
fails? Does it reboot frequently? Does it send broken OGM packets?

Could you make a checksum of the flashed squashfs, does it differ
from the one you've built?

> 
> When this happens every node in the net is repeatedly showing that
> message. It is not the same with any "loop symptom" I believe... At
> least I've never seen this happen on every node being caused by
> something else.
> 
> I really would like to find out more about how this condition comes to
> happen and how to diagnose and prevent it. The whole batman-adv cloud
> dies when this happens and it's a pain in the ass to "debug".
> 
> All the failing routers are WR842ND. There are many more of the same
> model working just fine.

We are also using quite a lot of 842NDs, 841NDs and 3600NDs, as well
as some 741ND, 1043ND and 4300NDs. We've never had the issue of
one broken node taking down the whole network yet, not in Hamburg,
Kiel or Lübeck.

Would be interesting to figure out the differences between our
setups. Maybe I missed it so far, did you say you were using
bridge loop avoidance (we don't)? We are using batman-adv 2013.1.0
mostly with a few still on 2012.4.0 and some on 2013.4.0.

> 
> 
> I now have three routers which produce this symptom, so if anyone who
> can understand the problem better is willing to test, I can set up a
> dedicated mini-test-bed.
> 
> 
> Cheers,
> NicoEchániz
> 
> 
> 

Cheers, Linus

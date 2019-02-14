Return-Path: <linus.luessing@c0d3.blue>
Date: Thu, 14 Feb 2019 18:49:13 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190214174913.GB1602@otheros>
References: <20190214155100.10070-1-linus.luessing@c0d3.blue>
 <2119814.DADNbvlFmJ@rousseau>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2119814.DADNbvlFmJ@rousseau>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: allow snooping gratuitous
 ARP Replies
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
Cc: Daniel Ehlers <sargon@toppoint.de>

On Fri, Feb 15, 2019 at 12:16:31AM +0800, Marek Lindner wrote:
> On Thursday, 14 February 2019 23:51:00 HKT Linus Lüssing wrote:
> > So far, gratuitous ARP Replies were ignored for DAT processing as it
> > contains a broadcast MAC address. This patch changes this and allows
> > snooping such ARP messages, too.
> 
> > Gratuitous ARP Replies were ignored since this commit:
> > ab361a9ccc5 ("batman-adv: filter ARP packets with invalid MAC addresses in 
> DAT")
> 
> You're kind enough to mention when the filter was introduced but fail to 
> explain why the filter introduced in the past was has outlived its usefulness 
> or how the new behavior addresses the  previous concerns.

That patch added filtering for both zero and broadcast MAC
addresses. While the original premise is correct - we do not want
those addresses in the DAT, the assumption that a broadcast MAC
address as ARP target MAC address were invalid, is wrong.
Gratuitous ARP Replies are valid packets.

So that patch was a bit too strict in that regard, I think. For
gratuitous ARP it's enough to ignore the (Target MAC/Target IP)
pair. Snooping the (Sender MAC/Sender IP) should be fine.

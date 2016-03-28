Return-Path: <roland.volkmann@t-online.de>
References: <56F5AF2F.6060904@t-online.de> <6005839.o5jWIFZeG0@voltaire>
 <56F934F9.5000508@t-online.de> <11401348.Kx9RpUz81r@voltaire>
 <20160328191128.GA2772@otheros>
From: Roland Volkmann <roland.volkmann@t-online.de>
Message-ID: <56F99FCD.5040704@t-online.de>
Date: Mon, 28 Mar 2016 23:19:09 +0200
MIME-Version: 1.0
In-Reply-To: <20160328191128.GA2772@otheros>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] No rebroadcast on mesh links
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

Linus Lüssing schrieb am 28.03.2016 um 21:11:
> On Mon, Mar 28, 2016 at 10:43:39PM +0800, Marek Lindner wrote:
>> Can you provide insights  as to what that means and whether or not
>> tinc/fastd 'export' their internal state via an interface flag or
>> something along those lines ?
> Oh, that's a cool idea! Similar to the flag "MULTICAST" you can
> see via an "ip link", to have a flag like "TRANSITIVE", for instance,
> right? (and a net_device flag, configurable via ioctl if I don't
> mix up the internals)
>
> mac80211 could unset it by default for adhoc interfaces or if
> ap-isolation is enabled. tinc, fastd or OpenVPN could set or unset
> it on their interfaces depending on their specific configuration.
> ethernet drivers would have it enabled by default. For bridges
> some more thought might be needed, what to inherit from the bridge
> slaves on the upper bridge interface.
>
> Safe and transparent for the user. I like that idea :).

Because I'm not a Linux specialist knowing internal details, I like to 
see the issue in competent hands. My view is on functional level only, 
so if (additional) features are needed to optimize existing 
Freifunk-Environments, I try to get help. Whatever implementation will 
provide this functionality is ok for me and hopefully the Freifunk 
communities.

But I'm not sure it is possible to detect automatically whether 
rebroadcast are necessary or not in all cases. Let's assume 3 Nodes A, B, C.
Scenario 1: 2 fastd-Links, A-B and A-C
Scenario 2: 3 fastd-Links, A-B, A-C and B-C (this I called "full mesh")

Node A cannot know, whether you have scenario 1 or 2. But in scenario 1 
you need rebroadcast on Node A, while in scenario 2 rebroadcasts can be 
avoided. IMHO this must be configured manually.


Best regards,
Roland.


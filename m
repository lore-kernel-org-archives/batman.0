Return-Path: <linus.luessing@web.de>
Resent-Message-ID: <20110226221817.GA19307@Sellars>
Resent-To: lindner_marek@yahoo.de, b.a.t.m.a.n@lists.open-mesh.org
Date: Fri, 25 Feb 2011 23:41:29 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20110225224129.GB17128@Sellars>
References: <4D668F3F.4080700@orxrail.com> <20110224194414.GA15337@Sellars>
	<4D66BBC9.80101@orxrail.com>
	<201102250130.35865.lindner_marek@yahoo.de>
	<4D67B241.8070606@orxrail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4D67B241.8070606@orxrail.com>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] batman-adv mesh slows down wired
	clients	(bridge-loop-avoidance)
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

Hi Vinay,

On Fri, Feb 25, 2011 at 08:44:33AM -0500, Vinay Tharigopula wrote:
> Marek..
> 
> I got the binaries from the openwrt prebuilt packages. However, now
> I rebuilt the image and built batman-adv 2011.myself. I will try
> this now and let you know.
> 
> However, now I am running into a much bigger issue. If two routers
> are plugged in to the same switch, bridge loop avoidance doesnt work
> and both of them are stopping responding to pings.
Could you try "batctl ping" too and check whether this is working
or not.

If that's working but the normal pinging is not, then it should be
a layer 3 problem - in that case we'd need the outputs of "ip
route show" and "ip address show".

If batctl ping is already not working then "batctl o" and "batctl
if" output will be interesting.
> 
> Here is my config.
> 
> bat0 if:
> wlan1: active.
> 
> wlan1: Mesh Network.
> 
> wlan0: Infrastructure network.
> eth0 : 4 lan ports
> eth1: 1 wan port
> 
> br-lan : wlan0 eth0 eth1 bat0
Hmm, that looks sane and correct, should work like that.

Is there anything weird in the output of "dmesg"? Any errors or
warnings?

Cheers, Linus

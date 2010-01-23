Return-Path: <andrew@lunn.ch>
Date: Sat, 23 Jan 2010 19:10:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100123181048.GO24649@lunn.ch>
References: <20100123174616.GA4795@Sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100123174616.GA4795@Sellars>
Subject: Re: [B.A.T.M.A.N.] bat_events: page allocation failure (batman-adv
 maint)
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

On Sat, Jan 23, 2010 at 06:46:16PM +0100, Linus L??ssing wrote:
> Hey guys,
> 
> I've been installing a 9 node setup here in our cellar. They are
> all running B.A.T.M.A.N. adv 0.2.1-beta r1545 (so the current
> batman-adv maintance version in OpenWRT).
> 
> The result over night:
> - 1x: bat_events: page allocation failure

This looks like a memory leak somewhere. It could be anywhere, batman
or some other part of the kernel.

Can you build your kernel with the kernel memory leak detector
enabled? It is under the Kernel Hacking options. You probably also
need to build the kernel with symbols, which will help with ksymopps
anyway. Documentation for kmemleak is in Documentation/kmemleak.txt.
I've never used it myself, so i've no idea how good it actually is...

Interestingly, did you notice the warnings:

batman-adv:The newly added mac address (00:24:01:b7:6a:d2) already exists on: eth0.2
batman-adv:It is strongly recommended to keep mac addresses unique to avoid
+problems!

I guess this is because you are using VLANs. Have you seen these
problems without using VLANs? 

	 Andrew

Return-Path: <andrew.lunn@ascom.ch>
Date: Sun, 23 Aug 2009 15:54:51 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090823135451.GA17243@ma.tech.ascom.ch>
References: <20090823130934.GA28556@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090823130934.GA28556@ma.tech.ascom.ch>
Subject: Re: [B.A.T.M.A.N.] [batman-adv] Use prinkt instead of debug_log
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

Hi Folks

I've been considering what to do with the remaining debug_log
calls. 

We have three classes of output from debug_log:

1) Changes to HNA entries, all in translation-table.c.
2) Changes of routes, all in routing.c
3) All the remaining debug output scattered in a number of files.

1) and 2) are pretty low volume in terms of output, and code size. 

3) is a lot more verbose and needs more code. It is also not so
efficient in that it does lots of string manipulations, creating ascii
representations of MAC addresses which rarely get output. That can be
fixed once we are close to integration to mainline and can drop
backward compatibility to older kernels. We can then use the %pM
format in printk. However, until then, it would be good to be able to
compile out this code.

Traditionally the network code uses pr_debug() for outputting debug
information. This is disabled by default and in order to see it, it is
necessary to add #define DEBUG to any file you want to see the debug
output from.

I don't think pr_debug is flexible enough for what we want at the
moment. My proposal is to add to main.h macros

#define CONFIG_BATMAN_DEBUG_ROUTE 1
#define CONFIG_BATMAN_DEBUG_BATMAN 0

#if CONFIG_BATMAN_DEBUG_ROUTE
pr_route_debug(format, a...) printk(KERN_DEBUG "batman:" format, ##a)
#else 
pr_route_debug(format, a...)
#endif

#if CONFIG_BATMAN_DEBUG_BATMAN
pr_batman_debug(format, a...) printk(KERN_DEBUG "batman:" format, ##a)
#else 
pr_batman_debug(format, a...)
#endif

So by default the routing updates will make it out, but the rest is
disabled by default.

What do others think?

     Andrew

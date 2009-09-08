Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 9 Sep 2009 01:57:52 +0800
References: <4AA34865.9000203@rsm-freilassing.de>
	<200909072102.57854.lindner_marek@yahoo.de>
	<4AA50D60.9050605@rsm-freilassing.de>
In-Reply-To: <4AA50D60.9050605@rsm-freilassing.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200909090157.53099.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Problems with Gateway-Selection without option -g
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

On Monday 07 September 2009 21:40:48 Michael Rack wrote:
> The interface where batman is running on have MTU 1460 (Standard
> Ethernet - UDP VPN Overload) on HOST #1.
> The interface where batman is running on have MTU 1500 (Standard
> Ethernet) on HOST #2.

Ok, that is what I expected. Batman will take the 29 Bytes it needs from the 
given MTU.


> Yes, the iptables-command does the trick for me. This iptalbes-filter
> was known before. I added the filter to the mangle-table as the problem
> occurs.

Ok, I'll make a patch to let batman handle this automatically. Thanks for 
bringing this up.


> Correct. I've added some rules with "to any", and this does the trick.
> In addition i use my own policy-routing-script, because the "throw"
> event makes the routing-table a little fuzzy. Now i have only two
> routing-tables "batman_hosts" and "batman_networks". In my
> policy-routing-script i do the seperation between both tables.

You will need the throw routes as soon as you use the tunneling.


> My policy-routing-script is attached.

Nice - happy to see it in action.  :-)

Regards,
Marek

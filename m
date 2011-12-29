Return-Path: <bjo@nord-west.org>
From: Bjoern Franke <bjo@nord-west.org>
Date: Thu, 29 Dec 2011 23:21:39 +0100
Message-ID: <1444782.kOCQeuloQi@mytilus>
In-Reply-To: <4423425.OCX3qX6ovA@mytilus>
References: <201112281811.58622.clemens-john@gmx.de>
	<4423425.OCX3qX6ovA@mytilus>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] HowTo Test Bla2
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

Am Donnerstag, 29. Dezember 2011, 22:19:11 schrieb Bjoern Franke:
> Hi,
> 
> Am Mittwoch, 28. Dezember 2011, 18:11:48 schrieb Clemens John:
> > Maybe you can take a look at it and find our mistake?
> 
> We got it built now, but it has some unknown symbols:
> 
> batman_adv: Unknown symbol free_rcu_tt_local_entry
> batman_adv: Unknown symbol free_rcu_gw_node
> batman_adv: Unknown symbol free_rcu_backbone_gw
> batman_adv: Unknown symbol free_rcu_neigh_node
> 
> What did we miss?

Fixed, batman-adv-y += compat.o was missing in Makefile.kbuild.

-- 
jabber: bjo@schafweide.org
bjo.nord-west.org | nord-west.org | freifunk-ol.de

Return-Path: <bjo@nord-west.org>
From: Bjoern Franke <bjo@nord-west.org>
Date: Mon, 02 Jan 2012 23:09:09 +0100
Message-ID: <1542912.6mqKHTfaCm@ostrea>
In-Reply-To: <2075196.LxuFnsEOfE@sven-laptop.home.narfation.org>
References: <201112252236.22377.clemens-john@gmx.de>
	<2075196.LxuFnsEOfE@sven-laptop.home.narfation.org>
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

Hi,

Am Sonntag, 25. Dezember 2011, 23:29:42 schrieb Sven Eckelmann:
> On Sunday 25 December 2011 22:36:18 Clemens John wrote:
> > Hi,
> > 
> > I want to test the  Bridge loop avoidance II with our OpenWrt Freifunk
> > firmware. Is there a version that works and can be tested? Which git repo
> > do I have to use and what are the main steps to compile it into openwrt?
> Simon Wunderlich is the maintainer of the bridge loop avoidance II patchset.
> His current version can be found in his repo [1] in branch blaII (or
> another branch with blaII in the name). It is currently not rebased on top
> of master or v2011.4.0... so you cannot take the patchset and put it in
> OpenWRT.

We used the rebased version and got the module compiled (yeah! ;).
 
I enabled blaII on one node, and after that all nodes connected to the vpn 
went unreachable. Most of them use 2011.0.0, some others 2011.4.0, running an 
ad-hoc iface as bat-adv-iface and bat0, tap0 and ath0(master, for clients) as 
a bridge. Do the blaII-packets "kill" all the other nodes? I thought the 
blaII-packets would have no effect on the other nodes because of the compat-
layer.

regards
Bjoern
-- 
jabber: bjo@schafweide.org
bjo.nord-west.org | nord-west.org | freifunk-ol.de

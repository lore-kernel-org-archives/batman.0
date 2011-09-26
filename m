Return-Path: <bjo@nord-west.org>
From: Bjoern Franke <bjo@nord-west.org>
Date: Mon, 26 Sep 2011 02:15:46 +0200
Message-ID: <3131360.5iACvcvJX2@ostrea>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: [B.A.T.M.A.N.] batman-adv: loop caused by tinc and wifi
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

we are using the following configuration in our freifunk network:

B.A.T.M.A.N. advanced 2011.0.0 (compatibility version 12)

ath1 (ad-hoc) as batman-adv-interfaces
ath0 (ap), tap0, eth0.1 and bat0 as a bridge

stp is enabled for the bridge.
Most of the nodes are connected via tinc and the network runs fine. But if two 
nodes which have a tinc connection also get a ath1-connection, the whole 
network crashes.

What are we doing wrong?

regards
Bjoern
-- 
jabber: bjo@schafweide.org
bjo.nord-west.org | nord-west.org | freifunk-ol.de

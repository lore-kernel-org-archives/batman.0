Return-Path: <bittorf@bluebottle.com>
Date: Thu, 24 Apr 2014 14:58:21 +0200
From: Bastian Bittorf <bittorf@bluebottle.com>
Message-ID: <20140424125820.GR26376@medion.lan>
References: <5358CCA4.2050203@wirelesspt.net>
 <201404241148.19217.sw@simonwunderlich.de>
 <1398340673.9414.109890229.7C3D1C45@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1398340673.9414.109890229.7C3D1C45@webmail.messagingengine.com>
Subject: Re: [B.A.T.M.A.N.] [Battlemesh] Batman-adv high TQ and Low
	throughput
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
To: Battle of the Mesh Mailing List <battlemesh@ml.ninux.org>
Cc: openwrt-users <openwrt-users@lists.openwrt.org>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

* Thijs van Veen <dicht@operamail.com> [24.04.2014 14:45]:
> N is usually somewhere around -100 dBm, meaning that a Prx of about -85

unsure about that: it depends on the WiFi-receiver's quality, isn't it?

when i use 'iwinfo' the noise is always '-95', no matter on which location.
it seems to come from nl80211_get_noise() but i dont understand it fully.

or do i mix something up? bye, bastian

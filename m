Return-Path: <jiri@resnulli.us>
Date: Sat, 29 Oct 2016 12:33:01 +0200
From: Jiri Pirko <jiri@resnulli.us>
Message-ID: <20161029103301.GD1692@nanopsycho.orion>
References: <20161027190150.7880-1-sw@simonwunderlich.de>
 <20161027190150.7880-4-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161027190150.7880-4-sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 03/17] batman-adv: Add network_coding and
 mcast sysfs files to README
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net

Thu, Oct 27, 2016 at 09:01:36PM CEST, sw@simonwunderlich.de wrote:
>From: Sven Eckelmann <sven@narfation.org>
>
>Signed-off-by: Sven Eckelmann <sven@narfation.org>
>Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
>---
> Documentation/networking/batman-adv.txt | 9 +++++----
> 1 file changed, 5 insertions(+), 4 deletions(-)
>
>diff --git a/Documentation/networking/batman-adv.txt b/Documentation/networking/batman-adv.txt
>index d414e60..8afa991 100644
>--- a/Documentation/networking/batman-adv.txt
>+++ b/Documentation/networking/batman-adv.txt
>@@ -71,10 +71,11 @@ All  mesh  wide  settings  can be found in batman's own interface
> folder:
> 
> # ls /sys/class/net/bat0/mesh/
>-#aggregated_ogms        distributed_arp_table  gw_sel_class    orig_interval
>-#ap_isolation           fragmentation          hop_penalty     routing_algo
>-#bonding                gw_bandwidth           isolation_mark  vlan0
>-#bridge_loop_avoidance  gw_mode                log_level
>+# aggregated_ogms        fragmentation  isolation_mark  routing_algo
>+# ap_isolation           gw_bandwidth   log_level       vlan0
>+# bonding                gw_mode        multicast_mode
>+# bridge_loop_avoidance  gw_sel_class   network_coding
>+# distributed_arp_table  hop_penalty    orig_interval

I strongly believe it is a huge mistake to use sysfs for things like
this. This should be done via generic netlink api.
>

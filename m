Return-Path: <sven@open-mesh.com>
From: Sven Eckelmann <sven@open-mesh.com>
Date: Thu, 21 Jan 2016 14:47:30 +0100
Message-ID: <4178376.2Vigxs1Xtt@bentobox>
In-Reply-To: <6825353.GnzNjs5eRJ@bentobox>
References: <8047297.0qIFjkW2bL@voltaire> <6825353.GnzNjs5eRJ@bentobox>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart4419566.UnT2k9yIuH"
Content-Transfer-Encoding: 7Bit
Subject: [B.A.T.M.A.N.] OpenWrt cfg80211.h station_info incompatibility with
	kernel+mac80211 [was: B.A.T.M.A.N. V leaves the nest v2]
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Felix Fietkau <nbd@openwrt.org>, openwrt-devel@lists.openwrt.org, Marek Lindner <mareklindner@neomailbox.ch>

This is a multi-part message in MIME format.

--nextPart4419566.UnT2k9yIuH
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 21 January 2016 12:56:01 Sven Eckelmann wrote:
> Just installed in on some hardware (2x OM5P + OpenWrt 44654 + compat-wireless
> 2015-10-26) and enabled BATMAN_V.
>
> [  168.540000] CPU 0 Unable to handle kernel paging request at virtual address fffffff0, epc == 86d8301c, ra == 86d8301c
> [  168.550000] Oops[#1]:
> [  168.550000] CPU: 0 PID: 265 Comm: kworker/u2:2 Tainted: P               3.18.8 #1
> [  168.550000] Workqueue: bat_events batadv_v_elp_throughput_metric_update [batman_adv]
[..]
> [  168.550000] epc   : 86d8301c batadv_v_elp_throughput_metric_update+0x20/0x58 [batman_adv]
> [  168.550000]     Tainted: P              
> [  168.550000] ra    : 86d8301c batadv_v_elp_throughput_metric_update+0x20/0x58 [batman_adv]

Who knew that struct station_info changed in v3.18-6219-g6de3980,
v3.18-6235-gb51f3be and v3.18-6217-ga76b194? Wieder keiner!? :)

So what basically happened was a stack corruption causing the return address
to be bogus. This only happened because the kernel version of cfg80211.h (which
is used to compile batman-adv) is different than the version in the mac80211
package (which is used at runtime) I have now synced that structure between the
OpenWrt kernel and the used compat-wireless, rebuild my OpenWrt and tried again.
I hope this helps anyone trying to use B.A.T.M.A.N. V on OpenWrt.

@Felix, would it be ok for you when I propose a
"*-sync-cfg80211-station_info.patch" for the 3.18 generic kernel patches?
Or do you have a good idea how to force the openwrt-routing batman-adv package
against the cfg80211.h of compat-wireless?

Kind regards,
	Sven
--nextPart4419566.UnT2k9yIuH
Content-Disposition: attachment; filename="999-sync-cfg80211-station_info.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="999-sync-cfg80211-station_info.patch"

From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 21 Jan 2016 14:07:32 +0100
Subject: [PATCH] sync cfg80211 station_info

batman-adv v2016.0 with B.A.T.M.A.N. V enabled will query the cfg80211
module for wireless station information. But the module is compiled against
the OpenWrt kernel but will be with the cfg80211 module from the mac80211
package. The result is a stack corruption when the definition of these two
headers are different.

But the cfg80211.h from the kernel can be synced easily against the
compat-wireless patch because it should not be used by the OpenWrt kernel.

This problem happens for example with the kernel v3.18 and compat-wireless
generated from 3.19 or later. The patch tries to avoid this by synching the
structure against mac80211 2016-01-10.
---
 include/net/cfg80211.h | 47 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index a2ddcf2..60c91cf 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -945,12 +945,14 @@ enum rate_info_flags {
  * @mcs: mcs index if struct describes a 802.11n bitrate
  * @legacy: bitrate in 100kbit/s for 802.11abg
  * @nss: number of streams (VHT only)
+ * @bw: bandwidth (from &enum rate_info_bw)
  */
 struct rate_info {
 	u8 flags;
 	u8 mcs;
 	u16 legacy;
 	u8 nss;
+	u8 bw;
 };
 
 /**
@@ -984,6 +986,24 @@ struct sta_bss_parameters {
 	u16 beacon_interval;
 };
 
+/**
+ * struct cfg80211_tid_stats - per-TID statistics
+ * @filled: bitmap of flags using the bits of &enum nl80211_tid_stats to
+ *	indicate the relevant values in this struct are filled
+ * @rx_msdu: number of received MSDUs
+ * @tx_msdu: number of (attempted) transmitted MSDUs
+ * @tx_msdu_retries: number of retries (not counting the first) for
+ *	transmitted MSDUs
+ * @tx_msdu_failed: number of failed transmitted MSDUs
+ */
+struct cfg80211_tid_stats {
+	u32 filled;
+	u64 rx_msdu;
+	u64 tx_msdu;
+	u64 tx_msdu_retries;
+	u64 tx_msdu_failed;
+};
+
 #define IEEE80211_MAX_CHAINS	4
 
 /**
@@ -991,11 +1011,12 @@ struct sta_bss_parameters {
  *
  * Station information filled by driver for get_station() and dump_station.
  *
- * @filled: bitflag of flags from &enum station_info_flags
+ * @filled: bitflag of flags using the bits of &enum nl80211_sta_info to
+ *	indicate the relevant values in this struct for them
  * @connected_time: time(in secs) since a station is last connected
  * @inactive_time: time since last station activity (tx/rx) in milliseconds
- * @rx_bytes: bytes received from this station
- * @tx_bytes: bytes transmitted to this station
+ * @rx_bytes: bytes (size of MPDUs) received from this station
+ * @tx_bytes: bytes (size of MPDUs) transmitted to this station
  * @llid: mesh local link id
  * @plid: mesh peer link id
  * @plink_state: mesh peer link state
@@ -1008,10 +1029,10 @@ struct sta_bss_parameters {
  * @chain_signal_avg: per-chain signal strength average in dBm
  * @txrate: current unicast bitrate from this station
  * @rxrate: current unicast bitrate to this station
- * @rx_packets: packets received from this station
- * @tx_packets: packets transmitted to this station
- * @tx_retries: cumulative retry counts
- * @tx_failed: number of failed transmissions (retries exceeded, no ACK)
+ * @rx_packets: packets (MSDUs & MMPDUs) received from this station
+ * @tx_packets: packets (MSDUs & MMPDUs) transmitted to this station
+ * @tx_retries: cumulative retry counts (MPDUs)
+ * @tx_failed: number of failed transmissions (MPDUs) (retries exceeded, no ACK)
  * @rx_dropped_misc:  Dropped for un-specified reason.
  * @bss_param: current BSS parameters
  * @generation: generation number for nl80211 dumps.
@@ -1031,6 +1052,11 @@ struct sta_bss_parameters {
  * @nonpeer_pm: non-peer mesh STA power save mode
  * @expected_throughput: expected throughput in kbps (including 802.11 headers)
  *	towards this station.
+ * @rx_beacon: number of beacons received from this peer
+ * @rx_beacon_signal_avg: signal strength average (in dBm) for beacons received
+ *	from this peer
+ * @pertid: per-TID statistics, see &struct cfg80211_tid_stats, using the last
+ *	(IEEE80211_NUM_TIDS) index for MSDUs not encapsulated in QoS-MPDUs.
  */
 struct station_info {
 	u32 filled;
@@ -1071,10 +1097,9 @@ struct station_info {
 
 	u32 expected_throughput;
 
-	/*
-	 * Note: Add a new enum station_info_flags value for each new field and
-	 * use it to check which fields are initialized.
-	 */
+	u64 rx_beacon;
+	u8 rx_beacon_signal_avg;
+	struct cfg80211_tid_stats pertid[IEEE80211_NUM_TIDS + 1];
 };
 
 /**

--nextPart4419566.UnT2k9yIuH--


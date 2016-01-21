Return-Path: <nbd@openwrt.org>
References: <8047297.0qIFjkW2bL@voltaire> <6825353.GnzNjs5eRJ@bentobox>
 <4178376.2Vigxs1Xtt@bentobox>
From: Felix Fietkau <nbd@openwrt.org>
Message-ID: <56A0E335.8040207@openwrt.org>
Date: Thu, 21 Jan 2016 14:55:01 +0100
MIME-Version: 1.0
In-Reply-To: <4178376.2Vigxs1Xtt@bentobox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] OpenWrt cfg80211.h station_info incompatibility
 with kernel+mac80211 [was: B.A.T.M.A.N. V leaves the nest v2]
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@open-mesh.com>, b.a.t.m.a.n@lists.open-mesh.org
Cc: openwrt-devel@lists.openwrt.org, Marek Lindner <mareklindner@neomailbox.ch>

On 2016-01-21 14:47, Sven Eckelmann wrote:
> On Thursday 21 January 2016 12:56:01 Sven Eckelmann wrote:
>> Just installed in on some hardware (2x OM5P + OpenWrt 44654 + compat-wireless
>> 2015-10-26) and enabled BATMAN_V.
>>
>> [  168.540000] CPU 0 Unable to handle kernel paging request at virtual address fffffff0, epc == 86d8301c, ra == 86d8301c
>> [  168.550000] Oops[#1]:
>> [  168.550000] CPU: 0 PID: 265 Comm: kworker/u2:2 Tainted: P               3.18.8 #1
>> [  168.550000] Workqueue: bat_events batadv_v_elp_throughput_metric_update [batman_adv]
> [..]
>> [  168.550000] epc   : 86d8301c batadv_v_elp_throughput_metric_update+0x20/0x58 [batman_adv]
>> [  168.550000]     Tainted: P              
>> [  168.550000] ra    : 86d8301c batadv_v_elp_throughput_metric_update+0x20/0x58 [batman_adv]
> 
> Who knew that struct station_info changed in v3.18-6219-g6de3980,
> v3.18-6235-gb51f3be and v3.18-6217-ga76b194? Wieder keiner!? :)
> 
> So what basically happened was a stack corruption causing the return address
> to be bogus. This only happened because the kernel version of cfg80211.h (which
> is used to compile batman-adv) is different than the version in the mac80211
> package (which is used at runtime) I have now synced that structure between the
> OpenWrt kernel and the used compat-wireless, rebuild my OpenWrt and tried again.
> I hope this helps anyone trying to use B.A.T.M.A.N. V on OpenWrt.
> 
> @Felix, would it be ok for you when I propose a
> "*-sync-cfg80211-station_info.patch" for the 3.18 generic kernel patches?
> Or do you have a good idea how to force the openwrt-routing batman-adv package
> against the cfg80211.h of compat-wireless?
The openwrt mac80211 package exports its headers to
$(STAGING_DIR)/usr/include/mac80211

You could just make the batman-adv package use those includes.

- Felix

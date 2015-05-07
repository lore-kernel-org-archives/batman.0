Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 07 May 2015 20:19:45 +0200
Message-ID: <1486395.xYm1ShFBoJ@bentobox>
In-Reply-To: <841E254B092F4FC1839DD066D90CE802@telegridtech.com>
References: <841E254B092F4FC1839DD066D90CE802@telegridtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] FW: using Batman-adv
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
To: b.a.t.m.a.n@lists.open-mesh.org

On Thursday 07 May 2015 13:00:52 Joseph Zimmer wrote:
> 1)       Is there a way to adjust BATMAN using batctl to select routes based
> on the RSSI value?

No

> 2)       Does the algorithm for route selection use RSSI in the calculation
> and if so can we modify the algorithm to increase the importance of RSSI in
> the selection?

No.

> 3)       How do we gain access to the code to make these modifications?
> a.       Can you give me a little guidance on how to modify BATMAN-adv to
> suite my situation?

But you could patch your wifi driver/framework (for example mac80211) to 
provide an exported function which returns the rssi for a specific net_device 
(net_dev of the if_incoming) + the mac address of the other station (mac orig 
in orig_neigh_node). This function has to basically get the sinfo->signal_avg 
when the sta exists for this bss.

You have to make sure that this device is really a compatible ieee80211 device 
- otherwise your kernel might just crash when accessing the private data of 
the net_device. Maybe this is always true in your situation but I don't know 
your setup well enough. If it is a mixed setup then you can try the 
ieee80211_ptr trick from netdev_notify in net/mac80211/iface.c. This has to be 
done before you are using IEEE80211_DEV_TO_SUB_IF. You can check to 
ieee80211_get_station see a function which already does parts of what you want 
(but it has not yet this check). And also keep in mind that sinfo->signal_avg 
may not be set with correct data. You must check (sinfo->filled & 
STATION_INFO_SIGNAL_AVG) when you are creating a function similar to 
ieee80211_get_station for RSSI.


This code would have to be called when the neighbor tq is calculated in 
batadv_iv_ogm_calc_tq. It basically has to adjust batadv_ogm_packet->tq 
somewhere at the end of the function. The percentage of reduction would have 
to be chosen by you based on how "bad" the rssi value is. I don't have a good 
metric for that.


I am not sure if Antonio/Marek have some proof of concept in their BATMAN V 
branch. But I think they wanted to use the bandwidth based approach which is 
queries the mac80211 rate control information [1].

Kind regards,
	Sven

[1] http://thread.gmane.org/gmane.linux.kernel.wireless.general/123514


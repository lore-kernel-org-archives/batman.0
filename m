Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 05 Sep 2018 19:40:59 +0200
Message-ID: <1576127.oZI3MRHkjJ@sven-edge>
In-Reply-To: <4468372.sfybEcOXZU@bentobox>
References: <2791173.mX5NbDZpiX@sven-edge>
 <aa797db.cdf1.165a3d64b19.Coremail.heishuihe2008@163.com>
 <4468372.sfybEcOXZU@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11297546.49WDlhIHMm";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] mcast_rate setting of wifi interface has
 significant effect to performance of V. Re:Re: Recent test result. Re:Re:
 Paper "Performance Evaluation of BATMAN-adv Wireless Mesh Network Routing
 Algorithms "
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
Cc: a@unstable.cc, mareklindner@neomailbox.ch, Ligang LIU <heishuihe2008@163.com>

--nextPart11297546.49WDlhIHMm
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 4. September 2018 12:34:35 CEST Sven Eckelmann wrote:
[...]
> > Although Antonio explained in the previous email,
> > "... if you have no data over the link, sending 2 probes of
> > 200bytes each every 500ms (default ELP interval) won't really eat much
> > airtime, unless you have a lot of idling 1-hop neighbours",
> > I think the ELP probe packets will occupy much wifi airtime,
> > because wlan is working on the SHARED media.
> > The transmission of ELP probe packets between idle 1-hop neighbours
> > can be heard by the other nodes and their transmission have to be delayed.
> > Consequently, the performance, delay and throughput, could be lowered down,
> > compared to batman-adv 4.
> 
> @Antonio, you must also keep in mind that the RTS + CTS frames are transmitted 
> at the lowest available rate (1Mbit/s in this case). The Ack is done with 
> 6Mbit/s in his dump. The broadcast is done with 18Mbit/s. The unicast stuff 
> seems to be send with MCS rates.
[...]

Maybe Marek is also interested in disabling the RTS for fallback rates on all devices.
The rts stuff is injected by minstrel_ht and can most likely be disabled using:

    --- a/net/mac80211/rc80211_minstrel_ht.c
    +++ b/net/mac80211/rc80211_minstrel_ht.c
    @@ -853,12 +853,12 @@ minstrel_ht_set_rate(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
     	 *  - if station is in dynamic SMPS (and streams > 1)
     	 *  - for fallback rates, to increase chances of getting through
     	 */
    -	if (offset > 0 ||
    +	/* if (offset > 0 ||
     	    (mi->sta->smps_mode == IEEE80211_SMPS_DYNAMIC &&
     	     group->streams > 1)) {
     		ratetbl->rate[offset].count = ratetbl->rate[offset].count_rts;
     		flags |= IEEE80211_TX_RC_USE_RTS_CTS;
    -	}
    +	}*/
     
     	ratetbl->rate[offset].idx = idx;
     	ratetbl->rate[offset].flags = flags;

(I hope this is ported correctly - his original patch was for an older version 
and thus looked slightly different)


What also could be interesting, would be to change consistently the 802.1d
priority (0-7) of the ELP probe packets on each device from 0 to something 
else. This could for example be done with:

    --- a/net/batman-adv/bat_v_elp.c
    +++ b/net/batman-adv/bat_v_elp.c
    @@ -230,6 +230,8 @@ batadv_v_elp_wifi_neigh_probe(struct batadv_hardif_neigh_node *neigh)
     			  BATADV_ELP_MIN_PROBE_SIZE);
     
     	for (i = 0; i < BATADV_ELP_PROBES_PER_NODE; i++) {
    +		u8 prio_802_1d = 0;
    +
     		elp_skb_len = hard_iface->bat_v.elp_skb->len;
     		skb = skb_copy_expand(hard_iface->bat_v.elp_skb, 0,
     				      probe_len - elp_skb_len,
    @@ -242,6 +244,7 @@ batadv_v_elp_wifi_neigh_probe(struct batadv_hardif_neigh_node *neigh)
     		 * throughput estimation effective.
     		 */
     		skb_put_zero(skb, probe_len - hard_iface->bat_v.elp_skb->len);
    +		skb->priority = 256 + prio_802_1d;
     
     		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
     			   "Sending unicast (probe) ELP packet on interface %s to %pM\n",

The TID in the QoS packets should change accordingly.

The default mapping for these prio_802_1d values can be found in 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/net/mac80211/wme.c?id=57361846b52bc686112da6ca5368d11210796804#n25

Kind regards,
	Sven
--nextPart11297546.49WDlhIHMm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAluQFSsACgkQXYcKB8Em
e0ZpzA/9HKMOJXoTsAxhwkT8+Hwm1+K0E8DQ7fT5irYV9e7gybWPxzW6+T33nHfY
+26lQQdjxyxEpJSiazU9VKxjrIIDwn9HgNWob0y7d8+G+KtsxBZQprjCI52EqUQG
6YsJW20MZs0y2DGqnQElWzWKA5l7nyKf8dVWkkujkGb+jrw0Y57UnZ9yxJOX6n3U
uhtl94VzpGd2y5rS7KnEWonXMg02OmiA1v1IToiHFRtRdLMsYVk3XSk/gNZ3xyzl
fHs/zDjm26VDX8Nqte3UYgIAYQp9kA9ZsI8cHBO45UpvYELszFAickZ29LRkBRsi
aoPeL8gVaCPtXvZDVLiWT59L5vOBIOtOMSxdnBHADC0wSsq9koK9+rqmRSoBtD03
gIPMmFKMX0v3BihuhbRP9o++LOM0FXZvHFLt6lQ6+8vPKieZualP0rI7JpYxhgda
NKxvkey9OmPi2FVp45tChBnUf0EnNjb2u/MKxcaO6QtpbFlzqGaRXXSBnhBc31ao
cGC/AoK/49tBhevR+taNnWdRTfcuzhdSrqto9QDZ7vxy1gl28eMzY6xjlQWpEgmA
vjIGYZcOeuL7wKsAqdr1divGsGDMiEn5ytO1zUY/mXvGx5gKOb1hGjG4zEErmDDk
h3QPzuXPP7WahlsSLM34J61jWQjtEXyf4agWOLN0n0CJY193hLA=
=3ksO
-----END PGP SIGNATURE-----

--nextPart11297546.49WDlhIHMm--




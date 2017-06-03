Return-Path: <xbing6@gmail.com>
From: Xuebing Wang <xbing6@gmail.com>
References: <edc163f6-a49c-21f3-9cf1-74df6e262fdb@gmail.com>
Message-ID: <30a44936-a1e9-4a50-00e2-e240bb09f4a2@gmail.com>
Date: Sat, 3 Jun 2017 16:45:28 +0800
MIME-Version: 1.0
In-Reply-To: <edc163f6-a49c-21f3-9cf1-74df6e262fdb@gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [B.A.T.M.A.N.] [wpa_supplicant] Is there a way to limit peers
 (to about 12) for IBSS/adhoc?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: hostap@lists.infradead.org, Masashi Honma <masashi.honma@gmail.com>
Cc: "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>, b.a.t.m.a.n@lists.open-mesh.org, simon Wunderlich <sw@simonwunderlich.de>, Sven Eckelmann <sven@narfation.org>, Jason Toschlog <jason.toschlog@gmail.com>, Adrian Chadd <adrian@freebsd.org>

Hi Honma-san,

Does max_peer_links apply to IBSS/adhoc (in addition to 802.11s mesh)? 
Thanks.

Xuebing Wang


On 2017年06月03日 12:09, Xuebing Wang wrote:
> Hi community,
>
> This email is mainly addressed to hostap/wpa_supplicant mailing list.
>
> Descriptions of my issue:
> - I am establishing IBSS/adhoc network using OpenWRT 15.05 + ath9k 
> (AR9331).
> - When nodes are relatively closely placed, the peers (the term is 
> 'neighbors' in batman-adv mesh) reach 40, ath9k driver detects "tx 
> hung, resetting the chip" (for RESET_TYPE_TX_HANG).
> - This ath9k "tx hung" randomly happens among the 40 nodes (in adhoc 
> network), and it happens relatively often (seemingly randomly for 
> nodes), and randomly makes some nodes un-usable.
> - This appears to be an issue with ath9k kernel driver or ath9k 
> hardware that it can not handle ~40 peers.
> - IBSS/adhoc with 20 peers work well.
>
> Is there a config in wpa_supplicant that we can limit the number of 
> peers?
>
> In the other words, once the number of peers ('iw wlan0 station dump') 
> reaches a pre-configured number (e.g. 12 or 16), wpa_supplicant does 
> not authenticate any more, for IBSS/adhoc only?
> - A subtle detail: once a new beacon with higher RSSI is detected, the 
> current connection with lowest RSSI will be de-authenticated, and to 
> authenticate this new peer (with higher RSSI in beacon).
>
> Is this "limiting number of peers for IBSS/adhoc" a good work-around 
> for 40+ peers adhoc network, although the ultimate root cause 
> seemingly is with ath9k kernel driver or ath9k hardware?
>
> Also, if there are many (like 40+) peers in IBSS/adhoc network, I am 
> not sure how medium access contention and collisions factor in, for 
> management frames?
>
> Here is my wpa_supplicant conf file:
> ------
> ctrl_interface=/var/run/wpa_supplicant
>
> # use 'ap_scan=2' on all devices connected to the network
> # this is unnecessary if you only want the network to be created when 
> no other networks are available
> ap_scan=2
>
> network={
>     ssid="Net-xxxxxxxx"
>     mode=1
>     frequency=2462
>     proto=WPA2
>     key_mgmt=WPA-PSK
>     pairwise=CCMP
>     group=CCMP
>     psk="xxxxxxxx"
> }
> ------
>
> Another approach could be to use user-space shell script to "iw <dev> 
> ibss leave" for the lower RSSI stations?
> - As I am using batman-adv to build mesh network on the top of 
> IBSS/adhoc, a similar approach can be done at batman-adv level.
>
> Suggestions?
>
> Thanks.
> Xuebing Wang
>


Return-Path: <xbing6@gmail.com>
From: Xuebing Wang <xbing6@gmail.com>
Message-ID: <a5949349-69fa-7ef5-fd78-88af76749e24@gmail.com>
Date: Sat, 30 Mar 2019 11:50:27 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [B.A.T.M.A.N.] About making batman-adv mesh network invisible (by
 encrypting Beacon frame)
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, sw@simonwunderlich.de
Cc: sven@narfation.org, hostap@lists.infradead.org

Hi community,

We have batman-adv + OpenWRT + ath9k chip + ath9k driver reliably 
running for about 2 years. The biggest batman-adv mesh network is with 
100+ nodes.

As this is a closed network, we have a new requirement which is to make 
our batman-adv mesh network invisible, although the current SSID is just 
some meaningless characters.

One thought is hidden_ssid. But, it seems hidden_ssid is only supported 
for AP mode (not IBSS mode).

802.11w does not protect Beacon frame (because it is before four-ways 
handshake).

As this is a closed network, what about encrypting Beacon (maybe all 
management frames later) using a hard-coded key in wpa_supplicant?

Thanks for your help.

Xuebing Wang


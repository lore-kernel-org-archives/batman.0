Return-Path: <SRS0=h/PO=75=vger.kernel.org=linux-wireless-owner@kernel.org>
Subject: Re: [PATCH] mac80211: mesh: add mesh_param "mesh_nolearn" to skip
 path discovery
References: <20200616095358.20143-1-linus.luessing@c0d3.blue>
From: =?UTF-8?Q?Linus_L=c3=bcssing?= <ll@simonwunderlich.de>
Message-ID: <cbe4863e-44f3-c0e4-a4f3-1b0a69f7a386@simonwunderlich.de>
Date: Tue, 16 Jun 2020 12:16:51 +0200
MIME-Version: 1.0
In-Reply-To: <20200616095358.20143-1-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
To: =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

> The new mesh_nolearn parameter allows to skip the PREQ/PREP exchange in
> this scenario, leading to a reduced delay, reduced packet buffering and
> simplifies HWMP in general.

Also another small remark regarding the simplification:

Next to the timer re-arming bug / crash [0] we also stumbled over 
another bug when using encryption on the 802.11s interfaces which we 
could quite solve yet:

We are seeing packet loss every four seconds due to a "DECRYPT CRC ERR". 
We could narrow this down to the PREQ. This somehow makes the receiver 
unable to decrypt the packet in hardware and also the fallback to 
software decryption fails as the hardware has messed up the encrypted 
data (looks completely different than what we saw in the air with a 
third device in monitor mode, unencrypted headers looked ok though). 
Furthermore, the hardware still sends ACKs for this frame... so no 
retries on the 802.11 layer, leading to ugly packet loss for one UDP 
packet every four seconds.

The hardware we were having this issue with is a Lima board with a QCA4531.

Setting ath9k nohwcrypt=1 on the sender side helps. And avoiding PREQs 
with this patch also helped in our batman-adv setup which had 
mesh_fwding disabled already anyway.

Regards, Linus


PS/Disclaimer: This bug was observed on an old LEDE version.


[0]: https://patchwork.kernel.org/patch/11566011/


Return-Path: <xbing6@gmail.com>
References: <a5949349-69fa-7ef5-fd78-88af76749e24@gmail.com>
 <7264236.pZJWJxn9C4@prime>
From: Xuebing Wang <xbing6@gmail.com>
Message-ID: <f2d6318d-a691-971e-9889-00867115303f@gmail.com>
Date: Sat, 6 Apr 2019 14:06:55 +0800
MIME-Version: 1.0
In-Reply-To: <7264236.pZJWJxn9C4@prime>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [B.A.T.M.A.N.] About making batman-adv mesh network invisible
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
Cc: b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org

Hi Simon,

Thanks a lot for your reply.

With ath9k chip and ath9k driver, do you think it is possible to use 
"proprietary modulation" (slightly modified), so wireshark + wlan in 
monitor mode won't be able to detect wireless frames batman-adv network 
sends?

Xuebing Wang

On 2019/4/1 下午5:59, Simon Wunderlich wrote:
> Hi Xuebing,
>
> at least for Ad-Hoc mode, you can't hide the SSID without changing the kernel
> driver (mac80211). Encrypting the beacon doesn't help here, as the SSID needs
> to be clear text eventually even if management frames get encrypted.
>
> Cheers,
>         Simon
>
> On Saturday, March 30, 2019 11:50:27 AM CEST Xuebing Wang wrote:
>> Hi community,
>>
>> We have batman-adv + OpenWRT + ath9k chip + ath9k driver reliably
>> running for about 2 years. The biggest batman-adv mesh network is with
>> 100+ nodes.
>>
>> As this is a closed network, we have a new requirement which is to make
>> our batman-adv mesh network invisible, although the current SSID is just
>> some meaningless characters.
>>
>> One thought is hidden_ssid. But, it seems hidden_ssid is only supported
>> for AP mode (not IBSS mode).
>>
>> 802.11w does not protect Beacon frame (because it is before four-ways
>> handshake).
>>
>> As this is a closed network, what about encrypting Beacon (maybe all
>> management frames later) using a hard-coded key in wpa_supplicant?
>>
>> Thanks for your help.
>>
>> Xuebing Wang

Return-Path: <fboehm@aon.at>
References: <20161128212505.Horde.S4UVNu_tyJh3C4mpeY9N2E3@slackmail.co.uk>
From: fboehm <fboehm@aon.at>
Message-ID: <74a8bb5d-b9aa-26ea-a486-71560136f145@aon.at>
Date: Tue, 29 Nov 2016 06:18:05 +0100
MIME-Version: 1.0
In-Reply-To: <20161128212505.Horde.S4UVNu_tyJh3C4mpeY9N2E3@slackmail.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Batman-adv over LoRa?
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

Am 2016-11-28 um 22:25 schrieb sam@bristolwireless.net:
>
> Hi All
>
> I'm interested in a long-range, low bandwidth, low power mesh network.
>
> I'm wondering if it's as easy as buying a Tplink 3020, sticking OpenWrt
> on it and plugging in a LoRa USB
> http://webshop.imst.de/radio-modules/lora-products/iu880b-long-range-usb-adapter-74.html
> then configuring BATMAN to talk over that interface?
>
> The aim is to Run MDP over it
> http://developer.servalproject.org/dokuwiki/doku.php?id=content:tech:mdp
> So that mobile phones can access data/short messages over the wireless
> interface of the TPlink/ OpenWRT device, using the Serval app
> https://play.google.com/store/apps/details?id=org.servalproject&hl=en_GB
> (VOIP isn't going to be possible)
>
> So LoRa as level 1
> BATMAN as level 2
> MDP as level 3
>
> Is this at all feasible? Is it easy? (I suspect not!)
>
> Has anyone tried BATMAN over LoRa?
>
> More on LoRa here:
> http://static1.squarespace.com/static/54cecce7e4b054df1848b5f9/t/57489e6e07eaa0105215dc6c/1464376943218/Reversing-Lora-Knight.pdf
>
>
> Thanks
>
> Sam
>
>
>
The exceptional high range of LoRa (and other IoT radios) comes at the 
price of several constraints. Mainly limited throughput, packet size and 
duty cycle.

I dare to say that none of the popular 802.11 based mesh protocols are 
suitable in combination with IoT-focused wireless technologies.

Within IoT-based wireless technologies it's not uncommon to talk about 
messages at the size of just a few bytes instead of kilobytes and how 
few messages per day can be transmitted to a node.

In this respect I'm pretty sure a routing protocol needs to be an 
integral part of the IoT infrastructure itself to not eat up all the 
available ressources and those leave room for some real application payload.

While also the application software itself needs to be adapted to such 
an environment to not create too many (or too big) messages and those 
render the network useless for concurrent access.

Kind regards,
Franz

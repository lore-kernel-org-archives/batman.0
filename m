Return-Path: <ufo@rund.freifunk.net>
References: <20161128212505.Horde.S4UVNu_tyJh3C4mpeY9N2E3@slackmail.co.uk>
 <74a8bb5d-b9aa-26ea-a486-71560136f145@aon.at>
From: Ufo <ufo@rund.freifunk.net>
Message-ID: <583D764B.9090501@rund.freifunk.net>
Date: Tue, 29 Nov 2016 13:36:27 +0100
MIME-Version: 1.0
In-Reply-To: <74a8bb5d-b9aa-26ea-a486-71560136f145@aon.at>
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

at battlemesh mailinglist there was a discussion about that some weeks 
ago: please read

http://ml.ninux.org/pipermail/battlemesh/2016-August/thread.html
http://ml.ninux.org/pipermail/battlemesh/2016-September/thread.html

ufo

On 29.11.2016 06:18, fboehm wrote:
> Am 2016-11-28 um 22:25 schrieb sam@bristolwireless.net:
>>
>> Hi All
>>
>> I'm interested in a long-range, low bandwidth, low power mesh network.
>>
>> I'm wondering if it's as easy as buying a Tplink 3020, sticking OpenWrt
>> on it and plugging in a LoRa USB
>>
> The exceptional high range of LoRa (and other IoT radios) comes at the 
> price of several constraints. Mainly limited throughput, packet size 
> and duty cycle.
>
> I dare to say that none of the popular 802.11 based mesh protocols are 
> suitable in combination with IoT-focused wireless technologies.
>
> Within IoT-based wireless technologies it's not uncommon to talk about 
> messages at the size of just a few bytes instead of kilobytes and how 
> few messages per day can be transmitted to a node.
>
> In this respect I'm pretty sure a routing protocol needs to be an 
> integral part of the IoT infrastructure itself to not eat up all the 
> available ressources and those leave room for some real application 
> payload.
>
> While also the application software itself needs to be adapted to such 
> an environment to not create too many (or too big) messages and those 
> render the network useless for concurrent access.
>
> Kind regards,
> Franz


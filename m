Return-Path: <gfree.wind@gmail.com>
MIME-Version: 1.0
In-Reply-To: <850ff61e-8f94-9316-ed1f-c7d3e8faf95b@cogentembedded.com>
References: <1479688779-1328-1-git-send-email-fgao@ikuai8.com>
 <850ff61e-8f94-9316-ed1f-c7d3e8faf95b@cogentembedded.com>
From: Feng Gao <gfree.wind@gmail.com>
Date: Mon, 21 Nov 2016 19:01:12 +0800
Message-ID: <CA+6hz4qFrZpC7CYRq1OFJP8y_Zj1LG3qaFZGJNW8rNf=E__4bA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] [PATCH net 1/1] net: batman-adv: Treat
	NET_XMIT_CN as transmit successfully
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: mareklindner@neomailbox.ch, Linux Kernel Network Developers <netdev@vger.kernel.org>, b.a.t.m.a.n@lists.open-mesh.org, a@unstable.cc, "David S. Miller" <davem@davemloft.net>

Hi Sergei,

On Mon, Nov 21, 2016 at 6:44 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
> On 11/21/2016 3:39 AM, fgao@ikuai8.com wrote:
>
>> From: Gao Feng <fgao@ikuai8.com>
>>
>> The tc could return NET_XMIT_CN as one congestion notification, but
>> it does not mean the packe is lost. Other modules like ipvlan,
>
>
>    Packet.

Thanks, it was typo.

>
>> macvlan, and others treat NET_XMIT_CN as success too.
>>
>> So batman-adv should add the NET_XMIT_CN check.
>>
>> Signed-off-by: Gao Feng <fgao@ikuai8.com>
>
>
> [...]
>
>> diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
>> index 7e8dc64..8edd324 100644
>> --- a/net/batman-adv/routing.c
>> +++ b/net/batman-adv/routing.c
>> @@ -706,7 +706,7 @@ static int batadv_route_unicast_packet(struct sk_buff
>> *skb,
>>                 goto out;
>>
>>         /* translate transmit result into receive result */
>> -       if (res == NET_XMIT_SUCCESS) {
>> +       if (res == NET_XMIT_SUCCESS || ret == NET_XMIT_CN) {

Thanks again.
I didn't find it during myself's review and compile process.

>
>
>    Not 'res == NET_XMIT_CN'?
>
>>                 /* skb was transmitted and consumed */
>>                 batadv_inc_counter(bat_priv, BATADV_CNT_FORWARD);
>>                 batadv_add_counter(bat_priv, BATADV_CNT_FORWARD_BYTES,
>
> [...]
>
> MBR, Sergei
>

I have sent the v2 patch which corrects these two typos.

Best Regards
Feng

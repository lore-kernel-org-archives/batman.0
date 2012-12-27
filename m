Return-Path: <emunicio@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201212181202.37062.lindner_marek@yahoo.de>
References: <50CFB476.4070207@nixbits.net>
 <201212181202.37062.lindner_marek@yahoo.de>
From: Esteban Municio <emunicio@gmail.com>
Date: Thu, 27 Dec 2012 17:59:40 -0500
Message-ID: <CAMVTf1jF4eLRFVxiijFRGbohit2umFN1gSn7xce0+NN6H7SxNA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] Batman-Adv & iptables mac filtering
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Could you use ebtables instead?

2012/12/17 Marek Lindner <lindner_marek@yahoo.de>:
> On Tuesday, December 18, 2012 08:10:30 HeXiLeD wrote:
>> This is probably a openwrt question but even so it might have some
>> impact on batman-adv.
>>
>> I am planing to use mac filtering through iptables on openwrt with a
>> default policy of deny all, allowing only by white list the clients that
>> will be allowed t connect.
>>
>>
>> My question to the batman team is if by applying this idea and since
>> batman-adv uses MACs to manage the routing; if i will have to white list
>> the other router MACs on the router or routers that will be filtering
>> MACs with iptables or batman-adv is not affected by mac filtering.
>
> iptables works on layer3. Even though you have a mac address filter option it
> will only catch anything if the packet is moved up to layer3 which does not
> happen for batman-adv packets. So, iptables will never even see the packets
> used by batman-adv.
>
> Cheers,
> Marek



-- 
Esteban

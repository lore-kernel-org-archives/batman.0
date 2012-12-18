Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 18 Dec 2012 12:02:36 +0800
References: <50CFB476.4070207@nixbits.net>
In-Reply-To: <50CFB476.4070207@nixbits.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201212181202.37062.lindner_marek@yahoo.de>
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
To: b.a.t.m.a.n@lists.open-mesh.org, HeXileD@nixbits.net

On Tuesday, December 18, 2012 08:10:30 HeXiLeD wrote:
> This is probably a openwrt question but even so it might have some
> impact on batman-adv.
> 
> I am planing to use mac filtering through iptables on openwrt with a
> default policy of deny all, allowing only by white list the clients that
> will be allowed t connect.
> 
> 
> My question to the batman team is if by applying this idea and since
> batman-adv uses MACs to manage the routing; if i will have to white list
> the other router MACs on the router or routers that will be filtering
> MACs with iptables or batman-adv is not affected by mac filtering.

iptables works on layer3. Even though you have a mac address filter option it 
will only catch anything if the packet is moved up to layer3 which does not 
happen for batman-adv packets. So, iptables will never even see the packets 
used by batman-adv.

Cheers,
Marek

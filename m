Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 11 Jun 2012 07:29:05 +0800
References: <CAHD-aqK3yvVCDi9wucx4nX5jM4OjxbjbUFz3QHG+KzzuoMhz7Q@mail.gmail.com>
In-Reply-To: <CAHD-aqK3yvVCDi9wucx4nX5jM4OjxbjbUFz3QHG+KzzuoMhz7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201206110729.05945.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv gw_mode and ipv6 router advertisements
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Monday, June 11, 2012 07:14:27 Guido Iribarren wrote:
> Are there any plans of implementing in batman-adv something analog to
> the mangling done on DHCPv4 packets, to RA packets as well? (the
> mechanism would be the inverse: instead of unicasting queries and
> replies, propagate to clients only 1 RA packet out of all incoming;
> decide which one to propagate based on gw_mode current logic)
> 
> Or, at least, extend the current mangling done in DHCPv4 packets to
> DHCPv6 packets as well?

What makes you think DHCPv6 is not working ? It should ...

Regards,
Marek

Return-Path: <post@tiwoc.de>
Message-ID: <4AB28C2D.7060600@tiwoc.de>
Date: Thu, 17 Sep 2009 21:21:17 +0200
From: Daniel Seither <post@tiwoc.de>
MIME-Version: 1.0
References: <AACE951F705644649DB6ABC24CFBCF29@youillmlpt3>
	<8c906fa50909171115v2b296844h69c5f93eea99403c@mail.gmail.com>
In-Reply-To: <8c906fa50909171115v2b296844h69c5f93eea99403c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] IP from MAC
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

Gustavo Lindberg wrote:
> Then, At a meeting of 60 people there is the 99% probability  of the least
> two men have a  birthday the same day. So,, Similarly to the case of
> MAC-Adress is:
> 
> P(r)=1-65536!/(65536^r * (65536-r)!)

Robin uses 3 bytes of the MAC address to choose the IP address of the
mesh interface, not only 2 bytes = 65536 possibilities. This leads to
2^24 = 16777216 different addresses.

Expressed in PARI/GP syntax, you get the following formula:

p(n) = 1 - (factorial(2^24) / ((2^24)^n * factorial(2^24 - n)))

For a network of n=1000 nodes, PARI/GP calculates a probability of about
3 % for an address collision, which should pose no problem.

This is only valid if the NIC vendors randomly choose the MAC addresses
of their cards; chances are that they simply increment the address for
each NIC manufactured. This would increase the possibility of collisions.

However, as Marek already wrote, the focus of the batman development
moves to layer 2 where IP addresses are not used. On top of batman-adv,
you can use any IP address distribution scheme you like. For example,
you could simply run a DHCP server.

Regards,
Daniel

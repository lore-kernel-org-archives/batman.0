Return-Path: <post@tiwoc.de>
Message-ID: <4AB29DDF.3050303@tiwoc.de>
Date: Thu, 17 Sep 2009 22:36:47 +0200
From: Daniel Seither <post@tiwoc.de>
MIME-Version: 1.0
References: <AACE951F705644649DB6ABC24CFBCF29@youillmlpt3>	<8c906fa50909171115v2b296844h69c5f93eea99403c@mail.gmail.com>	<4AB28C2D.7060600@tiwoc.de>
	<8c906fa50909171314lb275b23vf87bd2852e3bd244@mail.gmail.com>
In-Reply-To: <8c906fa50909171314lb275b23vf87bd2852e3bd244@mail.gmail.com>
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

Gustavo Lindberg schrieb:
> 2009/9/17 Daniel Seither <post@tiwoc.de>
> 
>> Gustavo Lindberg wrote:
>>> Then, At a meeting of 60 people there is the 99% probability  of the
>> least
>>> two men have a  birthday the same day. So,, Similarly to the case of
>>> MAC-Adress is:
>>>
>>> P(r)=1-65536!/(65536^r * (65536-r)!)
>> Robin uses 3 bytes of the MAC address to choose the IP address of the
>> mesh interface, not only 2 bytes = 65536 possibilities. This leads to
>> 2^24 = 16777216 different addresses.
>>
> 
> All IP addresses are derived by device's MAC address, if MAC is
> aa:bb:cc:dd:ee:ff then ath0 IP (mesh iface) will be 5.dd:ee:ff while ath1 IP
> and ath2 IP will be 101.ee:ff:1 and 102.ee:ff:1 (obviously in decimal
> format).

I read this before, but now I realize that colliding IP addresses of the
ath1/2 interfaces are a problem. This seriously limits the number of
nodes in the network for reasonably low collision probabilities. With
200 nodes, you already have a probability greater than 25%. Enter IPv6...

Regards,
Daniel

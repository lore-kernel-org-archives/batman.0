From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 29 Apr 2009 11:14:20 +0800
References: <4313f3060904281042l39d51140we6440d1cff0b74c7@mail.gmail.com>
In-Reply-To: <4313f3060904281042l39d51140we6440d1cff0b74c7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200904291114.21272.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Gateway on multiple interfaces
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


Hi,

> Is there something I can do to get it to work on the secondary interface?

I'm not 100% about your setup. The problem occurs if the gateway client tries 
to retrieve an IP address from the gateway via the gateways secondary 
interface ? 


> On the gateway, I am using:
> batmand -d 3 -g 11000 -a 10.2.1.0/24 --disable-client-nat
> --hop-penalty 5 --purge-timeout 10000 ath0 eth0
> ath0 is IP 10.0.2.1/16
> eth0 is IP 10.255.2.1/16

On the gateway the option "--disable-client-nat" has no effect. I just commited 
an additional warning that should indicate that in the future.

Regards,
Marek


MIME-Version: 1.0
In-Reply-To: <200904291114.21272.lindner_marek@yahoo.de>
References: <4313f3060904281042l39d51140we6440d1cff0b74c7@mail.gmail.com>
	<200904291114.21272.lindner_marek@yahoo.de>
Date: Wed, 29 Apr 2009 09:09:45 -0500
Message-ID: <4313f3060904290709pa110250id52cf0c176e977f8@mail.gmail.com>
From: Nathan Wharton <naw@greptar.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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

On Tue, Apr 28, 2009 at 10:14 PM, Marek Lindner <lindner_marek@yahoo.de> wrote:

> I'm not 100% about your setup. The problem occurs if the gateway client tries
> to retrieve an IP address from the gateway via the gateways secondary
> interface ?

Yes.  It occurs if the interfaces through which the gateway and client
can communicate are not the interfaces listed first on the command
line.

>> On the gateway, I am using:
>> batmand -d 3 -g 11000 -a 10.2.1.0/24 --disable-client-nat
>> --hop-penalty 5 --purge-timeout 10000 ath0 eth0
>> ath0 is IP 10.0.2.1/16
>> eth0 is IP 10.255.2.1/16
>
> On the gateway the option "--disable-client-nat" has no effect. I just commited
> an additional warning that should indicate that in the future.
>
> Regards,
> Marek

Will it still be in effect if it is no longer the gateway, and the
gateway moves to another node in the mesh?  All the nodes start with
-r 2, and a batmand -c -g is issued on a node that finds an uplink.
If it loses the uplink, batmand -c -r 2 is issued, and
--disable-client-nat should still be on.

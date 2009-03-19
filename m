From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 19 Mar 2009 10:55:41 +0800
References: <3ebdcf0a0903180743q3968e6a0wd480347cf70a50ff@mail.gmail.com>
In-Reply-To: <3ebdcf0a0903180743q3968e6a0wd480347cf70a50ff@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200903191055.53458.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Problem with B.A.T.M.A.N. 0.3.1 rv1206
	(compatibility version 5)
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

> 1) B.A.T.M.A.N. daemon only works whether launched in debug mode. I'm sure
> about this because I'm monitoring the network with a packet sniffer.

how sure are you about this ? So far nobody could observe this bug. 
Batman checks whether the interface is up & running before sending packets. If 
the interface is not up batman will sit there and wait until the interface 
becomes available. May be thats what you saw ?


> 2) When launched in debug mode (using the command batmand -d 3 ath0 &), the
> daemon starts to generate OGMs and to fill up its routing tables in a
> correct way. The problem occurs when I tries to ping an host in the network
> because the routing process uses the default routing table (that has not
> been modified by the batman daemon) and it is not aware on the correct
> batman routing tables.

All packets go through the whole Linux routing mechanism not only the default 
table. Batman installs routing rules to jump to the batman routing tables 
(see: http://www.open-mesh.net/wiki/RoutingVodoo).
Please provide some more details regarding your setup, e.g. do you try to ping 
another batman node ? Do you try to ping a node that uses the same IP address 
space but has no batman running ?

Regards,
Marek


From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 11 Apr 2009 08:54:25 +0800
References: <3ebdcf0a0903180743q3968e6a0wd480347cf70a50ff@mail.gmail.com>
In-Reply-To: <3ebdcf0a0903180743q3968e6a0wd480347cf70a50ff@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200904110854.25869.lindner_marek@yahoo.de>
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


> 2) When launched in debug mode (using the command batmand -d 3 ath0 &), the
> daemon starts to generate OGMs and to fill up its routing tables in a
> correct way. The problem occurs when I tries to ping an host in the network
> because the routing process uses the default routing table (that has not
> been modified by the batman daemon) and it is not aware on the correct
> batman routing tables.

Nico from OpenWRT opened a ticket which you can find here:
https://dev.openwrt.org/ticket/4915

He also applied a ulibc fix for this bug today:
https://dev.openwrt.org/changeset/15193

If you checkout the latest 8.09 OpenWRT branch batman should be working as 
expected. Could you verify this ?

Regards,
Marek


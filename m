From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] strange default routes
Date: Mon, 15 Oct 2007 16:08:47 +0200
References: <BLU122-W10D014E29FA86CA3739C9AF6A30@phx.gbl>
In-Reply-To: <BLU122-W10D014E29FA86CA3739C9AF6A30@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710151608.47855.lindner_marek@yahoo.de>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


Hi,

> root@OpenWrt:/etc/init.d# route -n
> Destination  Gateway  Genmask  Flags Metric Ref    Use Iface
> [...]
> 0.0.0.0         0.0.0.0     0.0.0.0      !        0         0       0     *
> [...]
>
> batmand has been started with the following parameters:  /usr/sbin/batmand
> -g 0 -r 0 eth2

as Antonio said you disabled all internet traffic via batman.
Furthermore, default routes created by batman are found in table 68 (use "ip 
route ls table 68" to see its content) but "route -n" shows you table 254.


> root@OpenWrt:/etc/init.d# /usr/sbin/batmand -g 0 -r 0 eth2:0 -d 4
> WARNING: You are using the unstable batman branch. If you are interested in
> [ 0] Error - can't add rule to 105.0.0.0/8: Invalid argument
> [ 0] Error - can't add rule to 105.0.0.0/8: Invalid argument
> Using interface eth2:0 with address 105.13.0.54 and broadcast address
> 105.255.255.255 B.A.T.M.A.N. 0.3-beta (compatibility version 4)
> [ 0] Error - can't add rule to 0.0.0.0/0: Invalid argument
> [ 10] Error - can't add rule to 0.0.0.0/0: Invalid argument

Here batman tries to set the policy routing rules and not routing table 
entries. It would be interesting to know the revision you use and could you 
please add the output of (while batmand is running) "ip rule".

Regards,
Marek

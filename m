Date: Sun, 4 Nov 2007 02:38:03 +0000 (GMT)
From: Marek Lindner <lindner_marek@yahoo.de>
Subject: AW: [B.A.T.M.A.N.] Experiences with B.A.T.M.A.N. 0.3-beta rv767
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-ID: <608063.48687.qm@web26903.mail.ukl.yahoo.com>
Content-Transfer-Encoding: 8bit
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

> We playing around with B.A.T.M.A.N. 0.3-beta rv767 in our leipziger
> Freifunk-testing-Firmware (based on v1.6.10):

> the Routing works fine (if i start "batmand  eth1:bat vlan1:bat") -
> great work!

exciting to hear. Keep us informed about all the trouble you experience
so that we can work on it.


> but the gateway-function (option "-r 2") drives me mad:
>
> * why the tunnel-interface (gateX) now have IP-Adresses!?

Simply said the "get virtual IP on demand" mode had some problems
especially with the fact that the interface has no IP address when the
first packets arrive. So we went through a whole process of fixing that
following problems by setting the new address in these packets, then
recalculating the checksums, implementing a lightweight NAT for
returning packets. After all that there were still issues which could not
be addressed easily. On the other hand we give away the chance to
check whether the tunnel port is blocked or not until the user needs the
connection.
Now batman hands out IP addresses proactively. We are waiting for 
real world feedback to see if we run into new problems. So far it seems
to work.


> * what this log-message (on gateway) wants to tell me? (105.61.89.81 is
>  an Node who wants to build up an gateway-tunnel)

>> Nov  3 16:49:38 (none) kern.err batmand[1819]: Error - got packet
 from
>> unknown client: 105.61.89.81 (virtual ip 104.61.13.37)  

The batman gateway checks if the tunnelled packet has a known wifi IP
address corresponding to a known virtual IP address. 104.61.13.37 is
obviously a wrong IP address. I would guess that this is an OLSR 
address ? May be we have a problem with gatewaying alias interfaces ?

@Axel: Did you experience that kind of problem ? May be we have to set
the source address explicitely. I look into that.


> * I noticed, that LAN-clients (on batmannodes) sometimes get 169.x.y.z
>  Addresses per DHCP if i start  batmand with "-r 2"-option?

If so that has nothing to do with batman. Even if batman has an internal
mini "give IP" server it is an own lightweight protocol which is not 
compatible with the real DHCP.
Actually this IP range is to be used if you can't connect to a DHCP server
and have no fixed address set.


> B.A.T.M.A.N. 0.2 worked fine, but we want/must use B.A.T.M.A.N. 0.3,
> because the available policy-routing cause no problems with parallel
> driven olsrd.

I understand.

Regards,
Marek







      Heute schon einen Blick in die Zukunft von E-Mails wagen? www.yahoo.de/mail


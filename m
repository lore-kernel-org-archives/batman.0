References: <200711111816.18242.axel@open-mesh.net>
	<840E3F681DF3D043B353C0FDD4A6C353ABFC97@ex9.hostedexchange.local>
In-Reply-To: <840E3F681DF3D043B353C0FDD4A6C353ABFC97@ex9.hostedexchange.local>
Date: Sun, 11 Nov 2007 23:30:11 +0100
Message-ID: <000301c824b2$6f055c20$4d101460$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
From: Predrag Balorda <predrag.balorda@gmail.com>
Subject: [B.A.T.M.A.N.] batman gw nodes and routing (rv792)
Reply-To: pele@balorda.com,
	The list for a Better Approach To Mobile Ad-hoc Networking
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
To: 'The list for a Better Approach To Mobile Ad-hoc Networking' <b.a.t.m.a.n@open-mesh.net>

This is my setup - I sincerely hope ascii-art holds up as it took some time
to create! :-)

                 gateway
Internet ---- 123.456.789.100      router1
                     10.0.0.1 --- 10.0.0.10             router2
router3
                         (ath0)   105.0.0.1 --batman-- 105.0.0.2 --batman--
105.0.0.3
                         (eth0)    10.0.1.0             10.0.2.0
10.0.3.0
                         (bat0) 169.254.0.0 --PtP-- 169.254.2.79
                         (bat0) 169.254.0.0 --------------PtP-----------
169.254.2.80

I have read the bmx pdf and it is excellent. Everything works as it should
on batman-exp  rv792. But I have a problem. The guide assumes that your
gateway to the public internet is my 'router1' and it also assumes that you
have a firewall running on all those routers.

It also ends up with double-nat (well, actually triple-nat in my case). I
have gotten rid of one level of nat (on router1). But I'm still left with a
double nat.

Nat happens when default route traffic from batman nodes is sent down bat0
tunnel and then once again when my gateway passes it onto the public ip
space.

I have succeeded in creating a setup where no nat is done when client nodes
connect to 10.0.0.0/24 network (10.0.0.0/24 hna on router1) but if I want to
go out onto the internet I simply have to do 

iptables -t nat -A POSTROUTING -o bat0 -j MASQUERADE

on each batman node, otherwise nodes themselves can get out but their eth0
clients cannot (i.e. from 10.0.2.0/24 or 10.0.3.0/24 - 10.0.1.0/24 doesn't
have this problem as it has a default route entry in the output of 'route' -
other batman nodes don't)

Can someone with a bit more experience in these matters give me a hand. I
will probably end up having to use batman on gateway node as well but I'd
rather have this possibility of a gw node not runnig batman.

Thanks again!

Pele


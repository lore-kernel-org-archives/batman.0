Message-ID: <ba16c324897fee6d1842df2085f702b5.squirrel@wm.ddmesh.de>
In-Reply-To: <14659.85.41.146.90.1214391124.squirrel@krisma.oltrelinux.com>
References: <14659.85.41.146.90.1214391124.squirrel@krisma.oltrelinux.com>
Date: Wed, 25 Jun 2008 14:51:22 +0200 (CEST)
From: freifunk@ddmesh.de
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] Re: routing script
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
To: b.a.t.m.a.n@open-mesh.net

Hi Antonio,

As I know you can not directly trigger to change the default route.
batmand allows you to setup a ip address that should be used as gateway.
<batmand -p ip>
What the script does I don't know. Actually I do not use it as the routing
that batmand-experimental does with its arguments works fine.

> ip route add 0.0.0.0/0 via 0.0.0.0 src 169.254.0.1 dev gate0 table 68
does setup a default route for dev gate0. gate0 is created by batmand
and the ip is taken from a ip range that is never routed in internet.

As soon as batmand detects a working gateway it creates this tunnel and
the tunnel interface gate0. Depending on the routing parameters "-r"
batmand chooses the gateway. If you specify the -p option to pass a
ip of the network (not from range 169.254.x.x) and the gateway is working,
it is used. If this gateway does not work, batmand chooses the gateway
depending on the -r option.

if you look at the router script you will see that it only prints the
commands and does not really execute it.
You have to remove the "echo" in front of the command or keep the line and
add your own commands to add/del the rules/routes.

If not no routes are setup at all and your network shouldn't work.
When I remember right, if you specifiy a routing script batmand does not
set rules/routes anymore and pass the complete control to the script.

/Stephan

> Hi Stephan
>
> I too am interested to capture the gateway-switching from application
> layer, but looking at the log produced by a custom-policy-routing
> script I can only see something like:
>
> ip route add 0.0.0.0/0 via 0.0.0.0 src 169.254.0.1 dev gate0 table 68
>
> that is the initialization of the tunnel with a 169.254/16 IP address.
> Any idea about triggering the gateway change?
>
> I've a bit edited the default script as included, hope this could be
> useful.
>
>
> Antonio
>
>
>
>



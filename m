Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 6 Sep 2009 23:11:22 +0800
References: <4AA34865.9000203@rsm-freilassing.de>
In-Reply-To: <4AA34865.9000203@rsm-freilassing.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200909062311.22521.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Problems with Gateway-Selection without option -g
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


Hi,

> When i try to start BATMAN on the Gateway with this options:
>    batmand -g 30mbit/2mbit
> 
> the clients will create a gate0 interface. I do not need this gate0
> interface. All routers have static public ip-addresses assigned. The
> once that i need is, that BATMAN inserts a DEFAULT-ROUTE to the next
> neighbour hop thats reach the gateway.

I don't understand why you have the feeling the gate0 interface is a problem. 
As Elektra explained choosing a default gateway by "inserting a default route" 
is meaningless (in a mesh). If each client should be able to choose its own 
gateway there is no way around the tunnel mechanism. 

If you dislike the masquerading (which is activated per default) you can learn 
here[0] how to disable it. If you really want to have the plain default route 
I suggest to use the --policy-routing-script [1] option to modify the routing 
tables on the fly.

Regards,
Marek


[0] http://www.open-mesh.net/wiki/InternetTuning
[1] http://www.open-mesh.net/wiki/RoutingVodoo

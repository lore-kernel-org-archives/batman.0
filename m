From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] problems detecting gw
Date: Wed, 21 May 2008 10:18:47 +0800
References: <e58370e60805200549w4160deaxc16af3005b684b2c@mail.gmail.com>
In-Reply-To: <e58370e60805200549w4160deaxc16af3005b684b2c@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200805211018.47816.lindner_marek@yahoo.de>
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

> 1- What is the procedure to identify gw?
>
> I have initiated the daemon in the node switched into a ethernet like -a
> 1.2.3.4/16 -g 7 -s 2.3.4.5
> Then in other nodes I begin the daemon in second option and always "No
> gateways in range..." is displayed.

on the gateway you have to activate the gateway class and on the client the 
routing class. Currently, you are using the old gateway class syntax. Please 
have a look at our doc section on open-mesh.net, especially 
http://open-mesh.net/batman/doc/InternetTuning


> 2- How to use the visualization server?
>
> Is possible to use the same interface of batman protocol to receive
> visualization info? or it should be an alias or something like that?
> As I understood I have to download s3d to display the vis info, is that
> correct?

The batman deamon and the vis server use different ports. Therefore you can 
use them on the same interface at the same time.
The vis server offers the graph information in the dot draw format. You can 
use any tool to visualize that which understands that format. One of them is 
s3d but there are others.

Greetings,
Marek


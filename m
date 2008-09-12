From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 12 Sep 2008 11:49:43 +0800
References: <5635aa0d0809110601h3e400ed8g3e0d82387a755917@mail.gmail.com>
	<200809121031.00697.lindner_marek@yahoo.de>
	<5635aa0d0809112012v1fbb67c4h663bf4fe4f063910@mail.gmail.com>
In-Reply-To: <5635aa0d0809112012v1fbb67c4h663bf4fe4f063910@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809121149.43323.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Batman never stabilizes a route for nodes
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

On Friday, 12. September 2008 11:12:21 Outback Dingo wrote:
> ok, im getting tcpdumps, this is a test bed of the same hardward atheros
> based Ubiquity NS2 devices running OpenWRT trunk

Then it is not related to your hw and the link posted earlier does not help 
here.


> http://pastebin.com/md162302 which is from last night 10PM

Your log is pretty interesting. It shows that the basic functionality is there 
but does not work reliably. The gateway is sending the keep alive reply to 
the client which further indicates that we don't have an endianess issue 
here.


> I also have 21 nodes, same hardware, running batgat which still crashed as
> Gustavo pointed out
> of which the logs were forwarded, the test bed has been setup to remove
> batgat and look for stability

Do you intend to test the latest stability patches from Sven ? May be it 
solves your problem. It would be interesting to find out why the network is 
less flaky if you use the module.


> im tcpdumping on both client and gateway now, ill forward the result of
> these logs in a bit
> as for wireshark ill make a build with that and see if i can get these logs
> also

Cool !

Greetings,
Marek

From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 12 Sep 2008 10:31:00 +0800
References: <5635aa0d0809110601h3e400ed8g3e0d82387a755917@mail.gmail.com>
In-Reply-To: <5635aa0d0809110601h3e400ed8g3e0d82387a755917@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809121031.00697.lindner_marek@yahoo.de>
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

On Thursday, 11. September 2008 21:01:11 Outback Dingo wrote:
> Batmand never established a stable route for clients, ie. they never get
> reliable internet, actually to be honest, they get 0 internet cause routing
> always loops

Please be precise here: Do you see routing loops or is your UDP connection not 
stable (as indicated by your log) ?


> i also found this thread from before showing a similiar issue
>
> https://list.open-mesh.net/pipermail/b.a.t.m.a.n/2007-September/000277.html

This may or may not apply here. I have a look into the code later. Do you use 
different hardware for your gateways and clients or always the same ?


> question is how do i get the routes to stabilize so the mesh functions

As I mentioned before we need a tcpdump of your traffic to help you. Even 
better would be a wireshark log from both ends that we can analyze.

Greetings,
Marek


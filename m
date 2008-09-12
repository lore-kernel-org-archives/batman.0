Message-ID: <5635aa0d0809112012v1fbb67c4h663bf4fe4f063910@mail.gmail.com>
Date: Fri, 12 Sep 2008 10:12:21 +0700
From: "Outback Dingo" <outbackdingo@gmail.com>
Subject: Re: [B.A.T.M.A.N.] Batman never stabilizes a route for nodes
In-Reply-To: <200809121031.00697.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_51977_7647568.1221189141488"
References: <5635aa0d0809110601h3e400ed8g3e0d82387a755917@mail.gmail.com>
	<200809121031.00697.lindner_marek@yahoo.de>
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

------=_Part_51977_7647568.1221189141488
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

ok, im getting tcpdumps, this is a test bed of the same hardward atheros
based Ubiquity NS2 devices running OpenWRT trunk
1 gateway -> 70 meters -> 1 node
no batgat, batmand running
it goes into this constant loop as shown in

http://pastebin.com/md162302 which is from last night 10PM

where the gateway and node continuously go into this ip expired loop for
5-15 minutes
causing routing for clients to go away, and network unstability, then it
appears to come back for a while

I also have 21 nodes, same hardware, running batgat which still crashed as
Gustavo pointed out
of which the logs were forwarded, the test bed has been setup to remove
batgat and look for stability

im tcpdumping on both client and gateway now, ill forward the result of
these logs in a bit
as for wireshark ill make a build with that and see if i can get these logs
also

On Fri, Sep 12, 2008 at 9:31 AM, Marek Lindner <lindner_marek@yahoo.de>wrote:

> On Thursday, 11. September 2008 21:01:11 Outback Dingo wrote:
> > Batmand never established a stable route for clients, ie. they never get
> > reliable internet, actually to be honest, they get 0 internet cause
> routing
> > always loops
>
> Please be precise here: Do you see routing loops or is your UDP connection
> not
> stable (as indicated by your log) ?
>
>
> > i also found this thread from before showing a similiar issue
> >
> >
> https://list.open-mesh.net/pipermail/b.a.t.m.a.n/2007-September/000277.html
>
> This may or may not apply here. I have a look into the code later. Do you
> use
> different hardware for your gateways and clients or always the same ?
>
>
> > question is how do i get the routes to stabilize so the mesh functions
>
> As I mentioned before we need a tcpdump of your traffic to help you. Even
> better would be a wireshark log from both ends that we can analyze.
>
> Greetings,
> Marek
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>

------=_Part_51977_7647568.1221189141488
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">ok, im getting tcpdumps, this is a test bed of the same hardward atheros based Ubiquity NS2 devices running OpenWRT trunk<br>1 gateway -&gt; 70 meters -&gt; 1 node <br>no batgat, batmand running<br>it goes into this constant loop as shown in <br>
<br><a href="http://pastebin.com/md162302">http://pastebin.com/md162302</a> which is from last night 10PM<br><br>where the gateway and node continuously go into this ip expired loop for 5-15 minutes<br>causing routing for clients to go away, and network unstability, then it appears to come back for a while<br>
<br>I also have 21 nodes, same hardware, running batgat which still crashed as Gustavo pointed out<br>of which the logs were forwarded, the test bed has been setup to remove batgat and look for stability<br><br>im tcpdumping on both client and gateway now, ill forward the result of these logs in a bit<br>
as for wireshark ill make a build with that and see if i can get these logs also<br><br><div class="gmail_quote">On Fri, Sep 12, 2008 at 9:31 AM, Marek Lindner <span dir="ltr">&lt;<a href="mailto:lindner_marek@yahoo.de">lindner_marek@yahoo.de</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class="Ih2E3d">On Thursday, 11. September 2008 21:01:11 Outback Dingo wrote:<br>
&gt; Batmand never established a stable route for clients, ie. they never get<br>
&gt; reliable internet, actually to be honest, they get 0 internet cause routing<br>
&gt; always loops<br>
<br>
</div>Please be precise here: Do you see routing loops or is your UDP connection not<br>
stable (as indicated by your log) ?<br>
<div class="Ih2E3d"><br>
<br>
&gt; i also found this thread from before showing a similiar issue<br>
&gt;<br>
&gt; <a href="https://list.open-mesh.net/pipermail/b.a.t.m.a.n/2007-September/000277.html" target="_blank">https://list.open-mesh.net/pipermail/b.a.t.m.a.n/2007-September/000277.html</a><br>
<br>
</div>This may or may not apply here. I have a look into the code later. Do you use<br>
different hardware for your gateways and clients or always the same ?<br>
<div class="Ih2E3d"><br>
<br>
&gt; question is how do i get the routes to stabilize so the mesh functions<br>
<br>
</div>As I mentioned before we need a tcpdump of your traffic to help you. Even<br>
better would be a wireshark log from both ends that we can analyze.<br>
<br>
Greetings,<br>
Marek<br>
<br>
_______________________________________________<br>
B.A.T.M.A.N mailing list<br>
<a href="mailto:B.A.T.M.A.N@open-mesh.net">B.A.T.M.A.N@open-mesh.net</a><br>
<a href="https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n" target="_blank">https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br>
</blockquote></div><br></div>

------=_Part_51977_7647568.1221189141488--

Message-ID: <a934d3f30804150308w5e95a196w11d38da87b52c422@mail.gmail.com>
Date: Tue, 15 Apr 2008 06:08:15 -0400
From: "Vinay Menon" <vinaymenon@gmail.com>
Subject: Re: [B.A.T.M.A.N.] Node keeps switching back and forth
In-Reply-To: <a934d3f30804150104w4c4c47fp766cce05ae014ae2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_334_18290395.1208254095756"
References: <7BE4D55B-B938-45A8-BCF4-923632152CFC@philippeapril.com>
	<a934d3f30804150104w4c4c47fp766cce05ae014ae2@mail.gmail.com>
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

------=_Part_334_18290395.1208254095756
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Seems like the gateway still crashes with clients connected  as -r 2 but
after a long time.I dont see a log message nither do i know when it crashed
but the non gateway node have been running for almost 48+ hrs without any
down time on lan.

Regards,

On Tue, Apr 15, 2008 at 4:04 AM, Vinay Menon <vinaymenon@gmail.com> wrote:

> Hello,
>
> I too am stuck at a similar case would where in my remote node keeps
> jumping on and off the gateway even tho it has better signal strength form
> node1 .
> i have node running as -r 2 atm when i had them on -r 3 the batman gateway
> crashed (batmand exited ungracefully leaving routes in table 66). now with
> -r2 it does not crash but keeps jumping at time.
>
> I am using batman (r 963) on kamikaze 7.09 with kernel 2.6.21 and tun on
> gateway .i only have batman as routing daemon and have masqueraded output
> interfaces (referring to a previous solution for the -r 3 crash) .
>
> Regards,
> Vinay
>
>
>
> On Mon, Apr 14, 2008 at 11:12 AM, Philippe April <
> isf_lists@philippeapril.com> wrote:
>
> > Hi!
> >
> > I setup 3 nodes on OpenWRT Kamikaze and B.A.T.M.A.N 0.3, using atheros
> > chipset.
> >
> > My gateway is started this way: batmand -g 5Mbit/1Mbit -a some_subnet...
> > ath0
> > My nodes: batmand -r 2 -a other_subnets... ath0
> >
> > Let's call them "gateway", "node1", "node2".
> >
> > "gateway" is in my basement.
> >
> > "node1" is upstairs.
> >
> > "node2" is in the shed.
> >
> > node1's connection to gateway is strong.
> > node2's connection to gateway is very weak, about 50% packet loss.
> > node2's connection to node1 is strong.
> >
> > Knowing this: does anybody have a clue to why my node2 keeps switching
> > from node1 to gateway? I connect to node2 and ping on the internet
> > constantly, I see the node switching back and forth from node1 to gateway,
> > sending some of my packets to one, or the other... basically the user
> > experience is horrible.
> >
> > I was missing FW masquerading rules until yesterday, things were not
> > working at all when I was not going through the gateway directly, but that
> > "seems" to be resolved, now packets go by "sometimes". If node2 could stick
> > to using node1, it would be easier to troubleshoot.
> >
> > I'm trying to move my nodes as far as I can so it can't connect to the
> > gateway directly at all from node2 but the shed does not seem to be far
> > enough :)
> >
> > Thanks for any enlightenment...
> >
> > Philippe April
> > _______________________________________________
> > B.A.T.M.A.N mailing list
> > B.A.T.M.A.N@open-mesh.net
> > https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
> >
>
>
>
> --
> Vinay Menon




-- 
Vinay Menon

------=_Part_334_18290395.1208254095756
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Seems like the gateway still crashes with clients connected&nbsp; as -r 2 but after a long time.I dont see a log message nither do i know when it crashed but the non gateway node have been running for almost 48+ hrs without any down time on lan.<br>
<br>Regards,<br><br><div class="gmail_quote">On Tue, Apr 15, 2008 at 4:04 AM, Vinay Menon &lt;<a href="mailto:vinaymenon@gmail.com">vinaymenon@gmail.com</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hello,<br><br>I too am stuck at a similar case would where in my remote node keeps jumping on and off the gateway even tho it has better signal strength form node1 .<br>i have node running as -r 2 atm when i had them on -r 3 the batman gateway crashed (batmand exited ungracefully leaving routes in table 66). now with -r2 it does not crash but keeps jumping at time. <br>

<br>I am using batman (r 963) on kamikaze 7.09 with kernel 2.6.21 and tun on gateway .i only have batman as routing daemon and have masqueraded output interfaces (referring to a previous solution for the -r 3 crash) .<br>

<br>Regards,<br>Vinay<div><div></div><div class="Wj3C7c"><br><br><br><div class="gmail_quote">On Mon, Apr 14, 2008 at 11:12 AM, Philippe April &lt;<a href="mailto:isf_lists@philippeapril.com" target="_blank">isf_lists@philippeapril.com</a>&gt; wrote:<br>

<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi!<br>
<br>
I setup 3 nodes on OpenWRT Kamikaze and B.A.T.M.A.N 0.3, using atheros chipset.<br>
<br>
My gateway is started this way: batmand -g 5Mbit/1Mbit -a some_subnet... ath0<br>
My nodes: batmand -r 2 -a other_subnets... ath0<br>
<br>
Let&#39;s call them &quot;gateway&quot;, &quot;node1&quot;, &quot;node2&quot;.<br>
<br>
&quot;gateway&quot; is in my basement.<br>
<br>
&quot;node1&quot; is upstairs.<br>
<br>
&quot;node2&quot; is in the shed.<br>
<br>
node1&#39;s connection to gateway is strong.<br>
node2&#39;s connection to gateway is very weak, about 50% packet loss.<br>
node2&#39;s connection to node1 is strong.<br>
<br>
Knowing this: does anybody have a clue to why my node2 keeps switching from node1 to gateway? I connect to node2 and ping on the internet constantly, I see the node switching back and forth from node1 to gateway, sending some of my packets to one, or the other... basically the user experience is horrible.<br>



<br>
I was missing FW masquerading rules until yesterday, things were not working at all when I was not going through the gateway directly, but that &quot;seems&quot; to be resolved, now packets go by &quot;sometimes&quot;. If node2 could stick to using node1, it would be easier to troubleshoot.<br>



<br>
I&#39;m trying to move my nodes as far as I can so it can&#39;t connect to the gateway directly at all from node2 but the shed does not seem to be far enough :)<br>
<br>
Thanks for any enlightenment...<br><font color="#888888">
<br>
Philippe April<br>
_______________________________________________<br>
B.A.T.M.A.N mailing list<br>
<a href="mailto:B.A.T.M.A.N@open-mesh.net" target="_blank">B.A.T.M.A.N@open-mesh.net</a><br>
<a href="https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n" target="_blank">https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br>
</font></blockquote></div><br><br clear="all"><br></div></div>-- <br><font color="#888888">Vinay Menon
</font></blockquote></div><br><br clear="all"><br>-- <br>Vinay Menon

------=_Part_334_18290395.1208254095756--

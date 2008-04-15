MIME-version: 1.0
Content-type: multipart/alternative;
	boundary="Boundary_(ID_vXjetGsMOl6U4K8eR5ezCQ)"
Message-id: <018CC2A5-4DD5-421B-AD00-AF9B3CC50D2B@philippeapril.com>
From: Philippe April <isf_lists@philippeapril.com>
In-reply-to: <a934d3f30804150104w4c4c47fp766cce05ae014ae2@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Node keeps switching back and forth
Date: Tue, 15 Apr 2008 13:31:39 -0400
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


--Boundary_(ID_vXjetGsMOl6U4K8eR5ezCQ)
Content-type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-transfer-encoding: 7BIT

I just found out why my node is switching! Now I need to know if  
there's a way to tell it not to :)

It switches because the quality (/ 255) varies from 230 to 255 in each  
direction.

As soon as signal from node2 to node1 goes down from let's say 250 to  
240, if another connection to the gateway's quality is 241, it'll  
switch as soon as it hits 240... Then when quality comes back up to  
242, it switches back to node1.

I don't think it's very good to switch as soon as the quality is  
higher somewhere else, it should at least "give it a chance" by either  
having a threshold, or switch only if it's been in a more degraded  
state for more than x minutes, etc.

Is there something I can do to influence that? Did I miss a command  
line argument?

Thank you!

On 15-Apr-08, at 4:04 AM, Vinay Menon wrote:

> Hello,
>
> I too am stuck at a similar case would where in my remote node keeps  
> jumping on and off the gateway even tho it has better signal  
> strength form node1 .
> i have node running as -r 2 atm when i had them on -r 3 the batman  
> gateway crashed (batmand exited ungracefully leaving routes in table  
> 66). now with -r2 it does not crash but keeps jumping at time.
>
> I am using batman (r 963) on kamikaze 7.09 with kernel 2.6.21 and  
> tun on gateway .i only have batman as routing daemon and have  
> masqueraded output interfaces (referring to a previous solution for  
> the -r 3 crash) .
>
> Regards,
> Vinay
>
>
> On Mon, Apr 14, 2008 at 11:12 AM, Philippe April <isf_lists@philippeapril.com 
> > wrote:
> Hi!
>
> I setup 3 nodes on OpenWRT Kamikaze and B.A.T.M.A.N 0.3, using  
> atheros chipset.
>
> My gateway is started this way: batmand -g 5Mbit/1Mbit -a  
> some_subnet... ath0
> My nodes: batmand -r 2 -a other_subnets... ath0
>
> Let's call them "gateway", "node1", "node2".
>
> "gateway" is in my basement.
>
> "node1" is upstairs.
>
> "node2" is in the shed.
>
> node1's connection to gateway is strong.
> node2's connection to gateway is very weak, about 50% packet loss.
> node2's connection to node1 is strong.
>
> Knowing this: does anybody have a clue to why my node2 keeps  
> switching from node1 to gateway? I connect to node2 and ping on the  
> internet constantly, I see the node switching back and forth from  
> node1 to gateway, sending some of my packets to one, or the other...  
> basically the user experience is horrible.
>
> I was missing FW masquerading rules until yesterday, things were not  
> working at all when I was not going through the gateway directly,  
> but that "seems" to be resolved, now packets go by "sometimes". If  
> node2 could stick to using node1, it would be easier to troubleshoot.
>
> I'm trying to move my nodes as far as I can so it can't connect to  
> the gateway directly at all from node2 but the shed does not seem to  
> be far enough :)
>
> Thanks for any enlightenment...
>
> Philippe April
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>
>
> -- 
> Vinay Menon _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


--Boundary_(ID_vXjetGsMOl6U4K8eR5ezCQ)
Content-type: text/html; charset=US-ASCII
Content-transfer-encoding: quoted-printable

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; "><div>I just found out why my =
node is switching! Now I need to know if there's a way to tell it not to =
:)</div><div><br></div><div>It switches because the quality (/ 255) =
varies from 230 to 255 in each direction.</div><div><br></div><div>As =
soon as signal from node2 to node1 goes down from let's say 250 to 240, =
if another connection to the gateway's quality is 241, it'll switch as =
soon as it hits 240... Then when quality comes back up to 242, it =
switches back to node1.</div><div><br></div><div>I don't think it's very =
good to switch as soon as the quality is higher somewhere else, it =
should at least "give it a chance" by either having a threshold, or =
switch only if it's been in a more degraded state for more than x =
minutes, etc.</div><div><br></div><div>Is there something I can do to =
influence that? Did I miss a command line =
argument?</div><div><br></div><div>Thank =
you!</div><div><br></div><div><html>On 15-Apr-08, at 4:04 AM, Vinay =
Menon wrote:</html><br class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite">Hello,<br><br>I too am stuck at a similar case would where =
in my remote node keeps jumping on and off the gateway even tho it has =
better signal strength form node1 .<br>i have node running as -r 2 atm =
when i had them on -r 3 the batman gateway crashed (batmand exited =
ungracefully leaving routes in table 66). now with -r2 it does not crash =
but keeps jumping at time. <br> <br>I am using batman (r 963) on =
kamikaze 7.09 with kernel 2.6.21 and tun on gateway .i only have batman =
as routing daemon and have masqueraded output interfaces (referring to a =
previous solution for the -r 3 crash) .<br> =
<br>Regards,<br>Vinay<br><br><br><div class=3D"gmail_quote">On Mon, Apr =
14, 2008 at 11:12 AM, Philippe April &lt;<a =
href=3D"mailto:isf_lists@philippeapril.com" =
target=3D"_blank">isf_lists@philippeapril.com</a>> wrote:<br> =
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid =
rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: =
1ex;">Hi!<br> <br> I setup 3 nodes on OpenWRT Kamikaze and B.A.T.M.A.N =
0.3, using atheros chipset.<br> <br> My gateway is started this way: =
batmand -g 5Mbit/1Mbit -a some_subnet... ath0<br> My nodes: batmand -r 2 =
-a other_subnets... ath0<br> <br> Let's call them "gateway", "node1", =
"node2".<br> <br> "gateway" is in my basement.<br> <br> "node1" is =
upstairs.<br> <br> "node2" is in the shed.<br> <br> node1's connection =
to gateway is strong.<br> node2's connection to gateway is very weak, =
about 50% packet loss.<br> node2's connection to node1 is strong.<br> =
<br> Knowing this: does anybody have a clue to why my node2 keeps =
switching from node1 to gateway? I connect to node2 and ping on the =
internet constantly, I see the node switching back and forth from node1 =
to gateway, sending some of my packets to one, or the other... basically =
the user experience is horrible.<br> <br> I was missing FW masquerading =
rules until yesterday, things were not working at all when I was not =
going through the gateway directly, but that "seems" to be resolved, now =
packets go by "sometimes". If node2 could stick to using node1, it would =
be easier to troubleshoot.<br> <br> I'm trying to move my nodes as far =
as I can so it can't connect to the gateway directly at all from node2 =
but the shed does not seem to be far enough :)<br> <br> Thanks for any =
enlightenment...<br><font color=3D"#888888"> <br> Philippe April<br> =
_______________________________________________<br> B.A.T.M.A.N mailing =
list<br> <a href=3D"mailto:B.A.T.M.A.N@open-mesh.net" =
target=3D"_blank">B.A.T.M.A.N@open-mesh.net</a><br> <a =
href=3D"https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n" =
target=3D"_blank">https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><b=
r> </font></blockquote></div><br><br clear=3D"all"><br>-- <br>Vinay =
Menon _______________________________________________<br>B.A.T.M.A.N =
mailing list<br><a =
href=3D"mailto:B.A.T.M.A.N@open-mesh.net">B.A.T.M.A.N@open-mesh.net</a><br=
>https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n<br></blockquote></div>=
<br></body></html>=

--Boundary_(ID_vXjetGsMOl6U4K8eR5ezCQ)--

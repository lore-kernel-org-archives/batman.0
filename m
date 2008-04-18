Message-ID: <a934d3f30804180701v295ac423qe910e5d881b321b5@mail.gmail.com>
Date: Fri, 18 Apr 2008 10:01:59 -0400
From: "Vinay Menon" <vinaymenon@gmail.com>
Subject: Re: [B.A.T.M.A.N.] Node keeps switching back and forth
In-Reply-To: <C3F5B343-E97B-4745-8007-01C66906860E@philippeapril.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_1887_21822729.1208527319342"
References: <7BE4D55B-B938-45A8-BCF4-923632152CFC@philippeapril.com>
	<854CEDF6-8307-4BB8-AFD0-EAC208163FE3@gmail.com>
	<B0598FDC-F54D-4D67-BEE2-670F6BD8A064@philippeapril.com>
	<200804181448.44510.lindner_marek@yahoo.de>
	<48902.85.41.146.90.1208503463.squirrel@krisma.oltrelinux.com>
	<C3F5B343-E97B-4745-8007-01C66906860E@philippeapril.com>
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

------=_Part_1887_21822729.1208527319342
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> " as it's no longer related to BATMAN which seems to work great except
> some firewall issues I'm having related to packets tagged as "INVALID"."


I too had seen this (as well as had informed about it to Marek over irc) but
later couldn't dint spend time replicating it.
For some reason batman was not working with INVALID state detection in
FORWARD chain.

So Philippe is your problem solved ? i am in the process of upgrading the
firmware to latest openwrt trunk. as after rearranging nodes and fixing
diversity my hopping problem is some what solved but batman on gateway still
crashes after around 6-7 hrs of uptime on Kamikaze 7.09 (kernel 2.6.21)


-- 
Vinay Menon

------=_Part_1887_21822729.1208527319342
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&quot; as it&#39;s no longer related to BATMAN which seems to work great except some firewall issues I&#39;m having related to packets tagged as &quot;INVALID&quot;.&quot;</blockquote>
<div><br>I too had seen this (as well as had informed about it to Marek over irc) but later couldn&#39;t dint spend time replicating it.<br>For some reason batman was not working with INVALID state detection in FORWARD chain.<br>
<br>So Philippe is your problem solved ? i am in the process of upgrading the firmware to latest openwrt trunk. as after rearranging nodes and fixing diversity my hopping problem is some what solved but batman on gateway still crashes after around 6-7 hrs of uptime on Kamikaze 7.09 (kernel 2.6.21)<br>
<br></div></div><br>-- <br>Vinay Menon

------=_Part_1887_21822729.1208527319342--

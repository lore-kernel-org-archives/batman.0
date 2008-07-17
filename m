Message-ID: <487FC8BB.6010707@reglue.org>
Date: Thu, 17 Jul 2008 17:33:31 -0500
From: Don Davis <dondavis@reglue.org>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Batman 0.3 + Freifunk setup questions
References: <487F60E5.5000003@reglue.org>
	<487F77DF.8050305@reglue.org>	<487F9142.9000704@reglue.org>
	<487FA7DD.7080607@reglue.org>
	<20080717220707.GA9314@hrz.tu-chemnitz.de>
In-Reply-To: <20080717220707.GA9314@hrz.tu-chemnitz.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

Simon Wunderlich wrote:
> On Thu, Jul 17, 2008 at 03:13:17PM -0500, Don Davis wrote:
>> batmand -g 5mb eth1 vlan1 #for gw?
> Hello Don,
> 
> try "-g 5mbit" instead of "-g 5mb". Seems this wrong option is silently
> ignored ...
> 
> best regards,
> 	Simon
> 
Thank you.  That did do the trick.

Is the gateway detection for announced gateways?
Is there a script that can probe to see if the router is a gateway and 
if so make it available?

I was under the mistaken impression that because I hadn't configured 
olsr (nor had I disabled it) that I was not running OLSR.  Thanks to 
Sven Ola it seems that it was a zero conf olsr.  Without specifying 
ifconfig eth1:bat 10.0.5.* the batmand eth1  command seemed to work (the 
same for batmand -g 5mbit eth1 vlan1) and batmand -c -d 1/2/3/4 show 
batman running.


Is it normal that I have to kill and restart batman for the new gateway 
to be noticed?

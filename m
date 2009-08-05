Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 5 Aug 2009 15:33:25 +0800
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908051533.26117.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Routing help?
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
To: b.a.t.m.a.n@lists.open-mesh.net


Hi,

>I have 3 linksys wrt54 flashed with openwrt 7.09, webif'ed and installed
> BATMAN 0.2-rv478.1, all OK I think.

not sure what web interface you installed but are you aware of the fact that 
revision 478 is more than 2 years old ? Your current problem seems unrelated 
to batman but if you experience trouble / bugs with batman it might be wise to 
upgrade to the latest stable release.


From the ssh prompt on .3 I can ping .2 with no loss and ping .1 with  ~ 6%
> loss. However, if I try to ping .1 from the pc connected on the ethernet
> port of .3 I get no route to host. Putting wireshark on the ethernet ifc
> shows the arp going out but nothing coming back. Interestingly enough if I
> ssh into .3 and ping .1, with wireshark running on the ethernet of .3 Is
> see the outgoing ICMP but not the reply (which is there because the ping
> succeeds) . It seems as if the local host traffic is not truly bridged.

You bridged the LAN & WLAN on every device but the devices are not bridged 
with each other, hence you mix bridges & routing. 

What IP address did you assign to your PC ? Does your PC have a route towards 
the .1 (probably not) ? You also have make sure that all nodes have a route 
towards your PC. You can achieve that using HNA. See:
http://www.open-mesh.net/wiki/AnnouncingNetworks for a detailed explanation.

Regards,
Marek



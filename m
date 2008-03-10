Message-ID: <47D51FD7.7040500@gmx.net>
Date: Mon, 10 Mar 2008 12:47:35 +0100
From: elektra <onelektra@gmx.net>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] b.a.t.m.a.n. + wrt54gl + OpenWrt Kamikaze +  
	X-wrt]
References: <51526.70.253.200.118.1205126321.squirrel@webmail.reglue.org>	<47D505FF.9090209@gmx.net>
	<1205147873.8126.12.camel@krupskaya.is-a-geek.net.is-a-geek.net>
In-Reply-To: <1205147873.8126.12.camel@krupskaya.is-a-geek.net.is-a-geek.net>
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
To: dondavis@reglue.org, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Donald Davis wrote:
> Thank you.  That's pretty fundamental I imagine.  I thought that the
> bssid (mac addresses) would have been expected to be different for
> tracking purposes. 
>   
The Mac of each card is still present, of course. The BSSID is necessary 
to tell whether a node logically belongs to a WiFi cell or not. Note 
that the process of negotiating the BSSID is error prone. Not if you use 
only WRTs, but if you want other cards to connect to the ad-hoc cell. In 
order to make your network stable you should fix the BSSID manually, 
which is a hack available for OpenWRT. Check out with your favorite 
search engine.

> Will the startup script I mentioned interfere with anything? 
No.
>  Do I need
> to set lan IP? wan IP?  
If you want to use them for networking on layer 3 of the OSI model - of 
course! Even if you want to bridge them you should always assign an IP 
address - at least for the bridge - for maintenance purposes, in order 
to access the device.

Btw.: IANA has assigned port 4305 for the newer versions of Batman. So 
if you are going to update to Experimental or Beta open the firewall for 
udp ports 4305 and 4306 instead of 1966. 4305 is for protocol messages, 
4306 is used for tunneling traffic to the gateway.  If you want to use 
the VIS server, open port 4307 also.



cu elektra


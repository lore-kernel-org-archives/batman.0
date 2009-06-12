From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 13 Jun 2009 06:24:53 +0800
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200906130624.54069.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] batman 0.3.2 released
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


Hi folks,

the B.A.T.M.A.N. team is releasing the second bugfix and maintenance release of 
the 0.3 batman daemon which also contains smaller enhancements in various 
areas. It's mostly an update to batman 0.3 and does not contain major routing 
protocol changes. We offer precompiled packages
http://downloads.open-mesh.net/batman/stable/binaries/
as well as signed source tarballs:
http://downloads.open-mesh.net/batman/stable/sources/

In the past many new users experienced difficulties using batman to connect to 
the internet as it was necessary to enable NAT on the tunnel manually. With 
this release we address this issue. The batman daemon will try to locate the 
iptables binary to setup the masquerading automatically. This behaviour can be 
disabled using the "--disable-client-nat" option. If the outgoing packets are 
not masqueraded (the iptables binary wasn't found / the automatism disabled) 
batman will switch to the "half tunnel" mode which operates without 
masquerading. This mode requires the gateway to have a routing entry for each 
client that accesses the internet (e.g. non-batman clients may be announced 
via HNA).

The whole HNA code has been rewritten and now supports multiple nodes 
announcing the same network segment. You may have one non-batman network but 
several entry points to it. All border nodes can announce the same network. 
Receiving batman nodes choose their entry point based on the best TQ value 
available. The packet aggregation that exists since batman 0.3 has been 
enabled by default. 

Thanks to Benjamin Henrions persistence the hop penalty was modified to make 
use of multi radio interfaces to maximize throughput. Nathan Wharton and Sven 
Eckelmann debugged alignment issues on Avila boards. Sven also improved the 
kernel routing communication and contributed many more patches. Antoine van 
Gelder developed an extension for the vis server that allows the vis server to 
export its data in the JSON format if it was started using the "-j" parameter.

In the coming months we want to focus on improving the protocol. Therefore we 
will start the batman 0.4 branch soon.

Happy routing,
The B.A.T.M.A.N. team



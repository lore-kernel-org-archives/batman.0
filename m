From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] 0.3.1 rv1152 - some test results
Date: Mon, 1 Dec 2008 12:19:34 +0800
References: <492DDC20.7090900@web.de>
	<200811290835.26929.lindner_marek@yahoo.de>
	<49331715.5020602@web.de>
In-Reply-To: <49331715.5020602@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200812011219.39242.lindner_marek@yahoo.de>
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

On Monday 01 December 2008 06:43:33 Chris W. wrote:
> You're right, modules are an individual thing. I rather hoped for a hint
> to a  backported openwrt-0.9 makefile ;-).

I'm not sure what an "openwrt-0.9" is but may be this helps you:
https://dev.open-mesh.net/batman/wiki/Patches


> It is working as you described, here it takes about one minute to switch
> to an active gateway.

Yeah, it always takes one minute - its the internal timeout for inactive 
gateways.  :-)

By the way, you still can ping around and test the connection yourself. Either 
by using a simple cron script which runs every x minutes or by triggering your 
test script via the routing script. Depending on your setup/firewall/ISP you 
might experience problems pinging around. Also, if your users expect the 
internet to work for 2 hours per day you waste time and bandwidth in the other 
22 hours of the day.

Regards,
Marek


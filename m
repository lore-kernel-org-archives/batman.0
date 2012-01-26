Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 27 Jan 2012 03:13:19 +0800
References: <9AAB212A-A9C6-41CD-BACA-0BA1542FA8F5@net-forces.com>
In-Reply-To: <9AAB212A-A9C6-41CD-BACA-0BA1542FA8F5@net-forces.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201201270313.19652.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] ap_isolation issue
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


Hi,

>   We are trying to get OpenWRT with batman-adv 2011.4.0 to play nice using
> ap_isolation. However as soon as ap_isolation is turned on the meshed ap
> are not acessible anymore by our Linux firewall on which at least 1 ap
> node is physically connected. The following pastebin post shows the exact
> configuration and details:
> 
> 	http://pastebin.com/2bghWLkp

how is the Linux firewall connected to batman-adv-AP#1 ? Via eth0 ? 
Can you please also add the output of "batctl if" and "batctl sn" on all 
devices ?

What happens if you disable the bridge loop avoidance ? Does it have any 
effect ?

You are implying that disabling and then re-enabling the ap isolation also 
fixes the "ping problem" ? 

Regards,
Marek

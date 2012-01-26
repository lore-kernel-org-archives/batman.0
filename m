Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 27 Jan 2012 04:45:49 +0800
References: <9AAB212A-A9C6-41CD-BACA-0BA1542FA8F5@net-forces.com>
	<201201270313.19652.lindner_marek@yahoo.de>
	<53319420-548B-407C-94EA-AD8BA1B3F73C@net-forces.com>
In-Reply-To: <53319420-548B-407C-94EA-AD8BA1B3F73C@net-forces.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201201270445.50388.lindner_marek@yahoo.de>
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

On Friday, January 27, 2012 04:39:24 Andre Courchesne wrote:
> Sorry for the reply on the other post, getting tired I guess...
> 
> 
> So...
> 
> Ok, disabling loop avoidance has no effect.
> 
> Has ap_isolation been tested in this type of scenario?

Antonio is the real expert on the AP isolation but judging your debug output 
I'd say the AP isolation has nothing to do with your problem. Also, the 
disable/enable action seems to point into the same direction.

The AP isolation only drops packets from wireless clients. You should see a 
"W" in the flags section of the "batctl tg" dump:
02:69:fe:45:a3:cf  (  1) via ae:86:74:01:b4:94     (  2)   [...]
Try connecting with a wireless device and you will see it. Unless we have a 
bug the traffic from the linux firewall should not be dropped (I see no W).

You could get packet dumps to find out where the pings are dropped. Maybe that 
brings us closer to understanding what is going on.

Regards,
Marek

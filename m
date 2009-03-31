Message-ID: <20090331212304.82212h1pad739qjc@mail.tu-chemnitz.de>
Date: Tue, 31 Mar 2009 21:23:04 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
References: <49D2300C.9010206@kait.de>
In-Reply-To: <49D2300C.9010206@kait.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Batman-adv nodes do not recieve OGMs
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
To: b.a.t.m.a.n@open-mesh.net

Hello Kai,

Quoting Kai Timmer <email@kait.de>:
> Hello,
> i have a problem using batman-adv. At the moment i use v0.1, but i had
> the same problem when trying the svn version 1241.
>
> All the nodes send their ogm, but none does recieve any of these. What i
> did on all nodes is:
>
> iwconfig $wlaninterface essid batman mode ad-hoc
> and then
> echo "$wlaninterface" > /proc/net/batman-adv/interfaces
> echo 15 > /proc/net/batman-adv/log_level
>
> cat /proc/net/batman-adv/log after that shows somethink like this:
>
> Adding interface: ath0
> Can't activate module: the primary interface is not active
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

are you sure you set ath0 up?

ifconfig ath0 up

should do the trick.

If you start experimenting, a good idea is to first check the  
connectivity without batman. Just set some IP addresses on the wifi  
devices and ping the other nodes to make sure your adhoc network  
works. If it does, you can activate batman-adv. :)

good luck,
     Simon



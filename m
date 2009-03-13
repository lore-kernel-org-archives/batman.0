From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 13 Mar 2009 10:11:37 +0800
References: <49B825BE.4040605@java-system.com>
	<200903112214.44339.onelektra@gmx.net>
	<49B98151.2010906@java-system.com>
In-Reply-To: <49B98151.2010906@java-system.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200903131012.01212.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Unable to connect to internet
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


Hi,

> root@OpenWrt:~# batmand -a 192.168.0.1/24 -g 1000 -d 3 ath0
> WARNING: You are using the unstable batman branch. If you are interested
> in *using* batman get the latest stable release !
> Interface activated: ath0
> Using interface ath0 with address 192.168.2.200 and broadcast address
> 192.168.2.255
> B.A.T.M.A.N. 0.3-beta (compatibility version 5)

are you using the latest version ? Elektra reported a bug if you use the 
latest version together with the "-a" option. As a result the node that runs 
with that option enabled does not see any neighbours. Can you confirm that ?


> It seems batman set a gate0 interface with 169.254.x.x IP address
> How can I use this one with my 192.168.0.1 ADSL router?

You can safely ignore the 169.254.x.x addresses. Batman uses that for its 
internal tunneling mechanism which should not concern you.
Does your setup work now or not ?

Regards,
Marek


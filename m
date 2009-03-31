From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 1 Apr 2009 02:15:19 +0800
References: <49D2300C.9010206@kait.de>
In-Reply-To: <49D2300C.9010206@kait.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200904010215.44621.lindner_marek@yahoo.de>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


Hi,

> the same problem when trying the svn version 1241.

please don't use the trunk for batman-adv as it has a serious bug that 
requires fixing.


> Adding interface: ath0
> Can't activate module: the primary interface is not active

I think this message gives you a pretty good idea of what the problem might 
be. I guess your interface ath0 is not up & running. Try an "ifconfig ath0 up".  
:-)

Regards,
Marek


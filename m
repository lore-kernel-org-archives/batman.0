Message-ID: <489118AA.7020905@gmx.net>
Date: Thu, 31 Jul 2008 03:43:06 +0200
From: elektra <onelektra@gmx.net>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Multi-card MESH
References: <59864.212.147.148.167.1217448919.squirrel@www.rivertowermail.com>
In-Reply-To: <59864.212.147.148.167.1217448919.squirrel@www.rivertowermail.com>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
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

Hi -


 > Is it possible to use BATMAN with two backbone network cards?


multiple network interfaces are supported, but the current routing 
metric is based on packet loss and hop count, not actual throughput - 
this is likely to be suboptimal in some scenarios. Please go ahead and 
test if it does fit your purpose.

cu elektra

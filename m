From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] two-way-tunnel quirks
Date: Thu, 6 Dec 2007 04:18:37 +0100
References: <20071130232852.GC3934@apoderado.ometepe.net>
	<200712012141.59334.axel@open-mesh.net>
	<20071202053915.GC3923@apoderado.ometepe.net>
In-Reply-To: <20071202053915.GC3923@apoderado.ometepe.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200712060418.37610.lindner_marek@yahoo.de>
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


Hi,

> ok, set mtu on upstream gw to 1400, and everything remains as before :-(
> (didn't check at the upstream gw yet, but from inside the mesh i can
> also access hotmail when 1-way-tunnel, and not access hotmail when
> 2-way-tunnel)
> and tried another one with mtu 1200... still the same, seems not
> related.

one more idea: Do you clamp the MSS on the batman gateway client ?
It is somehow related to the MTU problem.
You can try this iptables command:
iptables -I FORWARD -p tcp --tcp-flags SYN,RST SYN -j 
TCPMSS --clamp-mss-to-pmtu

Regards,
Marek

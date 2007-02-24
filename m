From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Announcement: batman 0.2 alpha released
Date: Sat, 24 Feb 2007 10:12:28 +0100
References: <200702211328.24551.lindner_marek@yahoo.de>
In-Reply-To: <200702211328.24551.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200702241012.28109.lindner_marek@yahoo.de>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net


Hi,


> The 0.2 release will be fully backward compatible to 0.1.1 and above. That
> enables you to use the stable branch for most of your network and try 0.2
> alpha on test machines.

sorry - little mistake here.
0.1.1 ist *not* compatible with 0.1.2 and above. If you intend to test 0.2 in 
your network you have to upgrade all your hosts to 0.1.2.
The Big Endian / Little Endian support causes the incompability (every packet 
is sent in Host Byte Order). The result is that batman can't do the ranking 
because the counter gets never higher than 1:

172.28.4.3, GW: 172.28.4.3(1) via: 172.28.4.3(1)

Regards,
Marek

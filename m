Message-ID: <475835EF.1030306@leipzig.freifunk.net>
Date: Thu, 06 Dec 2007 18:48:31 +0100
From: tetzlav <tetzlav@leipzig.freifunk.net>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] strange batman aborting
References: <20071206023407.GA4041@apoderado.ometepe.net>
In-Reply-To: <20071206023407.GA4041@apoderado.ometepe.net>
Content-Type: text/plain; charset=ISO-8859-15
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

Jan Hetges schrieb:
> Only unnormal in the log:
>  user.warn kernel: nf_conntrack: table full, dropping packet.
> any ideas?

I've had the same Problem (independent from batmand) on some kamikaze-boxes.
You can try to enlarge the max-memory for conntrack (default is 2048):

> root@MB-1-WDS:~$ sysctl net.ipv4.netfilter.ip_conntrack_max
> net.ipv4.netfilter.ip_conntrack_max = 2048
> root@MB-1-WDS:~$ sysctl -w net.ipv4.netfilter.ip_conntrack_max=8192
> net.ipv4.netfilter.ip_conntrack_max = 8192
> root@MB-1-WDS:~$ sysctl net.ipv4.netfilter.ip_conntrack_max       
> net.ipv4.netfilter.ip_conntrack_max = 8192

append something like this to /etc/sysctl.conf
net.ipv4.netfilter.ip_conntrack_max=8192


Regards
tetzlav

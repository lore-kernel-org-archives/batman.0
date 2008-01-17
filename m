Message-ID: <20080117140452.sf4w0jir48sgwsw0@webmail.ddmesh.de>
Date: Thu, 17 Jan 2008 14:04:52 +0100
From: Freifunk Dresden <freifunk@ddmesh.de>
Subject: Re: [B.A.T.M.A.N.] Memory leak
References: <20080104105751.q5lswookggc040gk@webmail.ddmesh.de>
	<200801042124.18425.axel@open-mesh.net>
In-Reply-To: <200801042124.18425.axel@open-mesh.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
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
To: b.a.t.m.a.n@open-mesh.net

Hi,

has anyone could verify the memory-leak problem (see previous thread).
I'm currently use the -one-way-tunnel which does not destroy/recreate
the gw thread that is causing the memory consumtion.

jfi: the system is whiterussian rc6, busybox 1.7.2/1.8.2, uclibc 0.27.
I still couldn't get uclibc 29 running to check if this causes the problem.
Can somebody check this or first verify the problem?

/Stephan

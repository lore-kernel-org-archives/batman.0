Message-ID: <20080110092554.5ef5wili0c0ogoss@webmail.ddmesh.de>
Date: Thu, 10 Jan 2008 09:25:54 +0100
From: Freifunk Dresden <freifunk@ddmesh.de>
Subject: Re: [B.A.T.M.A.N.] one-way / two-way tunnel (was: Memory leak)
References: <20080104105751.q5lswookggc040gk@webmail.ddmesh.de>
	<200801071045.10747.axel@open-mesh.net>
	<20080107135602.eigmai3tpko40c40@webmail.ddmesh.de>
	<200801071748.36253.axel@open-mesh.net>
In-Reply-To: <200801071748.36253.axel@open-mesh.net>
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

I have compiled batmand (whiterussian_rc6) with the CFLAGS you provide.
There is no change in the behavior when calling "batmand -c -r0" and
"batmand -c -r3". On every thread creation the memory consumption rises.

I also have tried to apply "--one-way-tunnel 1 --two-way-tunnel 0"
Using the commands above I have the same result.
One advantage of the one-way-tunnel is, that the gateway thread is not  
killed and
re-created.

/Stephan

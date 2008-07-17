Message-ID: <487F9142.9000704@reglue.org>
Date: Thu, 17 Jul 2008 13:36:50 -0500
From: Don Davis <dondavis@reglue.org>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Batman 0.3 + Freifunk setup questions
References: <487F60E5.5000003@reglue.org> <487F77DF.8050305@reglue.org>
In-Reply-To: <487F77DF.8050305@reglue.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Does batmand 0.3 automatically identify gateways?

I notice that simply typing
batmand -g 8 eth1 isn't enough to identify a new gateway.  Do I have to 
restart batmand on all the nodes?  or specify batmand -p newgwip -r 3 
eth1 to get them to identify the new gateway?

I thought there was a way to automatically use a gw if another gw was 
down?

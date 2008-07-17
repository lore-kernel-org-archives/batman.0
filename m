Message-ID: <487F77DF.8050305@reglue.org>
Date: Thu, 17 Jul 2008 11:48:31 -0500
From: Don Davis <dondavis@reglue.org>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Batman 0.3 + Freifunk setup questions
References: <487F60E5.5000003@reglue.org>
In-Reply-To: <487F60E5.5000003@reglue.org>
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

I guess it was a minor mystery that I had 0.2 working.  I've gone 
through and purged the nvram and set wlan with it's own LAN ip.  As long 
as I only run batman on the wireless interface things seem quite smooth 
and easy.

ff1# batmand -g 8 eth1
ff2# batmand eth1

It finds the gateway, there's internet access.  Any suggestions for an 
init script?

In 0.2 I successfully ran batmand br0 and things worked fine.  Trying 
that in 0.3 just locked things up.


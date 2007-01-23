Date: Tue, 23 Jan 2007 10:45:40 +0100 (MET)
From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Plug-ins
References: <BAY121-DAV4E72170A917AAE7B91EC5AFAE0@phx.gbl>
In-Reply-To: <BAY121-DAV4E72170A917AAE7B91EC5AFAE0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701231039.19182.lindner_marek@yahoo.de>
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


> Just wondering if there are any plans to introduce a plug-in interface to
> BATMAN?  I am especially keen to see a Nameservice plugin, or any other
> service advertisement-type plugin.

the main idea behind batman is to create a small, lightweight and easy to use 
routing daemon. Without bloating the code or "spamming" the network with 
unneccessary traffic.  Hence no such plug-in interface is planned or wanted 
at the moment.
Personally, I like the concept of creating these features one layer above 
batman so that these "services" can run indepently from the routing 
algorithm. Currently FX from Phenoelit is working on a nameservice which does 
exactly that.

Regards,
Marek

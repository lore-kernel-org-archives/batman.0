From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] dynamic gateway / hna / services
Date: Sat, 4 Aug 2007 12:34:46 +0200
References: <20070803113132.f7ij8uf21xwsog8o@webmail.ddmesh.de>
In-Reply-To: <20070803113132.f7ij8uf21xwsog8o@webmail.ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200708041234.46321.lindner_marek@yahoo.de>
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


> > I also like the idea of dynamically changing some parameters but on
> > the other hand, what are the negative side-effects of restarting a
> > daemon ?  - A client connected to the daemon might temporary loose
> > connection
> >  - Do you know others?
>
> I think the first point is important enough. see the statement above.

at the moment we have more important issues to address than a broken debug 
client connection I think. But we happily accept patches if ou want to 
improve the current situation. 
Note: This problem is more complicated than it might seem. You will have to 
pay attention to various race conditions.


> I have looked through the code and have seen that the HNA is simply
> appended to
> the end of a message. if we want to send other information a TLV structure
> is needed (Tag-length-value). Batmand can ignore unknown Tags and is
> still working in the network. At moment the whole network needs an
> update at same time, because old batmand will interpret any data as HNA.
> I hope I'm not wrong :)

You are right. But why should we append random data to flood the network ? Why 
can't we use _existing_ and _working_ solutions for service discovery ?
Did you read the discussion regarding this topic which was started by you ?

Regards,
Marek

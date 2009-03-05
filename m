From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 5 Mar 2009 19:14:01 +0800
References: <200903032126.57456.pmazart@web.de>
	<200903051155.16975.pmazart@web.de>
In-Reply-To: <200903051155.16975.pmazart@web.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <200903051914.02114.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] =?utf-8?q?Hiding_Local_Topology_=E2=80=93_TTL?=
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

On Thursday 05 March 2009 18:55:16 P. Mazart wrote:
> > How do I exactly set the TTL-Value for one or more of the specified
> > interfaces?

This paper just mentions the possibilities - not all flavors implement that=
=20
feature. As far as I know bmx (batman-experimental) supports it though.


> How about the vis-server? Does it need  a route back to the Source?
> (i.e. an =E2=80=9Einvisible=E2=80=9C back-bone-node)

A route back to the source? The packets sent to the vis server are UDP pack=
ets=20
which require no ACK.


> How often does BM send its status to the vis server?

The interval depends on the implementation - tcpdump can help you to check=
=20
your daemon.  :-)

Regards,
Marek


